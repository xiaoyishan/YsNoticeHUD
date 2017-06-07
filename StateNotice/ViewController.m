//
//  ViewController.m
//  StateNotice
//
//  Created by Sundear on 2017/6/5.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "ViewController.h"
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)Notice1:(id)sender {
    [YsNoticeHUD HUDTopBackgroundColor:[UIColor orangeColor]
                             FontColor:[UIColor whiteColor]
                               Message:arc4random()%2==0?@"你的网络似乎断掉了-_-":@"好友 齐天大圣 已上线!"];
}
- (IBAction)Notice1miss:(id)sender {
    [YsNoticeHUD HUDTopMiss];
}







- (IBAction)Notice2:(id)sender {
    [YsNoticeHUD HUDNavBackgroundColor:[UIColor orangeColor]
                             FontColor:[UIColor whiteColor]
                               Message:arc4random()%2==0?@"你的网络似乎断掉了-_-":@"好友 齐天大圣 已上线!"
                              Duration:5];
}
- (IBAction)Notice2miss:(id)sender {
    [YsNoticeHUD HUDNavMiss];
}








- (IBAction)Notice3:(id)sender {

    [YsNoticeHUD HUDNoticeMessage:@"老孙被压了500年之后出来看你 结果你居然还在写代码。"
                       NoticeName:@"齐天大圣 孙悟空"
                      NoticeImage:[UIImage imageNamed:@"大圣"]
                           UserID:12 Click:^(NSUInteger ID) {
        NSLog(@"这是一条模拟推送 ID:%zd" , ID);
    }];
}


@end
