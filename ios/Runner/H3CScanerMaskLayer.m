//
//  H3CScanerMaskLayer.m
//  QRScan
//
//  Created by yangl on 2019/1/9.
//  Copyright © 2019 yangl. All rights reserved.
//

#import "H3CScanerMaskLayer.h"
#import <UIKit/UIKit.h>
#import "UIImage+Bundle.h"

static NSString  * _Nullable kScannerLineAnimation = @"ScannerLineAnimation";

@interface H3CScanerMaskLayer()

@property (nonatomic, assign) CGRect cropRect;

@end

@implementation H3CScanerMaskLayer {
    CALayer *_scanLineLayer;
}

- (instancetype)initWithCropRect:(CGRect)cropRect {
    self = [super init];
    if (self) {
        _cropRect = cropRect;
    }
    return self;
}

+ (instancetype)maskLayerWithFrame:(CGRect)frame cropRect:(CGRect)cropRect {
    H3CScanerMaskLayer *maskLayer = [[self alloc] initWithCropRect:cropRect];
    maskLayer.frame = frame;
    [maskLayer addScanRegion];
//    [maskLayer startScannerAnimation];
    return maskLayer;
}

- (void)addScanRegion {
    // cropRect
    CALayer *cropLayer = [CALayer layer];
    cropLayer.frame = self.cropRect;
    UIImage *cropImage = [UIImage h3cScanner_imageWithName:@"cropRect"];
    cropLayer.contents = (__bridge id)cropImage.CGImage;
    [self addSublayer:cropLayer];
    
    // scanLine
    _scanLineLayer = [CALayer layer];
    _scanLineLayer.frame = CGRectMake(0, 0, self.cropRect.size.width, 3);
    UIImage *scanLineImage = [UIImage h3cScanner_imageWithName:@"scanLine"];
    _scanLineLayer.contents = (__bridge id)scanLineImage.CGImage;
    [cropLayer addSublayer:_scanLineLayer];
}

- (void)drawInContext:(CGContextRef)ctx {
    CGContextSetFillColorWithColor(ctx, [UIColor colorWithWhite:0.0 alpha:0.4].CGColor);
    CGContextFillRect(ctx, self.frame);
    CGContextClearRect(ctx, self.cropRect);
}

// scanner animation
- (void)startScannerAnimation {
    CABasicAnimation *basicAnimation = [CABasicAnimation animationWithKeyPath:@"position.y"];
    basicAnimation.duration = 3.0;
    basicAnimation.repeatCount = MAXFLOAT;
    basicAnimation.toValue = [NSNumber numberWithFloat:self.cropRect.size.width];
    basicAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [_scanLineLayer addAnimation:basicAnimation forKey:kScannerLineAnimation];
}

- (void)stopScannerAnimation {
    [_scanLineLayer removeAnimationForKey:kScannerLineAnimation];
}

@end
