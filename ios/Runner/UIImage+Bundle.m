//
//  UIImage+Bundle.m
//  QRScan
//
//  Created by yangl on 2019/1/10.
//  Copyright © 2019 yangl. All rights reserved.
//

#import "UIImage+Bundle.h"

@implementation UIImage (Bundle)

+ (UIImage *)h3cScanner_imageWithName:(NSString *)imageName {
    NSString *fileName;
    NSString *bundleName = @"H3CScanner";
    if ([UIScreen mainScreen].scale == 2) {
        fileName = [NSString stringWithFormat:@"%@@2x", imageName];
    }
    else if ([UIScreen mainScreen].scale == 3) {
        fileName = [NSString stringWithFormat:@"%@@3x", imageName];
    }
    
//    NSString * scannerBundlePath = [[NSBundle mainBundle] pathForResource:bundleName ofType:@"bundle"];
    NSURL * scannerBundleUrl = [[NSBundle mainBundle] URLForResource:bundleName withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:scannerBundleUrl];
    //[NSBundle bundleForClass:NSClassFromString(@"H3CScanner")];
//    NSURL *url = [bundle URLForResource:bundleName withExtension:@"bundle"];
//    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    
    NSString *path = [imageBundle pathForResource:fileName ofType:@"png"];
    
//    return [[UIImage imageWithContentsOfFile:path] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    return [UIImage imageWithContentsOfFile:path];
}

@end
