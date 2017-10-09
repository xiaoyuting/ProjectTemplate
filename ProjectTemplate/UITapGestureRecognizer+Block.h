//
//  UITapGestureRecognizer+Block.h
//  ProjectTemplate
//
//  Created by 雨停 on 2017/10/9.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^GestureBlock)(id gestureRecognizer);
@interface UIGestureRecognizer (Block)
+ (instancetype)getureRecognizerWithActionBlock:(GestureBlock)block;



@end
