//
//  LXCViewController.m
//  LXCProgressHUD
//
//  Created by butterflyXX on 05/07/2018.
//  Copyright (c) 2018 butterflyXX. All rights reserved.
//

#import "LXCViewController.h"

@interface LXCViewController ()

@end

@implementation LXCViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(200, 200, 50, 50);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

-(void)buttonAction {
    NSLog(@"点击了按钮");
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    [LXCProgressHUD showSuccess:@"成功" toView:self.view];
    LXCTwoVcViewController *twoVc = [LXCTwoVcViewController new];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:twoVc];
    nav.navigationItem.title = [[NSString alloc] initWithFormat:@"%lu",nav.childViewControllers.count];
    [self presentViewController:nav animated:YES completion:nil];
//    UIView *sebView = [UIView new];
//    sebView.backgroundColor = UIColor.grayColor;
//    sebView.alpha = 0.5;
//    sebView.frame = self.view.bounds;
//    [self.view addSubview:sebView];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [sebView removeFromSuperview];
//    });
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
