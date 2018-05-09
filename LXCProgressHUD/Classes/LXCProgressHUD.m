//
//  LXCProgressHUD.m
//  LXCProgressHUD_Example
//
//  Created by 刘晓晨 on 2018/5/7.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import "LXCProgressHUD.h"
#import "AILoadingView.h"

@interface LXCProgressHUD ()

@property (nonatomic,weak)AILoadingView *loadingView;

@end

@implementation LXCProgressHUD

+(instancetype)sharedHUDManager {
    static id instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [self new];
        
    });
    return instance;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
//    self.square = YES;
    self.minSize = CGSizeMake(120, 10);
    return self;
}

- (instancetype)waiting:(NSString *)string toView:(UIView *)view {
//
    
    if (view == nil)
        view = [[UIApplication sharedApplication].windows lastObject];
    // 快速显示一个提示信息
    LXCProgressHUD *hud = [LXCProgressHUD showHUDAddedTo:view animated:YES];
    // 再设置模式
    hud.mode = MBProgressHUDModeCustomView;
    hud.label.text = string;
    hud.label.font = [UIFont systemFontOfSize:14];
    [self setHUD:hud];
    
    NSArray<UIImage *> *imageArray = [self getGifWithImageStringArray:[LXCProgressHUD sharedHUDManager].waitingImageStringArray];
    if (imageArray.count == 1) {
        UIImageView *imageView = [[UIImageView alloc] initWithImage:imageArray.lastObject];
        hud.customView = imageView;  // 设置图片
    }else if (imageArray.count > 1) {
        UIImageView *imageView = [UIImageView new];
        imageView.animationImages = imageArray;
        imageView.animationRepeatCount = MAXFLOAT;
        imageView.animationDuration = imageArray.count/[LXCProgressHUD sharedHUDManager].waitFrequency;
        [imageView startAnimating];
        hud.customView = imageView;  // 设置图片
    } else {
        AILoadingView *loadingView = [[AILoadingView alloc] initWithFrame:CGRectMake(7.5, 7.5, 30, 30)];
        loadingView.strokeColor = [LXCProgressHUD sharedHUDManager].tintColor ? [LXCProgressHUD sharedHUDManager].tintColor : [UIColor whiteColor];
        loadingView.tag = 100;
        hud.loadingView = loadingView;
        NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"LXCProgressHUD")];
        NSURL *url = [bundle URLForResource:@"LXCProgressHUD" withExtension:@"bundle"];
        NSBundle *imageBundle = [NSBundle bundleWithURL:url];
        UIImage *image = [UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"back" ofType:@"png"]];
        UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
        [imageView addSubview:loadingView];
        hud.customView = imageView;  // 设置图片
    }

    // 隐藏时候从父控件中移除
    hud.removeFromSuperViewOnHide = YES;
    return hud;
}

- (void)showSuccess:(NSString *)text complete:(LXCComplete)complete
{
    self.completionBlock = complete;
    self.label.text = text;
    
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"LXCProgressHUD")];
    NSURL *url = [bundle URLForResource:@"LXCProgressHUD" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    UIImage *image = [[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"Checkmark" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *userImage = [UIImage imageNamed:[LXCProgressHUD sharedHUDManager].successImageString];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:userImage ? userImage : image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.customView = imageView;  // 设置图片
    //     1秒之后再消失
    [self hideAnimated:YES afterDelay:[LXCProgressHUD sharedHUDManager].time == 0 ? 1:[LXCProgressHUD sharedHUDManager].time];
}

/**
 *  =======显示错误信息
 */
- (void)showError:(NSString *)text complete:(LXCComplete)complete {
    self.completionBlock = complete;
    //    error
    // 再设置模式
    self.label.text = text;
    NSBundle *bundle = [NSBundle bundleForClass:NSClassFromString(@"LXCProgressHUD")];
    NSURL *url = [bundle URLForResource:@"LXCProgressHUD" withExtension:@"bundle"];
    NSBundle *imageBundle = [NSBundle bundleWithURL:url];
    UIImage *image = [[UIImage imageWithContentsOfFile:[imageBundle pathForResource:@"error" ofType:@"png"]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate];
    UIImage *userImage = [UIImage imageNamed:[LXCProgressHUD sharedHUDManager].errorImageString];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:userImage ? userImage : image];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.customView = imageView;  // 设置图片
    //     1秒之后再消失
    [self hideAnimated:YES afterDelay:[LXCProgressHUD sharedHUDManager].time == 0 ? 1:[LXCProgressHUD sharedHUDManager].time];
}

- (void)showMessage:(NSString *)message complete:(LXCComplete)complete {
    self.completionBlock = complete;
    self.mode = MBProgressHUDModeText;
    self.label.text = message;
    //     1秒之后再消失
    [self hideAnimated:YES afterDelay:[LXCProgressHUD sharedHUDManager].time == 0 ? 2:[LXCProgressHUD sharedHUDManager].time];
}

-(void) setHUD:(MBProgressHUD *)hud {
    hud.contentColor = [LXCProgressHUD sharedHUDManager].tintColor ? [LXCProgressHUD sharedHUDManager].tintColor : [UIColor whiteColor];
    hud.bezelView.backgroundColor = [LXCProgressHUD sharedHUDManager].backColor ? [LXCProgressHUD sharedHUDManager].backColor : [UIColor blackColor];    //背景颜色
}

-(NSArray<UIImage *> *) getGifWithImageStringArray:(NSArray<NSString *> *)array {
    NSMutableArray<UIImage *> *gifArray = [NSMutableArray new];
    for (NSString *imageString in array) {
        UIImage *image = [UIImage imageNamed:imageString];
        [gifArray addObject:image];
    }
    return gifArray.copy;
}

-(void)dealloc {
    NSLog(@"hud释放了");
    if (self.loadingView) {
        [self.loadingView stopAnimation];
    }
    if (self.customView) {
        AILoadingView *loadingView = [self.customView viewWithTag:100];
        if (loadingView) {
            [loadingView stopAnimation];
        }
        [self.customView removeFromSuperview];
    }
}
@end
