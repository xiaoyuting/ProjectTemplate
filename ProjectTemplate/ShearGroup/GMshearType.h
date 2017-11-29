//
//  GMshearType.h
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

typedef void(^resultInfo)(NSDictionary *result,NSError *error);

typedef  NS_ENUM (NSInteger , shearTypeChannel){
    shearTypeChannelQzone=0,
    shearTypeChannelQq
};
@interface GMshearType : NSObject<TencentSessionDelegate, TencentLoginDelegate,WBHttpRequestDelegate,WeiboSDKDelegate,WXApiDelegate,QQApiInterfaceDelegate>
+(GMshearType*)shearManager;
/**
 * loadType 登录类型
 * loadinfo 反馈数据
 */

+(void)shearTypeSelct: (channelType)shearType resulet:(resultInfo)resultInfo;

@end
