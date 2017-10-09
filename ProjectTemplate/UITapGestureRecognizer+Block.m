//
//  UITapGestureRecognizer+Block.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/10/9.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "UITapGestureRecognizer+Block.h"
#import <objc/runtime.h>
@implementation UIGestureRecognizer (Block)
static const int target_key;


+ (instancetype)getureRecognizerWithActionBlock:(GestureBlock)block {
    __typeof(self) weakSelf =self;
    return [[weakSelf alloc]initWithActionBlock:block];
}



- (instancetype)initWithActionBlock:(GestureBlock)block{
    self = [self init];
    [self addActionBlock:block];
    [self addTarget:self  action:@selector(invoke:)];
    return self;
    
}
- (void)addActionBlock:(GestureBlock)block{
    if(block){
        objc_setAssociatedObject(self, &target_key, block, OBJC_ASSOCIATION_COPY_NONATOMIC);
    }
}
- (void)invoke:(id)sender{
    GestureBlock block = objc_getAssociatedObject(self, &target_key);
    if(block){
        block(sender);
    }
}
@end
