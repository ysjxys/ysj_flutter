//
//  H3CScanner.h
//  QRScan
//
//  Created by yangl on 2019/1/9.
//  Copyright © 2019 yangl. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
typedef void(^H3CScanerCompletion)(NSString *resultString);

@interface H3CScanner : NSObject

- (instancetype)initWithScanFrame:(CGRect)scanFrame onParentView:(UIView *)view completion:(H3CScanerCompletion)completion NS_DESIGNATED_INITIALIZER;

+ (instancetype)scannerWithScanFrame:(CGRect)scanFrame onParentView:(UIView *)view completion:(H3CScanerCompletion)completion;

+ (void)scanImage:(UIImage *)image completion:(H3CScanerCompletion)completion;

- (void)startScan;
- (void)stopScan;

- (void)changeTorch;

@end

NS_ASSUME_NONNULL_END
