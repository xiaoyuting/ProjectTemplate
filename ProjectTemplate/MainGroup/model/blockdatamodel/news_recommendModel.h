//
//  news_recommendModel.h
//  ProjectTemplate
//
//  Created by 雨停 on 2017/12/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface news_recommendModel : NSObject
@property (nonatomic,copy)    NSString    * title;
@property (nonatomic,strong)  NSArray     *  imgs;
@property (nonatomic,copy)    NSString    * id;
@property (nonatomic,copy)    NSString    * content;
@property (nonatomic,copy)    NSString    * view_cnt;
@property (nonatomic,copy)    NSString    * comment_cnt;

@end
