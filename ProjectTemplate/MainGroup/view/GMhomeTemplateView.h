//
//  GMhomeTemplateView.h
//  ProjectTemplate
//
//  Created by 雨停 on 2017/12/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GMhomeTemplateView : UIView
@property (nonatomic,strong)  NSArray  * arr;
-(instancetype)initWithFrame:(CGRect)frame;
-(instancetype)initWithFrame:(CGRect)frame InfoArr:(NSArray *)infoarr;

@end
