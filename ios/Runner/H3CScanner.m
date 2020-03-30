//
//  H3CScanner.m
//  QRScan
//
//  Created by yangl on 2019/1/9.
//  Copyright © 2019 yangl. All rights reserved.
//

#import "H3CScanner.h"
#import <AVFoundation/AVFoundation.h>
#import <Vision/Vision.h>
#import <CoreImage/CoreImage.h>
#import "H3CScanerMaskLayer.h"

@interface H3CScanner() <AVCaptureVideoDataOutputSampleBufferDelegate>

@property (nonatomic, assign) CGRect scanFrame;
@property (nonatomic, weak) UIView *parentView;
@property (nonatomic, copy) H3CScanerCompletion completion;
@property (nonatomic, strong) CIDetector *detector;

@end


@implementation H3CScanner {
    AVCaptureSession *_session;
    AVCaptureDevice *_device;
    AVCaptureVideoPreviewLayer *_previewLayer;
    H3CScanerMaskLayer *_maskLayer;
}

#pragma mark - life cycle

- (instancetype)init NS_UNAVAILABLE{
    return nil;
}

- (instancetype)initWithScanFrame:(CGRect)scanFrame onParentView:(UIView *)view completion:(H3CScanerCompletion)completion {
    self = [super init];
    if (self) {
        _scanFrame = scanFrame;
        self.parentView = view;
        self.completion = completion;
        _detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
        [self setupSession];
    }
    
    return self;
}

+ (instancetype)scannerWithScanFrame:(CGRect)scanFrame onParentView:(UIView *)view completion:(H3CScanerCompletion)completion {
    NSAssert(completion != nil, @"Must callback scaner results!");
    return [[self alloc] initWithScanFrame:scanFrame onParentView:view completion:completion];
}

#pragma mark - configure

- (void)setupSession {
    // create session  前后台切换session的running状态会自动切换, 页面切换session需要手动开启关闭
    _session = [[AVCaptureSession alloc] init];
    [_session addObserver:self forKeyPath:@"running" options:NSKeyValueObservingOptionNew context:nil];
    // create device and input
    _device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    AVCaptureDeviceInput *deviceInput = [[AVCaptureDeviceInput alloc] initWithDevice:_device error:nil];
    
    // create output
    AVCaptureVideoDataOutput *videoOutput = [[AVCaptureVideoDataOutput alloc] init];
    AVCaptureMetadataOutput *videoMetaOutput = [[AVCaptureMetadataOutput alloc] init];
    
    // session connect
    if ([_session canAddInput:deviceInput]) {
        [_session addInput:deviceInput];
    }
    if ([_session canAddOutput:videoOutput]) {
        [_session addOutput:videoOutput];
    }
    if ([_session canAddOutput:videoMetaOutput]) {
        [_session addOutput:videoMetaOutput];
    }
    
    // create preview
    [self setupPreviewLayer];
    
    // set output
//    [videoOutput setSampleBufferDelegate:self queue:dispatch_get_main_queue()];
    [videoOutput setSampleBufferDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    [videoMetaOutput setMetadataObjectsDelegate:self queue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)];
    videoMetaOutput.metadataObjectTypes = @[AVMetadataObjectTypeEAN8Code, AVMetadataObjectTypeEAN13Code, AVMetadataObjectTypeCode128Code];
}

// 相机预览设置

- (void)setupPreviewLayer {
    _previewLayer = [[AVCaptureVideoPreviewLayer alloc] initWithSession:_session];
    _previewLayer.videoGravity = AVLayerVideoGravityResizeAspectFill;
    _previewLayer.frame = self.parentView.frame;
    [self.parentView.layer addSublayer:_previewLayer];
    
    _maskLayer = [H3CScanerMaskLayer maskLayerWithFrame:_previewLayer.bounds cropRect:self.scanFrame];
    [_maskLayer setNeedsDisplay];
    [self.parentView.layer addSublayer:_maskLayer];
}


#pragma mark - Still Image Scan
+ (void)scanImage:(UIImage *)image completion:(H3CScanerCompletion)completion {
    NSAssert(completion != nil, @"Must callback scaner results!");
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CIImage *scanImage = [[CIImage alloc] initWithImage:image];
        CIDetector *detector = [CIDetector detectorOfType:CIDetectorTypeQRCode context:nil options:nil];
        NSArray *featureArray = [detector featuresInImage:scanImage];
        
        if (featureArray.count == 1) {
            CIQRCodeFeature *qrCodeFeature = featureArray[0];
            dispatch_async(dispatch_get_main_queue(), ^{
                completion(qrCodeFeature.messageString);
            });
        } else {
            completion(@"");
        }
    });
}

#pragma mark - AVCaptureVideoDataOutputSampleBufferDelegate Delegate

- (void)captureOutput:(AVCaptureOutput *)output didOutputMetadataObjects:(NSArray<__kindof AVMetadataObject *> *)metadataObjects fromConnection:(AVCaptureConnection *)connection {
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *metaData = metadataObjects[0];
        [self stopScan];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completion(metaData.stringValue);
        });
    }
}
    
- (void)captureOutput:(AVCaptureOutput *)output didOutputSampleBuffer:(CMSampleBufferRef)sampleBuffer fromConnection:(AVCaptureConnection *)connection {
    CVPixelBufferRef cvpixeBufferRef = CMSampleBufferGetImageBuffer(sampleBuffer);
    CIImage *originImage = [CIImage imageWithCVPixelBuffer:cvpixeBufferRef];
    CIImage *outputImage = [originImage imageByApplyingOrientation:kCGImagePropertyOrientationRight];
    CIImage *cropImage = [self cropImage:outputImage byRect:self.scanFrame];
    
    NSArray *featureArray = [self.detector featuresInImage:cropImage];
    if (featureArray.count == 1) {
        CIQRCodeFeature *qrCodeFeature = featureArray[0];
        [self stopScan];
        dispatch_async(dispatch_get_main_queue(), ^{
            self.completion(qrCodeFeature.messageString);
        });
    }
    
    //Vision 识别支持iOS11以上，所以改用CIImage框架
//    VNImageRequestHandler *handler = [[VNImageRequestHandler alloc] initWithCIImage:cropImage options:@{}];
//    VNDetectBarcodesRequest *request = [[VNDetectBarcodesRequest alloc] initWithCompletionHandler:^(VNRequest * _Nonnull request, NSError * _Nullable error) {
//        if (request.results.count > 0) {
//            VNBarcodeObservation *observation = request.results[0];
//            NSLog(@"bar code = %@", observation.payloadStringValue);
//            if (observation.payloadStringValue) {
//                [self stopScan];
//                self.completion(observation.payloadStringValue);
//            }
//        }
//    }];
//    
//    [handler performRequests:@[request] error:nil];
}


#pragma mark -  CropImage 这里输出像素默认为1920x1080
- (CIImage *)cropImage:(CIImage *)originImage byRect:(CGRect)rect {
    
    CGFloat screenScale = [UIScreen mainScreen].scale;
    CGSize displayPixel = CGSizeMake(_previewLayer.bounds.size.width * screenScale, _previewLayer.bounds.size.height * screenScale);
    CGFloat originImageWHRatio = 1080.0 / 1920.0;
    CGFloat cropWidth = rect.size.width * screenScale;
    
    if (originImageWHRatio > displayPixel.width/displayPixel.height) {
        CGFloat scaleCropWidth = (1920 / displayPixel.height) * cropWidth;
        CGFloat scaleCropX = (1080 - scaleCropWidth) / 2;
        CGFloat scaleCropY = (rect.origin.y * screenScale) * (1920 / displayPixel.height);
        CGRect scaleCropRect = CGRectMake(scaleCropX, scaleCropY, scaleCropWidth, scaleCropWidth);
        return [originImage imageByCroppingToRect:scaleCropRect];
    } else {
        CGFloat scaleCropWidth = (1080 / displayPixel.width) * cropWidth;
        CGFloat scaleCropX = (1080 - scaleCropWidth) / 2;
        CGFloat scaleCropY = (rect.origin.y * screenScale) * (1080 / displayPixel.width);
        CGRect scaleCropRect = CGRectMake(scaleCropX, scaleCropY, scaleCropWidth, scaleCropWidth);
        return [originImage imageByCroppingToRect:scaleCropRect];
    }
}

#pragma mark - 开启/关闭灯光
- (void)changeTorch
{
    AVCaptureTorchMode torch = _device.torchMode;
    if (torch == AVCaptureTorchModeOn) {
        torch = AVCaptureTorchModeOff;
    }
    else if (torch == AVCaptureTorchModeOff) {
        torch = AVCaptureTorchModeOn;
    }
    
    [_device lockForConfiguration:nil];
    _device.torchMode = torch;
    [_device unlockForConfiguration];
}


#pragma mark - scanner control
- (void)startScan {
    [_maskLayer startScannerAnimation];
    if ([_session isRunning]) {
        return;
    }
    [_session startRunning];
}

- (void)stopScan {
    if (![_session isRunning]) {
        return;
    }
    [_session stopRunning];
    [_maskLayer stopScannerAnimation];
}

#pragma mark - 监听session状态，进入后台isRunning=NO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    if ([object isKindOfClass:[AVCaptureSession class]]) {
        BOOL isRunning = ((AVCaptureSession *)object).isRunning;
        dispatch_async(dispatch_get_main_queue(), ^{
            if (isRunning) {
                [self startScan];
            } else {
                [self stopScan];
            }
        });
    }
}

- (void)dealloc {
    [_session removeObserver:self forKeyPath:@"running"];
}

@end

