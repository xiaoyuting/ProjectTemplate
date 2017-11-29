//
//  GMloadType.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/11/29.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMloadType.h"

static GMloadType * loadManger;
@interface GMloadType()<NSURLSessionTaskDelegate>
@property (nonatomic,strong)TencentOAuth *tencentOAuth;
@property (nonatomic,strong)NSMutableArray * permissionArray;
@property (nonatomic,copy)  resultInfo  resultBlock;
@property (nonatomic,assign)channelType LoginType;
@property (nonatomic, strong)NSString * access_token;
@end

@implementation GMloadType
+(GMloadType*)loadManager {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loadManger = [[self alloc]init];
        [loadManger registerApp];
    });
    return loadManger;
    
}
+ (void)initialize
{
    [GMloadType loadManager];
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        loadManger = [super allocWithZone:zone];
        [loadManger registerApp];
    });
    return loadManger ;
}

- (id)copyWithZone:(nullable NSZone *)zone
{
    return loadManger;
}


-(void)registerApp{
    [WXApi registerApp:kAppKey_Wechat];
    [WeiboSDK registerApp:kAppKey_sina];
    _tencentOAuth=[[TencentOAuth alloc]initWithAppId:kAppKey_Tencent andDelegate:self];
    
    //设置权限数据 ， 具体的权限名，在sdkdef.h 文件中查看。
    _permissionArray = [NSMutableArray arrayWithArray:@[/** 获取用户信息 */
                                                        kOPEN_PERMISSION_GET_USER_INFO,
                                                        /** 移动端获取用户信息 */
                                                        kOPEN_PERMISSION_GET_SIMPLE_USER_INFO,
                                                        /** 获取登录用户自己的详细信息 */
                                                        kOPEN_PERMISSION_GET_INFO]];
    
}

+(void)loadTypeSelect:(channelType)loadType resulet:(resultInfo)resultInfo{
    loadManger.resultBlock = resultInfo;
    loadManger.LoginType =  loadType ;
    if(loadType==channelTypeQQ){
    [loadManger.tencentOAuth authorize: loadManger.permissionArray inSafari:NO];
    }else if(loadType==channelTypeWX){
        //构造SendAuthReq结构体
        SendAuthReq* req =[[SendAuthReq alloc ] init ];
        req.scope = @"snsapi_userinfo" ;
        //第三方向微信终端发送一个SendAuthReq消息结构
        [WXApi sendReq:req];
    }else if(loadType==channelTypeWB){
        
        WBAuthorizeRequest *request = [WBAuthorizeRequest request];
        request.redirectURI = kSinaRedirectURI;
                //        request.scope = @"follow_app_official_microblog";
        
        [WeiboSDK sendRequest:request];
        
    }
}

/**
 * 登录成功后的回调
 */
- (void)tencentDidLogin{

    /** Access Token凭证，用于后续访问各开放接口 */
    if (_tencentOAuth.accessToken) {

        //获取用户信息。 调用这个方法后，qq的sdk会自动调用
        //- (void)getUserInfoResponse:(APIResponse*) response
        //这个方法就是 用户信息的回调方法。

        [_tencentOAuth getUserInfo];
    }else{

        NSLog(@"accessToken 没有获取成功");
    }

}

/**
 * 登录失败后的回调
 * \param cancelled 代表用户是否主动退出登录
 */
- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled) {
        self.resultBlock(nil, @"用户点击取消按键,主动退出登录");
        NSLog(@" 用户点击取消按键,主动退出登录");
    }else{
        NSLog(@"其他原因， 导致登录失败");
    }
}

/**
 * 登录时网络有问题的回调
 */
- (void)tencentDidNotNetWork{
    NSLog(@"没有网络了， 怎么登录成功呢");
}


/**
 * 因用户未授予相应权限而需要执行增量授权。在用户调用某个api接口时，如果服务器返回操作未被授权，则触发该回调协议接口，由第三方决定是否跳转到增量授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \param permissions 需增量授权的权限列表。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启增量授权流程。若需要增量授权请调用\ref TencentOAuth#incrAuthWithPermissions: \n注意：增量授权时用户可能会修改登录的帐号
 */
- (BOOL)tencentNeedPerformIncrAuth:(TencentOAuth *)tencentOAuth withPermissions:(NSArray *)permissions{
    
    // incrAuthWithPermissions是增量授权时需要调用的登录接口
    // permissions是需要增量授权的权限列表
    [tencentOAuth incrAuthWithPermissions:permissions];
    return NO; // 返回NO表明不需要再回传未授权API接口的原始请求结果；
    // 否则可以返回YES
}

/**
 * [该逻辑未实现]因token失效而需要执行重新登录授权。在用户调用某个api接口时，如果服务器返回token失效，则触发该回调协议接口，由第三方决定是否跳转到登录授权页面，让用户重新授权。
 * \param tencentOAuth 登录授权对象。
 * \return 是否仍然回调返回原始的api请求结果。
 * \note 不实现该协议接口则默认为不开启重新登录授权流程。若需要重新登录授权请调用\ref TencentOAuth#reauthorizeWithPermissions: \n注意：重新登录授权时用户可能会修改登录的帐号
 */
- (BOOL)tencentNeedPerformReAuth:(TencentOAuth *)tencentOAuth{
    return YES;
}

/**
 * 用户通过增量授权流程重新授权登录，token及有效期限等信息已被更新。
 * \param tencentOAuth token及有效期限等信息更新后的授权实例对象
 * \note 第三方应用需更新已保存的token及有效期限等信息。
 */
- (void)tencentDidUpdate:(TencentOAuth *)tencentOAuth{
    NSLog(@"增量授权完成");
    if (tencentOAuth.accessToken
        && 0 != [tencentOAuth.accessToken length])
    { // 在这里第三方应用需要更新自己维护的token及有效期限等信息
        // **务必在这里检查用户的openid是否有变更，变更需重新拉取用户的资料等信息** _labelAccessToken.text = tencentOAuth.accessToken;
        //[self.delegateInfo updateTokenInfo:tencentOAuth];
        
    }
    else
    {
        NSLog(@"增量授权不成功，没有获取accesstoken");
    }
    
}

/**
 * 用户增量授权过程中因取消或网络问题导致授权失败
 * \param reason 授权失败原因，具体失败原因参见sdkdef.h文件中\ref UpdateFailType
 */
- (void)tencentFailedUpdate:(UpdateFailType)reason{
    
    switch (reason)
    {
        case kUpdateFailNetwork:
        {
            // _labelTitle.text=@"增量授权失败，无网络连接，请设置网络";
            NSLog(@"增量授权失败，无网络连接，请设置网络");
            break;
        }
        case kUpdateFailUserCancel:
        {
            // _labelTitle.text=@"增量授权失败，用户取消授权";
            NSLog(@"增量授权失败，用户取消授权");
            break;
        }
        case kUpdateFailUnknown:
        default:
        {
            NSLog(@"增量授权失败，未知错误");
            break;
        }
    }
    
    
}

/**
 * 获取用户个人信息回调
 * \param response API返回结果，具体定义参见sdkdef.h文件中\ref APIResponse
 * \remarks 正确返回示例: \snippet example/getUserInfoResponse.exp success
 *          错误返回示例: \snippet example/getUserInfoResponse.exp fail
 */
- (void)getUserInfoResponse:(APIResponse*) response{
    if (response.retCode == URLREQUEST_SUCCEED)
    {
        NSDictionary *paramter = @{@"third_id" : [_tencentOAuth openId],
                                   @"third_name" : [response.jsonResponse valueForKeyPath:@"nickname"],
                                   @"third_image":[response.jsonResponse valueForKeyPath:@"figureurl_qq_2"],
                                   @"access_token":[_tencentOAuth accessToken]};
        
        if (self.resultBlock)
        {
            self.resultBlock(paramter, nil);
        }
    }
    else
    {
        NSLog(@"登录失败!");
    }
}



#pragma mark - WXApiDelegate

-(void) onResp:(BaseResp*)resp
{
    SendAuthResp *aresp = (SendAuthResp *)resp;
    
    if (resp.errCode ==statusCodeSuccess) {
        NSString *code = aresp.code;
        [self   getWeiXinUserInfoWithCode:code];
    }else if(resp.errCode==statusCodeCancel){
        if (self.resultBlock)
        {
            self.resultBlock(nil, @"您取消了");
        }
    } else{
        
        if (self.resultBlock)
        {
            self.resultBlock(nil, @"授权失败");
        }
    }
    
    
}


- (void)getWeiXinUserInfoWithCode:(NSString *)code
{
    NSOperationQueue * queue = [[NSOperationQueue alloc]init];
    
    NSBlockOperation * getAccessTokenOperation = [NSBlockOperation blockOperationWithBlock:^{
        
        NSString * urlStr = [NSString stringWithFormat:@"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code",kAppKey_Wechat,kSecret_Wechat,code];
        NSURL * url = [NSURL URLWithString:urlStr];
        NSString *responseStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *responseData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        self.access_token = [dic objectForKey:@"access_token"];
    }];
    
    NSBlockOperation * getUserInfoOperation = [NSBlockOperation blockOperationWithBlock:^{
        NSString *urlStr =[NSString stringWithFormat:@"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@",self.access_token,kAppKey_Wechat];
        NSURL * url = [NSURL URLWithString:urlStr];
        NSString *responseStr = [NSString stringWithContentsOfURL:url encoding:NSUTF8StringEncoding error:nil];
        NSData *responseData = [responseStr dataUsingEncoding:NSUTF8StringEncoding];
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:responseData options:kNilOptions error:nil];
        NSDictionary *paramter = @{@"third_id"    : dic[@"openid"],
                                   @"third_name"  : dic[@"nickname"],
                                   @"third_image" : dic[@"headimgurl"],
                                   @"access_token": self.access_token};
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            
            //                _resultBlock;
            self.resultBlock(paramter, nil);
        }];
    }];
    
    [getUserInfoOperation addDependency:getAccessTokenOperation];
    
    [queue addOperation:getAccessTokenOperation];
    [queue addOperation:getUserInfoOperation];
}


#pragma mark - WeiboSDKDelegate

- (void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

- (void)didReceiveWeiboResponse:(WBBaseResponse *)response
{
    NSLog(@"token %@", [(WBAuthorizeResponse *) response accessToken]);
    NSLog(@"uid %@", [(WBAuthorizeResponse *) response userID]);
    if(response.statusCode==    WeiboSDKResponseStatusCodeSuccess ){
        [self getWeiBoUserInfo:[(WBAuthorizeResponse *) response userID] token:[(WBAuthorizeResponse *) response accessToken]];
        
    }else{
        self.resultBlock(nil, @"失败了");
    }
}

- (void)getWeiBoUserInfo:(NSString *)uid token:(NSString *)token
{
    NSString *url =[NSString stringWithFormat:@"https://api.weibo.com/2/users/show.json?uid=%@&access_token=%@&source=%@",uid,token,kAppKey_sina];
    NSURL *zoneUrl = [NSURL URLWithString:url];
    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:[[NSOperationQueue alloc] init]];
    // 创建任务
    NSURLSessionDataTask * task = [session dataTaskWithRequest:[NSURLRequest requestWithURL:zoneUrl] completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
        NSLog(@"%@", [NSThread currentThread]);
        
        NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
        NSLog(@"%@",dic);
        
        NSDictionary *paramter = @{@"third_id" : [dic valueForKeyPath:@"idstr"],
                                   @"third_name" : [dic valueForKeyPath:@"screen_name"],
                                   @"third_image":[dic valueForKeyPath:@"avatar_hd"],
                                   @"access_token":token};
        
        [[NSOperationQueue mainQueue] addOperationWithBlock:^{
            if (self.resultBlock)
            {
                _resultBlock(paramter, nil);
            }
        }];
        
    }];
    
    // 启动任务
    [task resume];
}
- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"收到网络回调", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",result]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    title = NSLocalizedString(@"请求异常", nil);
    alert = [[UIAlertView alloc] initWithTitle:title
                                       message:[NSString stringWithFormat:@"%@",error]
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedString(@"确定", nil)
                             otherButtonTitles:nil];
    [alert show];
}
@end
