//
//  LXCProgressHUD.m
//  LXCProgressHUD_Example
//
//  Created by 刘晓晨 on 2018/5/7.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import "LXCProgressHUD.h"

@implementation LXCProgressHUD

+ (instancetype)waiting:(NSString *)string toView:(UIView *)view {
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    LXCProgressHUD *hud = [LXCProgressHUD showHUDAddedTo:view animated:YES];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    //    hud.mode = MBProgressHUDModeText;
    hud.label.text = string;
    hud.contentColor = [UIColor whiteColor];
    
    NSBundle *bundle = [NSBundle bundleForClass:[LXCProgressHUD class]];
    NSURL *url = [bundle URLForResource:@"LXCProgressHUD" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    UIImage *image = [[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"loading" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    //    UIImage *image = [UIImage imageNamed:@"Checkmark"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    
        CABasicAnimation *anima = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
        anima.toValue = @(M_PI*2);
        anima.duration = 1.0f;
        anima.repeatCount = 100;
        [imageView.layer addAnimation:anima forKey:nil];
    hud.customView = imageView;  // 设置图片
    //    hud.customView.backgroundColor = [UIColor whiteColor];
    hud.bezelView.backgroundColor = [UIColor blackColor];    //背景颜色
    hud.bezelView.style = MBProgressHUDBackgroundStyleBlur;

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

- (void)showSuccess:(NSString *)text
{
    // 再设置模式
    self.mode = MBProgressHUDModeCustomView;
    //    hud.mode = MBProgressHUDModeText;
    self.label.text = text;
    self.contentColor = [UIColor whiteColor];
    
    NSBundle *bundle = [NSBundle bundleForClass:[LXCProgressHUD class]];
    NSURL *url = [bundle URLForResource:@"LXCProgressHUD" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    UIImage *image = [[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"Checkmark" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.customView = imageView;  // 设置图片
    self.bezelView.backgroundColor = [UIColor blackColor];    //背景颜色
    self.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    //     1秒之后再消失
    [self hideAnimated:YES afterDelay:1];
    
}

/**
 *  =======显示错误信息
 */
- (void)showError:(NSString *)text {
//    error
    // 再设置模式
    self.mode = MBProgressHUDModeCustomView;
    //    hud.mode = MBProgressHUDModeText;
    self.label.text = text;
    self.contentColor = [UIColor whiteColor];
    NSBundle *bundle = [NSBundle bundleForClass:[LXCProgressHUD class]];
    NSURL *url = [bundle URLForResource:@"LXCProgressHUD" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    UIImage *image = [[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"error" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.customView = imageView;  // 设置图片
    self.bezelView.backgroundColor = [UIColor blackColor];    //背景颜色
    self.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    //     1秒之后再消失
    [self hideAnimated:YES afterDelay:1];
}

- (void)showMessage:(NSString *)message {
    self.mode = MBProgressHUDModeText;
    self.label.text = message;
    self.contentColor = [UIColor whiteColor];
    self.bezelView.backgroundColor = [UIColor blackColor];    //背景颜色
    self.bezelView.style = MBProgressHUDBackgroundStyleBlur;
    //     1秒之后再消失
    [self hideAnimated:YES afterDelay:1];
}
@end
