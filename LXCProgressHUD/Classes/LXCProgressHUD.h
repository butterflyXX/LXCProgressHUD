//
//  LXCProgressHUD.h
//  LXCProgressHUD_Example
//
//  Created by 刘晓晨 on 2018/5/7.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import "MBProgressHUD.h"
@interface LXCProgressHUD : MBProgressHUD

//等待
+ (instancetype)waiting:(NSString *)string toView:(UIView *)view;

//显示成功
- (void)showSuccess:(NSString *)text;

//显示失败
- (void)showError:(NSString *)text;

//显示信息
- (void)showMessage:(NSString *)message;

@end
