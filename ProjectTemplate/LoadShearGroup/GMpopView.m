//
//  GMpopView.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/11/30.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMpopView.h"
#import <UIView+SDAutoLayout.h>
#import "UITapGestureRecognizer+Block.h"
#import "GMloadType.h"
#import "ShareContentItem.h"
static GMpopView * popView = nil;
@implementation GMpopView
+(GMpopView * )popView{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        popView = [[self alloc]init];
    });
    return popView;
}

-(void)popShearComtentItem:(ShareContentItem *)item{
    kWeakSelf(self);
      NSArray * arrPic = @[@"qzone",@"qq",@"wechat",@"wechat_fav",@"wechat_moment",@"weibo"];
      NSArray * arrName= @[@"QQ空间",@"QQ",@"微信",@"收藏",@"朋友圈",@"微博"];

    UIView * tagView = [[UIView alloc]init];
    UIWindow * window  = [UIApplication sharedApplication].keyWindow;
    tagView .tag =1000;
    [window addSubview:tagView];
    tagView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0 ));

    tagView.backgroundColor = [UIColor colorWithWhite:0.5 alpha:0.5];
    
    [tagView addGestureRecognizer:[UITapGestureRecognizer getureRecognizerWithActionBlock:^(id gestureRecognizer) {
        
        [weakself clearSubviews];
    
    }]];
   
    UIView  * shearView =[[UIView alloc]init];
    shearView.backgroundColor = [UIColor whiteColor];
    shearView.tag = 1001;
    shearView.sd_cornerRadius =@10;
    [window   addSubview:shearView];
  
    
    NSMutableArray *temp = [NSMutableArray new];
    for (int i = 0; i < arrName.count; i++) {
        UIButton * btn = [[UIButton alloc]init];
        btn.tag =i;
        [btn setTitle:arrName[i] forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:arrPic[i]] forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
        btn.titleLabel.textAlignment = NSTextAlignmentCenter;
        btn.titleLabel.font = [UIFont systemFontOfSize:12];
        btn.imageView.contentMode = UIViewContentModeScaleAspectFit;
        [shearView addSubview:btn];
        [btn addTarget:weakself action:@selector(choseShearType:) forControlEvents:UIControlEventTouchUpInside];
         btn.imageView.sd_layout
        .widthRatioToView(btn, 0.8)
        .topSpaceToView(btn, 10)
        .centerXEqualToView(btn)
        .heightRatioToView(btn, 0.6);
        
        // 设置button的label的约束
         btn.titleLabel.sd_layout
        .topSpaceToView(btn.imageView, 10)
        .leftEqualToView(btn.imageView)
        .rightEqualToView(btn.imageView)
        .bottomSpaceToView(btn, 10);
        btn.sd_layout.autoHeightRatio(1.2); // 设置高度约束
        [temp addObject:btn];
    }
    // 此步设置之后_autoMarginViewsContainer的高度可以根据子view自适应
    [  shearView setupAutoMarginFlowItems:[temp copy]
                                   withPerRowItemsCount:3
                                              itemWidth:80
                                         verticalMargin:5
                                      verticalEdgeInset:5
                                    horizontalEdgeInset:20];
    shearView.sd_layout
    .bottomSpaceToView(window, 60)
    .leftSpaceToView(window, 40)
    .rightSpaceToView(window, 40);
    UIButton  * btn  = [[UIButton alloc]init];
    btn.sd_cornerRadius=@10;
    btn.tag = 1002;
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitle:@"取消" forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [window addSubview:btn];
    [btn addTarget:weakself  action:@selector(clearSubviews) forControlEvents:UIControlEventTouchUpInside];
    btn.sd_layout
    .topSpaceToView(shearView, 10)
    .heightIs(40)
    .leftSpaceToView(window, 40)
    .rightSpaceToView(window, 40);
    
}
-(void)clearSubviews{
    UIWindow * window  = [UIApplication sharedApplication].keyWindow;
    UIView * tagView = [window viewWithTag:1000];
    UIButton * btn = [window viewWithTag:1002];
    UIView * shearView = [window  viewWithTag:1001];
    [UIView animateWithDuration:2 animations:^{
        
            [tagView removeFromSuperview];
            [btn removeFromSuperview];
            [shearView removeFromSuperview];
    }];
}
-(void)choseShearType:(UIButton *)sender{
    switch (sender.tag) {
        case 0:
            [GMloadType shareWithContent:[ShareContentItem shareShareContentItem] shareType:ShareTypeQQZone shareResult:^(NSString *shareResult) {
                DLog(@"---%@", shareResult);
            }];
            break;
        case 1:
            [GMloadType shareWithContent:[ShareContentItem shareShareContentItem] shareType:ShareTypeQQ shareResult:^(NSString *shareResult) {
                DLog(@"---%@", shareResult);
            }];
            break;
        case 2:
            [GMloadType shareWithContent:[ShareContentItem shareShareContentItem] shareType:ShareTypeWeiXinSession shareResult:^(NSString *shareResult) {
                DLog(@"---%@", shareResult);
            }];
            break;
        case 3:
            [GMloadType shareWithContent:[ShareContentItem shareShareContentItem] shareType:ShareTypeWeiXinFavorite shareResult:^(NSString *shareResult) {
                DLog(@"---%@", shareResult);
            } ];
           
            break;
        case 4:
            [GMloadType shareWithContent:[ShareContentItem shareShareContentItem] shareType:ShareTypeWeiXinTimeline shareResult:^(NSString *shareResult) {
                DLog(@"---%@", shareResult);
            }];
            
            break;
        case 5:
            [GMloadType shareWithContent:[ShareContentItem shareShareContentItem] shareType:ShareTypeWeiBo shareResult:^(NSString *shareResult) {
                DLog(@"---%@", shareResult);
            }];
            break;
       
        default:
            break;
    }
   
}
@end
