//
//  GMshearType.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/11/29.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMshearType.h"
static GMshearType * shearManager;
@interface GMshearType()
@property (nonatomic,strong)TencentOAuth *tencentOAuth;
@property (nonatomic,copy)  resultInfo  resultBlock;
@property (nonatomic,assign)channelType LoginType;
@end
@implementation GMshearType
+(GMshearType*)shearManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shearManager = [[self alloc]init];
        
    });
    return shearManager;
    
}
+ (void)initialize
{
    [GMshearType  shearManager];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shearManager = [super allocWithZone:zone];
        shearManager. tencentOAuth=[[TencentOAuth alloc]initWithAppId:kAppKey_Tencent andDelegate:nil];
    });
    return shearManager ;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return shearManager;
}

-(void)registerApp{
    [WXApi registerApp:kAppKey_Wechat];
    [WeiboSDK registerApp:kAppKey_sina];
    _tencentOAuth=[[TencentOAuth alloc]initWithAppId:kAppKey_Tencent andDelegate:nil];
    
}

+(void)shearTypeSelct:(channelType)shearType resulet:(resultInfo)resultInfo{
   shearManager.resultBlock = resultInfo;
   shearManager.LoginType =  shearType ;
    if(shearType==channelTypeQQ){
        QQApiTextObject * text = [QQApiTextObject objectWithText:@"测试四岁死 is"];
        SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:text];
        //将内容分享到qq
        QQApiSendResultCode sent = [QQApiInterface SendReqToQZone:req];
        
    }else if(shearType==channelTypeWX){
        
        if(![WXApi isWXAppInstalled]){
            return;
        }
        //封装mediaMessage对象
        WXMediaMessage *message = [WXMediaMessage message];
        
        //设置微信分享的title
        [message setTitle:@"wqewqewq"];
        //设置分享描述内容
        [message setDescription:@"wqewqewqe"];
        //设置分享所需图片
        [message setThumbImage:[UIImage imageNamed:@"icon_share"]];
        
        NSLog(@"调用了微信");
        
        //封装WXWebpageObject对象
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl =@"wqewqewqewqewqew";
        
        message.mediaObject = ext;
        
        //发送请求
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene = 1;
        
        [WXApi sendReq:req];
    }else if(shearType==channelTypeWB){
//        if (![WeiboSDK isWeiboAppInstalled]) {
//
//            return;
//        }
        WBMessageObject *message = [WBMessageObject message];
        message.text = @"text";
        WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:message];
        [WeiboSDK sendRequest:request];
        
       
        
    }
    
    
}

-(void)onResp:(id)resp{
    //Wechat分享返回
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        SendMessageToWXResp * tmpResp = (SendMessageToWXResp *)resp;
        if (tmpResp.errCode == WXSuccess) {
            //SBDebugLog(@"分享至微信成功!");
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shareToWechatResponseNotification" object:nil];
        }else{
            //SBDebugLog(@"分享至微信失败!");
        }
    }
    //QQ分享返回
    if ([resp isKindOfClass:[SendMessageToQQResp class]]) {
        SendMessageToQQResp * tmpResp = (SendMessageToQQResp *)resp;
        if (tmpResp.type == ESENDMESSAGETOQQRESPTYPE && [tmpResp.result integerValue] == 0) {
            [[NSNotificationCenter defaultCenter] postNotificationName:@"shareToQQResponseNotification" object:nil];
        }
    }
}
#pragma mark -- QqSDKDelegate
/**
 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req{
    NSLog(@" ----req %@",req);
}

/**
 处理来至QQ的响应
 */
//- (void)onResp:(QQBaseResp *)resp{
//    NSLog(@" ----resp %@",resp);
//    if ([resp.class isSubclassOfClass: [SendMessageToQQResp class]]) {  //QQ分享回应
//        
//        
//        //SendMessageToQQResp *msg = (SendMessageToQQResp *)resp;
//        NSLog(@"code %@  errorDescription %@  infoType %@",resp.result,resp.errorDescription,resp.extendInfo);
//        
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"qqShearInfo" object:resp.result];
//    }
//}

/**
 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response{
    
}

#pragma mark -- WeiboSDKDelegate
- (void)didReceiveWeiboResponse:(WBBaseResponse *)response {
    if ([response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        if (response.statusCode == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"新浪微博分享成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"新浪微博分享失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    else if ([response isKindOfClass:WBAuthorizeResponse.class]){
        if (response.statusCode == 0) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"成功" message:@"新浪微博授权成功" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
        else {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"失败" message:@"新浪微博授权失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
            [alert show];
        }
    }
    
}




@end
