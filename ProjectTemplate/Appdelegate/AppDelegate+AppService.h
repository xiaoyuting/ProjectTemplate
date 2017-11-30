//
//  AppDelegate+AppService.h
//  ProjectTemplate
//
//  Created by 雨停 on 2017/9/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "AppDelegate.h"
#import "GMloadType.h"


#define ReplaceRootViewController(vc) [[AppDelegate shareAppDelegate] replaceRootViewController:vc]
@interface AppDelegate (AppService)


/**
 包含第三方 和 应用内业务的实现，减轻入口代码压力
 */


//初始化服务
-(void)initService;

//初始化 window
-(void)initWindow;

 

 



//单例
+ (AppDelegate *)shareAppDelegate;

/**
 当前顶层控制器
 */
-(UIViewController*) getCurrentVC;

-(UIViewController*) getCurrentUIVC;
@end
