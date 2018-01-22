//
//  new_gameModel.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/12/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "new_gameModel.h"
#import "gameModel.h"
@implementation new_gameModel
//变量名转换
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    
    return @{
             @"casualGaming": @"休闲益智",
             @"htmlGaming"  : @"H5游戏",
             @"sportGaming" : @"动作游戏",
             @"actGaming"   : @"角色扮演"
             };
}
// Dic -> model
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    self.casualGaming = dic[@"休闲益智"];
    self.htmlGaming   = dic[@"H5游戏"];
    self.sportGaming  = dic[@"动作游戏"];
    self.actGaming    = dic[@"角色扮演"] ;
    
    return YES;
}

// model -> Dic
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    
    dic[@"休闲益智"]  =   self.casualGaming ;
    dic[@"H5游戏"]   =   self.htmlGaming  ;
    dic[@"动作游戏"]  =   self.sportGaming;
    dic[@"角色扮演"]  =   self.actGaming;
    
    return YES;
}
// 数组变量
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"casualGaming"        : [gameModel class],
             @"htmlGaming"          : [gameModel class],
             @"actGaming"           : [gameModel class],
             @"sportGaming"         : [gameModel class]
             };
}

@end
