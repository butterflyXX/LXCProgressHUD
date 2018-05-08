//
//  LXCTwoVcViewController.m
//  LXCProgressHUD_Example
//
//  Created by 刘晓晨 on 2018/5/7.
//  Copyright © 2018年 butterflyXX. All rights reserved.
//

#import "LXCTwoVcViewController.h"

@interface LXCTwoVcViewController ()

@end

@implementation LXCTwoVcViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIButton *button = [UIButton new];
    button.frame = CGRectMake(200, 200, 50, 50);
    button.backgroundColor = [UIColor redColor];
    [button addTarget:self action:@selector(buttonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    UIButton *jumpButton = [UIButton new];
    jumpButton.frame = CGRectMake(200, 400, 50, 50);
    jumpButton.backgroundColor = [UIColor redColor];
    [jumpButton addTarget:self action:@selector(jumpButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:jumpButton];
    self.view.backgroundColor = [UIColor greenColor];
    NSMutableArray<NSString *> *stringArray = [NSMutableArray new];
    for (int i = 1; i <= 14; i++) {
        [stringArray addObject:[[NSString alloc] initWithFormat:@"offWork0%02d",i]];
    }
//    [LXCProgressHUD sharedHUDManager].waitingImageStringArray = stringArray;
//    [LXCProgressHUD sharedHUDManager].successImageString = @"offWork001";
//    [LXCProgressHUD sharedHUDManager].waitFrequency = 7.0;
}

-(void)buttonAction {
    NSLog(@"点击了按钮");
    LXCProgressHUD *hud = [[LXCProgressHUD sharedHUDManager] waiting:@"正在加载中..." toView:self.view];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [hud showSuccess:@"成功" complete:^{
            NSLog(@"显示结束");
            [self jumpButtonAction];
        }];
    });
}

-(void)jumpButtonAction {
    LXCTwoVcViewController *vc = [LXCTwoVcViewController new];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end


