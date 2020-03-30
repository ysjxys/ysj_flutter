//
//  H3CScanerMaskLayer.h
//  QRScan
//
//  Created by yangl on 2019/1/9.
//  Copyright © 2019 yangl. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>

NS_ASSUME_NONNULL_BEGIN

@interface H3CScanerMaskLayer : CALayer

+ (instancetype)maskLayerWithFrame:(CGRect)frame cropRect:(CGRect)cropRect;

- (void)startScannerAnimation;

- (void)stopScannerAnimation;

@end

NS_ASSUME_NONNULL_END
