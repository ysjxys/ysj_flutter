//
//  H3CQRScannerResultViewController.m
//  H3CMagic
//
//  Created by yangl on 2019/1/10.
//  Copyright © 2019 H3C. All rights reserved.
//



#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

#define  H3C_iPhoneX (kScreenWidth == 375.f && kScreenHeight == 812.f ? YES : NO)
#define  H3C_iPhoneXR (kScreenWidth == 414.f && kScreenHeight == 896.f ? YES : NO)

#define  H3C_iPhoneX_Series (H3C_iPhoneX || H3C_iPhoneXR)
#define  H3C_StatusBarAndNavigationBarHeight  (H3C_iPhoneX_Series ? 88.f : 64.f)
#define  H3C_StatusBarHeight      (H3C_iPhoneX_Series ? 44.f : 20.f)


#import "H3CQRScannerResultViewController.h"
#import "UIImage+Bundle.h"

@interface H3CQRScannerResultViewController ()

@property (nonatomic, strong) UIView *navigationView;
@property (nonatomic, strong) UIButton *leftButton;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic, strong) UILabel *titleLabel;

@property (nonatomic, strong) UILabel *subLabel;

@end

@implementation H3CQRScannerResultViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self navigationConfiure];
}

- (void)navigationConfiure {

    self.navigationView.frame = CGRectMake(0, 0, kScreenWidth, H3C_StatusBarAndNavigationBarHeight);
    [self.view addSubview:self.navigationView];
    
    self.leftButton.frame = CGRectMake(10, H3C_StatusBarHeight, 44, 44);
    [self.view addSubview:self.leftButton];
    
    self.rightButton.frame = CGRectMake(kScreenWidth - 60, H3C_StatusBarHeight, 60, 44);
    [self.view addSubview:self.rightButton];
    
    self.titleLabel.frame = CGRectMake(kScreenWidth/2-30, H3C_StatusBarHeight, 60, 44);
    [self.view addSubview:self.titleLabel];
    
//    self.subLabel.frame = CGRectMake(kScreenWidth/2-150, H3C_StatusBarAndNavigationBarHeight + 20, 300, 20);
//    [self.view addSubview:self.subLabel];
}


- (UIView *)navigationView {
    if (!_navigationView) {
        _navigationView = [[UIView alloc] initWithFrame:CGRectZero];
        _navigationView.backgroundColor = [UIColor blackColor];
        _navigationView.alpha = 0.5;
    }
    return _navigationView;
}

- (UIButton *)leftButton {
    if (!_leftButton) {
        _leftButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_leftButton setImage:[UIImage h3cScanner_imageWithName:@"icon_white_left_arrow"] forState:UIControlStateNormal];
        [_leftButton addTarget:self action:@selector(navigationLeftClick) forControlEvents:UIControlEventTouchUpInside];
    }
    return _leftButton;
}

- (UIButton *)rightButton {
    if (!_rightButton) {
        _rightButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_rightButton setTitle:@"相册" forState:UIControlStateNormal];
        [_rightButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _rightButton.titleLabel.font = [UIFont systemFontOfSize:16];
        [_rightButton addTarget:self action:@selector(selectPhoto) forControlEvents:UIControlEventTouchUpInside];
    }
    return _rightButton;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.text = @"扫一扫";
        _titleLabel.textColor = [UIColor whiteColor];
        _titleLabel.font = [UIFont systemFontOfSize:18];
        [_titleLabel sizeToFit];
    }
    return _titleLabel;
}

//- (UILabel *)subLabel {
//    if (!_subLabel) {
//        _subLabel = [[UILabel alloc] init];
//        _subLabel.text = @"请先接通电源，再扫描底部二维码";
//        _subLabel.textColor = [UIColor whiteColor];
//        _subLabel.font = [UIFont systemFontOfSize:14];
//        [_subLabel sizeToFit];
//    }
//    return _subLabel;
//}

- (void)navigationLeftClick {
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
