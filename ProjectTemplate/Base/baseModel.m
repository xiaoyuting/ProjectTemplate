//
//  baseModel.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/9/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "baseModel.h"

@implementation baseModel
//变量名转换
+ (nullable NSDictionary<NSString *, id> *)modelCustomPropertyMapper
{
    
    return @{
             @"descrip":@"description"
            
             };
}
// Dic -> model
- (BOOL)modelCustomTransformFromDictionary:(NSDictionary *)dic {
    
    self.descrip = dic[@"description"];
    
    
    return YES;
}

// model -> Dic
- (BOOL)modelCustomTransformToDictionary:(NSMutableDictionary *)dic {
    
    dic[@"description"] =self.descrip;
    
    
    return YES;
}
// 数组变量
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"arrname"        : [NSArray class]
             
             };
}

@end
