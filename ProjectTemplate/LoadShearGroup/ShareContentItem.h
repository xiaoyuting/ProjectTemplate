//
//  ShareContentItem.h
//  ProjectTemplate
//
//  Created by xy on 2017/11/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ShareContentItem : NSObject
@property (strong, nonatomic) UIImage *thumbImage;
@property (strong, nonatomic) UIImage *bigImage;
@property (strong, nonatomic) NSString *imageType;
@property (strong, nonatomic) NSString *title;

@property (strong, nonatomic) NSString *weixinPyqtitle;
@property (strong, nonatomic) NSString *qqTitle;

@property (strong, nonatomic) NSString *urlString;//
@property (strong, nonatomic) NSString *urlImageString;// QQ,QQ空间分享加载图片用的
@property (strong, nonatomic) NSURL *url;
@property (strong, nonatomic) NSString *summary;
@property (strong, nonatomic) NSString *type;

@property (nonatomic, assign)BOOL isImageShareQQ; // yes 代表用图片 NO代表用URL
@property (nonatomic, strong)NSString * sinaSummary;


+ (ShareContentItem *)shareShareContentItem;

@end
