//
//  GMloadType.h
//  ProjectTemplate
//
//  Created by 雨停 on 2017/11/29.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApiInterfaceObject.h>
#import <TencentOpenAPI/QQApiInterface.h>
@class ShareContentItem;
//登录
typedef void(^resultInfo)(NSDictionary *result,NSString *error);
//分享
typedef void(^ShareResultlBlock)(NSString * shareResult);


typedef  NS_ENUM(NSInteger,  channelType) {
   channelTypeQQ = 0,
   channelTypeWX ,
   channelTypeWB
};
typedef NS_ENUM(NSInteger, ShareType) {
    ShareTypeWeiBo = 0,   // 新浪微博
    ShareTypeQQ,          // QQ好友
    ShareTypeQQZone,      // QQ空间
    ShareTypeWeiXinTimeline,// 朋友圈
    ShareTypeWeiXinSession,// 微信朋友
    ShareTypeWeiXinFavorite,// 微信收藏
};
typedef NS_ENUM(NSInteger , statusCode) {
    statusCodeSuccess=0,
    statusCodeCancel=-2
};
@interface GMloadType : NSObject<TencentSessionDelegate, TencentLoginDelegate,WBHttpRequestDelegate,WeiboSDKDelegate,WXApiDelegate,QQApiInterfaceDelegate>

+(GMloadType*)loadManager;
/**
 * loadType 登录类型
 * loadinfo 反馈数据
 */
+(void)loadTypeSelect: (channelType)loadType  resulet:(resultInfo)resultInfo;
/**
 * contentObj 分享数据
 * shareType  分享渠道
 */
+ (void)shareWithContent:(ShareContentItem *)contentObj shareType:(ShareType)shareType shareResult:(ShareResultlBlock)shareResult;
@end
