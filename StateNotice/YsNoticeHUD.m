//
//  YsNoticeHUD.m
//  StateNotice
//
//  Created by Sundear on 2017/6/6.
//  Copyright © 2017年 xiexin. All rights reserved.
//

#import "YsNoticeHUD.h"

@implementation YsNoticeHUD

+(instancetype)allocWithZone:(struct _NSZone *)zone{
    static YsNoticeHUD *siglezone=nil;
    if(!siglezone)siglezone=[super allocWithZone:zone];
    return siglezone;
}


#pragma mark -- 状态栏

+(void)HUDTopBackgroundColor:(UIColor*)backgroundColor FontColor:(UIColor*)fontColor Message:(NSString*)message{

    //移除旧的
    YsNoticeHUD *HUD=[YsNoticeHUD new];
    [UIView animateWithDuration:.25 animations:^{
        HUD.WindowBar.frame=CGRectMake(0, -22, Width, 22);
    }completion:^(BOOL finished) {

        HUD.WindowBar=[[UIWindow alloc]init];
        HUD.WindowBar.windowLevel=UIWindowLevelStatusBar;
        HUD.WindowBar.frame=CGRectMake(0, -22, Width, 22);
        HUD.WindowBar.backgroundColor=backgroundColor;
        HUD.WindowBar.hidden=NO;


        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 22)];
        label.font=[UIFont systemFontOfSize:13];
        label.textColor=fontColor;
        label.textAlignment=1;
        label.text=message;
        [HUD.WindowBar addSubview:label];
        //新的出现
        [UIView animateWithDuration:.25 animations:^{
            HUD.WindowBar.frame=CGRectMake(0, 0, Width, 22);
        }];

    }];
}
//miss
+(void)HUDTopMiss{
    YsNoticeHUD *HUD=[YsNoticeHUD new];
    [UIView animateWithDuration:.25 animations:^{
        HUD.WindowBar.frame=CGRectMake(0, -22, Width, 22);
    }completion:^(BOOL finished) {
        HUD.WindowBar=nil;
    }];
}





#pragma mark -- 导航

+(void)HUDNavBackgroundColor:(UIColor*)backgroundColor FontColor:(UIColor*)fontColor Message:(NSString*)message Duration:(NSTimeInterval)duration{

    //旧的消失
    UIView *oldBar=[[UIApplication sharedApplication].keyWindow viewWithTag:917299002];
    [UIView animateWithDuration:.25 animations:^{
        oldBar.frame=CGRectMake(0, 64, Width, 0);
    }completion:^(BOOL finished) {
        [oldBar removeFromSuperview];
        for (int k=0; k<10; k++) {//防止极短的时间内调用后重叠 0.25/10
            UIView *CycleBar=[[UIApplication sharedApplication].keyWindow viewWithTag:917299002];
            [CycleBar removeFromSuperview];
        }

        UIView *HUDBar=[[UIView alloc]initWithFrame:CGRectMake(0, 64, Width, 0)];
        HUDBar.tag = 917299002;
        HUDBar.backgroundColor=backgroundColor;
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width, 22)];
        label.font=[UIFont systemFontOfSize:13];
        label.textColor=fontColor;
        label.textAlignment=1;
        label.text=message;
        [HUDBar addSubview:label];
        [[UIApplication sharedApplication].keyWindow addSubview:HUDBar];

        //新的出现
        [UIView animateWithDuration:.25 animations:^{
            HUDBar.frame=CGRectMake(0, 64, Width, 22);
        }];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(duration * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

            [UIView animateWithDuration:.25 animations:^{
                HUDBar.frame=CGRectMake(0, 64, Width, 0);
            }completion:^(BOOL finished) {
                [HUDBar removeFromSuperview];
            }];
        });
        
    }];
    
}
//miss
+(void)HUDNavMiss{
    UIView *oldBar=[[UIApplication sharedApplication].keyWindow viewWithTag:917299002];
    [UIView animateWithDuration:.25 animations:^{
        oldBar.frame=CGRectMake(0, 64, Width, 0);
    }completion:^(BOOL finished) {
        [oldBar removeFromSuperview];
    }];
}








#pragma mark -- 消息

+(void)HUDNoticeMessage:(NSString*)message NoticeName:(NSString*)name NoticeImage:(UIImage*)image UserID:(NSUInteger)Uid Click:(void(^)(NSUInteger ID))click{

    YsNoticeHUD *HUD=[YsNoticeHUD new];
    if (!HUD.WindowNotice) {
        HUD.WindowNotice=[[UIWindow alloc]init];
        HUD.WindowNotice.windowLevel=UIWindowLevelAlert;
        HUD.WindowNotice.frame=CGRectMake(0, 0, Width, 80);
        HUD.WindowNotice.backgroundColor=[[UIColor clearColor]colorWithAlphaComponent:0];
        HUD.WindowNotice.hidden=NO;
    }

    //容器
    UIView *NoticeView = [[UIView alloc]initWithFrame:CGRectMake(0, -80, Width, 80)];
    NoticeView.backgroundColor=[UIColor colorWithRed:.95 green:.95 blue:.95 alpha:1];
    [HUD.WindowNotice addSubview:NoticeView];

    //出现
    [UIView animateWithDuration:.25 animations:^{
        NoticeView.frame=CGRectMake(0, 0, Width, 80);
    }];

    //头像
    UIImageView *Head=[[UIImageView alloc]initWithFrame:CGRectMake(15, 10, 60, 60)];
    Head.image=image;
    Head.contentMode=2;
    Head.layer.cornerRadius=Head.frame.size.width/2;
    Head.layer.masksToBounds=YES;
    [NoticeView addSubview:Head];

    //标题
    UILabel *Name=[[UILabel alloc]initWithFrame:CGRectMake(image?85:15, 10, Width-(image?85:15)-15, 20)];
    Name.font=[UIFont boldSystemFontOfSize:17];
    Name.text=name;
    [NoticeView addSubview:Name];

    //正文
    UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(image?85:15, 35, Width-(image?85:15)-15, 50)];
    label.font=[UIFont systemFontOfSize:13];
    //    label.textColor=[UIColor darkTextColor];
    label.numberOfLines=2;
    label.text=message;
    [label sizeToFit];
    [NoticeView addSubview:label];

    //点击进入详情
    UIButton *NoticeBtn=[UIButton buttonWithType:UIButtonTypeCustom];
    NoticeBtn.frame=NoticeView.frame;
    [NoticeView addSubview:NoticeBtn];
    [NoticeBtn addClickAC:^(UIButton *btn) {
        if(click)click(Uid);//传递标志参数
        [UIView animateWithDuration:.25 animations:^{//点击消失
            HUD.WindowNotice.frame=CGRectMake(0, -80, Width, 80);
        } completion:^(BOOL finished) {
            HUD.WindowNotice=nil;
        }];

    }];


    //自动消失
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{

        [UIView animateWithDuration:.25 animations:^{
            NoticeView.frame=CGRectMake(0, -80, Width, 80);
        } completion:^(BOOL finished) {
            YsNoticeHUD *EndHUD=[YsNoticeHUD new];//重新拿取 防止引用GCD记录之前的内存
            [NoticeView removeFromSuperview];
            if(EndHUD.WindowNotice.subviews.count==0)EndHUD.WindowNotice=nil;
        }];
    });
    
}
@end









#pragma mark  按钮点击

@implementation UIButton (click)
static char ClickAction;

- (void)addClickAC:(ButtonClick)TouchupInside{
    objc_setAssociatedObject(self, &ClickAction, TouchupInside, OBJC_ASSOCIATION_COPY_NONATOMIC);
    [self addTarget:self action:@selector(action:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)action:(id)sender{
    ButtonClick blockAction = (ButtonClick)objc_getAssociatedObject(self, &ClickAction);
    if (blockAction)blockAction(self);
}

@end







#pragma mark 视图离开（关闭NavHUD）
typedef void (*_IMP)(id,SEL,...);

@implementation UIViewController (HUDWillMiss)

+(void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method viewWillDisappear = class_getInstanceMethod(self, @selector(viewWillDisappear:));
        Method Func2 = class_getInstanceMethod(self, @selector(WillMiss));
        method_exchangeImplementations(viewWillDisappear, Func2);
    });
}

-(void)WillMiss{
    [YsNoticeHUD HUDNavMiss];//取消NavHUD显示
}

@end




