//
//  GMpopView.h
//  ProjectTemplate
//
//  Created by 雨停 on 2017/11/30.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ShareContentItem;
@interface GMpopView : NSObject
@property (nonatomic,strong)NSMutableArray  * tagArr;
@property (nonatomic,strong)UIView          * tagView;
+(GMpopView * )popView;
-(void)popShearComtentItem:(ShareContentItem *)item;
@end
