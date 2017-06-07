//
//  YsNoticeHUD.h
//  StateNotice
//
//  Created by Sundear on 2017/6/6.
//  Copyright © 2017年 xiexin. All rights reserved.

#import <UIKit/UIKit.h>
#import <objc/runtime.h>

#define  Width   [[UIScreen mainScreen] bounds].size.width
#define  Height  [[UIScreen mainScreen] bounds].size.height

@interface YsNoticeHUD : UIView

@property (nonatomic, strong) UIWindow *WindowBar;      //状态栏HUD：不会自己消失  **导航栏HUD是存在主window上的 会根据时间自动消失 也可调用方法消失 默认viewWillDisappear时消失
@property (nonatomic, strong) UIWindow *WindowNotice;   //消息通知HUD: 默认3秒消失

//状态栏
+(void)HUDTopBackgroundColor:(UIColor*)backgroundColor FontColor:(UIColor*)fontColor Message:(NSString*)message;
+(void)HUDTopMiss;

//导航栏
+(void)HUDNavBackgroundColor:(UIColor*)backgroundColor FontColor:(UIColor*)fontColor Message:(NSString*)message Duration:(NSTimeInterval)duration;
+(void)HUDNavMiss;

//消息通知
+(void)HUDNoticeMessage:(NSString*)message NoticeName:(NSString*)name NoticeImage:(UIImage*)image UserID:(NSUInteger)Uid Click:(void(^)(NSUInteger ID))click;
@end





#pragma mark  按钮点击

typedef void(^ButtonClick)(UIButton* btn);
@interface UIButton (click)
- (void)addClickAC:(ButtonClick)TouchupInside;
@end



#pragma mark 视图离开（关闭NavHUD）
@interface UIViewController (HUDWillMiss)
@end
