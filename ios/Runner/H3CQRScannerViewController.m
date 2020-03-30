//
//  H3CQRScannerViewController.m
//  QRScan
//
//  Created by yangl on 2019/1/9.
//  Copyright © 2019 yangl. All rights reserved.
//

#import "H3CQRScannerViewController.h"
#import "UIImage+Bundle.h"
#import <AVFoundation/AVFoundation.h>

#define kCropWidth  ([UIScreen mainScreen].bounds.size.width - 60 * 2)
#define kScreenWidth [UIScreen mainScreen].bounds.size.width

@interface H3CQRScannerViewController () <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (nonatomic, copy) H3CScanerHandler resultHandlerBlock;

@end

@implementation H3CQRScannerViewController {
    H3CScanner *_scanner;
    CGRect _cropRect;
}

- (instancetype)initWithResultHandlerBlock:(H3CScanerHandler)block {
    NSAssert(block != nil, @"Must callback scaner results!");
    self = [super init];
    if (self) {
        self.resultHandlerBlock = block;
    }
    return self;
}

+ (instancetype)qrScannerViewControllerWithResultHandlerBlock:(H3CScanerHandler)block {
    return [[self alloc] initWithResultHandlerBlock:block];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self setupScanner];
    [self customView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [_scanner startScan];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [_scanner stopScan];
}

- (void)setupScanner {
    CGFloat cropX = self.view.center.x - kCropWidth / 2;
    CGFloat cropY = self.view.center.y - kCropWidth / 2;
    _cropRect = CGRectMake(cropX, cropY, kCropWidth, kCropWidth);

    __weak typeof(self) weakSelf = self;
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];

    if (authStatus == AVAuthorizationStatusNotDetermined || authStatus == AVAuthorizationStatusAuthorized) { // 用户还没有做出选择
        // 弹框请求用户授权
        _scanner = [H3CScanner scannerWithScanFrame:_cropRect onParentView:self.view completion:^(NSString * _Nonnull resultString) {
            weakSelf.resultHandlerBlock(resultString, self);
        }];

    }else {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"请去-> [设置 - 隐私 - 相机 - 项目名称] 打开访问开关" preferredStyle:UIAlertControllerStyleAlert];
        [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:nil]];
        [alert addAction:[UIAlertAction actionWithTitle:@"前往" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
            if ([[UIApplication sharedApplication] canOpenURL:url]) {
                [[UIApplication sharedApplication] openURL:url];
            }
        }]];
        [[self getCurrentVC] presentViewController:alert animated:YES completion:nil];
    }
}

- (void)customView {
    UILabel *tipLabel = [[UILabel alloc] initWithFrame:CGRectMake((kScreenWidth - 250)/2, _cropRect.origin.y - 20 - 28, 250, 28)];
    tipLabel.text = @"请将二维码放入识别框内扫描";
    tipLabel.font = [UIFont systemFontOfSize:12];
    tipLabel.textColor = [UIColor whiteColor];
    tipLabel.textAlignment = NSTextAlignmentCenter;
//    tipLabel.backgroundColor = [UIColor grayColor];
//    tipLabel.layer.cornerRadius = 14;
//    tipLabel.layer.masksToBounds = YES;
    [self.view addSubview:tipLabel];
    
    UIImageView *torchImageView = [[UIImageView alloc] initWithImage:[UIImage h3cScanner_imageWithName:@"torch"]];
    torchImageView.center = CGPointMake(kScreenWidth/2, _cropRect.origin.y + kCropWidth + 18 + 10);
    torchImageView.frame = CGRectInset(torchImageView.frame, -10, -10);  // 扩大点击区域
    torchImageView.contentMode = UIViewContentModeCenter;
    torchImageView.userInteractionEnabled = YES;
    [torchImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:_scanner action:@selector(changeTorch)]];
    [self.view addSubview:torchImageView];
}

- (void)selectPhoto {
    UIImagePickerController *pickerController = [[UIImagePickerController alloc] init];
//    pickerController.view.frame = CGRectOffset(pickerController.view.frame, 0, 44);
    pickerController.delegate = self;
    pickerController.navigationBar.translucent = NO;
//    [H3CStatusBarTool setStyle:UIStatusBarStyleDefault];
    [self presentViewController:pickerController animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<UIImagePickerControllerInfoKey,id> *)info {
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    [H3CScanner scanImage:image completion:^(NSString * _Nonnull resultString) {
//        NSLog(@"=======%@", resultString);
        [picker dismissViewControllerAnimated:NO completion:nil];
        self.resultHandlerBlock(resultString, self);
    }];
}

/**
 *  返回当前ViewController
 */
- (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow * tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    if ([window subviews].count>0) {
        UIView *frontView = [[window subviews] objectAtIndex:0];
        id nextResponder = [frontView nextResponder];

        if ([nextResponder isKindOfClass:[UIViewController class]]){
            result = nextResponder;
        } else {
            result = window.rootViewController;
        }
    } else {
        result = window.rootViewController;
    }
    if ([result isKindOfClass:[UITabBarController class]]) {
        result = [((UITabBarController*)result) selectedViewController];
    }
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [((UINavigationController*)result) visibleViewController];
    }

    return result;
}

@end
