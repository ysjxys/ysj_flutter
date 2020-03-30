//
//  H3CQRScannerViewController.h
//  QRScan
//
//  Created by yangl on 2019/1/9.
//  Copyright © 2019 yangl. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "H3CScanner.h"

NS_ASSUME_NONNULL_BEGIN

@interface H3CQRScannerViewController : UIViewController

typedef void(^H3CScanerHandler)(NSString *resultString, H3CQRScannerViewController *vc);

+ (instancetype)qrScannerViewControllerWithResultHandlerBlock:(H3CScanerHandler)block;

//- (void)selectPhoto;

@end

NS_ASSUME_NONNULL_END
