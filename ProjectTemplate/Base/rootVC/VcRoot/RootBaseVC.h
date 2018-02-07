//
//  RootBaseVC.h
//  ProjectTemplate
//
//  Created by 雨停 on 2017/9/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootBaseVC : UIViewController
- (void) pushViewController:(RootBaseVC *)VC
                 animated:(BOOL)animated ;

- (void) rootPushViewContreller:(RootBaseVC *)VC
                     animated:(BOOL)animated;
- (void) popNav;

- (NSMutableString *)webImageFitToDeviceSize:(NSMutableString *)strContent;

- (void)setNavLeftItemTitle:(NSString *)str andImage:(UIImage *)image ;

- (void)location :(id)sender;

- (void)setNavRightItemTitle:(NSString *)str andImage:(UIImage *)image;

- (void)rightItemClick:(id)sender ;

- (void)leftItemClick:(id)sender  ;

- (void)setBackBarButtonItem   ;

- (float)getTextWidth:(float)textHeight text:(NSString *)text font:(UIFont *)font ;

- (float)getTextHeight:(float)textWidth text:(NSString *)text font:(UIFont *)font ;

- (void)loadNewData ;

- (void)loadMoreData ;

- (void)setSubviews ;

- (CGFloat)naviGationH;

- (CGFloat)cellContentViewWith;
@end
