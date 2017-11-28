//
//  GMhomeModel.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/11/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMhomeModel.h"
#import "GMhomeBannerModel.h"
#import "GMhomeRecommendModel.h"
#import "GMhomeBlockModel.h"
@implementation GMhomeModel
// 数组变量
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"banner"        : [GMhomeBannerModel class],
             @"hot_recommend" : [GMhomeRecommendModel class],
             @"block"         : [GMhomeBlockModel class]
             };
}
@end
