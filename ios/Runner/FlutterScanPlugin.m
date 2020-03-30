//
//  FlutterScanPlugin.m
//  Runner
//
//  Created by ysj on 2019/9/26.
//  Copyright © 2019 The Chromium Authors. All rights reserved.
//

#import "FlutterScanPlugin.h"
#import "H3CQRScannerResultViewController.h"

@implementation FlutterScanPlugin

+ (void)registerWithRegistrar:(nonnull NSObject<FlutterPluginRegistrar> *)registrar {
    FlutterMethodChannel *channel =
    [FlutterMethodChannel methodChannelWithName:@"MethodChannleScan"
                                binaryMessenger:[registrar messenger]];
    FlutterScanPlugin *instance = [[FlutterScanPlugin alloc] init];
    [registrar addMethodCallDelegate:instance channel:channel];
}

- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
    if ([@"flutter_scan" isEqualToString:call.method]) {
        NSLog(@"flutter_scan");
        result(@"success");
        H3CQRScannerResultViewController *scannerResultVC = [H3CQRScannerResultViewController qrScannerViewControllerWithResultHandlerBlock:^(NSString * _Nonnull resultString, H3CQRScannerViewController *vc) {
            if (resultString.length > 0) {
                [vc dismissViewControllerAnimated:NO completion:nil];
                result(resultString);
            } else {
                result(@"识别失败");
            }
        }];
        [[UIApplication sharedApplication].delegate.window.rootViewController presentViewController:scannerResultVC animated:YES completion:nil];
    }else {
        NSLog(@"not flutter_scan");
        result(FlutterMethodNotImplemented);
    }
}

@end
