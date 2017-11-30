//
//  AppDelegate+AppService.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/9/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "AppDelegate+AppService.h"


#import "OpenUDID.h"
@implementation AppDelegate (AppService)
#pragma mark ————— 初始化服务 —————
-(void)initService{
    //注册登录状态监听
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(loginStateChange:)
                                                 name:KNotificationLoginStateChange
                                               object:nil];
   [WXApi registerApp:kAppKey_Wechat enableMTA:YES];
   
}

#pragma mark ————— 初始化window —————
-(void)initWindow{
    
}


#pragma mark ————— 初始化用户系统 —————
-(void)initUserManager{
    DLog(@"设备IMEI ：%@",[OpenUDID value]);
     //如果有本地数据，先展示TabBar 随后异步自动登录
        self.mainTabBar = [RootBaseBar new];
        self.window.rootViewController = self.mainTabBar;
        
        
     }

#pragma mark ————— 登录状态处理 —————
- (void)loginStateChange:(NSNotification *)notification
{
    BOOL loginSuccess = [notification.object boolValue];
    
    if (loginSuccess) {//登陆成功加载主窗口控制器
        
        //为避免自动登录成功刷新tabbar
        if (!self.mainTabBar || ![self.window.rootViewController isKindOfClass:[RootBaseBar class]]) {
            self.mainTabBar = [RootBaseBar new];
            
            CATransition *anima = [CATransition animation];
            anima.type = @"cube";//设置动画的类型
            anima.subtype = kCATransitionFromRight; //设置动画的方向
            anima.duration = 0.3f;
            
            self.window.rootViewController = self.mainTabBar;
            
            [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
            
        }
        
    }else {//登陆失败加载登陆页面控制器
        
        self.mainTabBar = nil;
       //RootBaseNav *loginNavi =[[RootBaseNav alloc] initWithRootViewController:[LoginViewController new]];
        
        CATransition *anima = [CATransition animation];
        anima.type = @"fade";//设置动画的类型
        anima.subtype = kCATransitionFromRight; //设置动画的方向
        anima.duration = 0.3f;
        
       
        
        [kAppWindow.layer addAnimation:anima forKey:@"revealAnimation"];
        
    }
   
}



// iOS9 以上用这个方法接收
- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options
{
 
    if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.sina.weibo"]) {
        

        return [WeiboSDK handleOpenURL:url delegate:[GMloadType loadManager]];
    }else if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.xin"]){

        return [WXApi handleOpenURL:url delegate:[GMloadType   loadManager]];
    }else if ([options[UIApplicationOpenURLOptionsSourceApplicationKey] isEqualToString:@"com.tencent.mqq"]){
        
          [QQApiInterface handleOpenURL:url delegate:[GMloadType loadManager]];
        
        return [TencentOAuth HandleOpenURL:url];
    }
    return YES;
}
 #pragma mark ————— OpenURL 回调 —————
// 支持所有iOS系统
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{

    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    
   
    
    if ([sourceApplication isEqualToString:@"com.sina.weibo"]) {
        
        return [WeiboSDK handleOpenURL:url delegate:[GMloadType loadManager]];
        
    }else if ([sourceApplication isEqualToString:@"com.tencent.xin"]){
      
        return [WXApi handleOpenURL:url delegate:[GMloadType loadManager]];
        
    }else if ([sourceApplication isEqualToString:@"com.tencent.mqq"]){
        
        [QQApiInterface handleOpenURL:url delegate:[GMloadType loadManager]];
        return [TencentOAuth HandleOpenURL:url];
    }
    
    return YES;
}

+ (AppDelegate *)shareAppDelegate{
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}


-(UIViewController *)getCurrentVC{
    
    UIViewController *result = nil;
    
    UIWindow * window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIView *frontView = [[window subviews] objectAtIndex:0];
    id nextResponder = [frontView nextResponder];
    
    if ([nextResponder isKindOfClass:[UIViewController class]])
    result = nextResponder;
    else
    result = window.rootViewController;
    
    return result;
}

-(UIViewController *)getCurrentUIVC
{
    UIViewController  *superVC = [self getCurrentVC];
    
    if ([superVC isKindOfClass:[UITabBarController class]]) {
        
        UIViewController  *tabSelectVC = ((UITabBarController*)superVC).selectedViewController;
        
        if ([tabSelectVC isKindOfClass:[UINavigationController class]]) {
            
            return ((UINavigationController*)tabSelectVC).viewControllers.lastObject;
        }
        return tabSelectVC;
    }else
    if ([superVC isKindOfClass:[UINavigationController class]]) {
        
        return ((UINavigationController*)superVC).viewControllers.lastObject;
    }
    return superVC;
}




@end
