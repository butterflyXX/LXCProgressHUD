//
//  LXCProgressHUD.h
//  LXCProgressHUD_Example
//
//  Created by 刘晓晨 on 2018/5/7.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import "MBProgressHUD.h"

typedef void((^LXCComplete)(void));

@interface LXCProgressHUD : MBProgressHUD

//结果显示时长
@property (nonatomic,assign)int time;

//等待图片
@property (nonatomic,strong)NSArray<NSString *> *waitingImageStringArray;

//等待动图频率
@property (nonatomic,assign)CGFloat waitFrequency;

//成功图片
@property (nonatomic,copy)NSString *successImageString;

//失败图片
@property (nonatomic,copy)NSString *errorImageString;

//文字颜色
@property (nonatomic,strong)UIColor *tintColor;

//背景颜色
@property (nonatomic,strong)UIColor *backColor;

//单例对象
+(instancetype)sharedHUDManager;

//等待
- (instancetype)waiting:(NSString *)string toView:(UIView *)view;

//显示成功
- (void)showSuccess:(NSString *)text complete:(LXCComplete)complete;

//显示失败
- (void)showError:(NSString *)text complete:(LXCComplete)complete;

//显示信息
- (void)showMessage:(NSString *)message complete:(LXCComplete)complete;

@end
