//
//  ShareContentItem.m
//  ProjectTemplate
//
//
//  Created by xy on 2017/11/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "ShareContentItem.h"

@implementation ShareContentItem


+ (ShareContentItem *)shareShareContentItem
{
    ShareContentItem * item = [[ShareContentItem alloc]init];
    item.title = @"分享测试";
    item.thumbImage = [UIImage imageNamed:@"search"];
    item.bigImage = [UIImage imageNamed:@"tu"];
    item.summary = @"哈哈哈哈哈哈哈哈哈2!!!";
    item.urlString = @"https://www.baidu.com";
    item.sinaSummary = @"一般情况新浪微博的Summary和微信,QQ的是不同的,新浪微博的是一般带链接的,而且总共字数不能超过140字";
    return item;
}


@end
