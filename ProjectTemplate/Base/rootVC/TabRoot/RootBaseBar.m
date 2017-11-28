//
//  RootBaseBar.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/9/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "RootBaseBar.h"
#import "RootBaseVC.h"
#import "RootBaseNav.h"
@interface RootBaseBar ()

@end

@implementation RootBaseBar

- (void)viewDidLoad {
    [super viewDidLoad];
    [self addNavigationVC];
    [self setTabBarItemTheme];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTabBarItemTheme{
   /*     [self.tabBar setTintColor:mainColor];
    self.tabBar.translucent=NO;
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       [UIColor blackColor],
                                                       NSForegroundColorAttributeName,
                                                       FontSize (10),
                                                       NSFontAttributeName,nil]
                                             forState:UIControlStateNormal];
    [[UITabBarItem appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                       mainColor,
                                                       NSForegroundColorAttributeName,
                                                       FontSize(10),
                                                       NSFontAttributeName,nil]
                                             forState:UIControlStateSelected];
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth ,  1)];
    lineView.backgroundColor = [UIColor whiteColor];
    [self.tabBar addSubview: lineView];
    //[self.tabBar setShadowImage: Img (@"new")];
    [self.tabBar setBackgroundImage: [[UIImage alloc]init]];*/
}
-(void)addNavigationVC{
    
        
     NSArray *titleArr       = @[@"首页",@"活动",@"信息",@"礼包",@"我的"];
        NSArray *vcNameArr      = @[@"main",@"activity",@"info",@"gift",@"me"];
        NSArray *tabIconNameArr = @[@"i_infor",@"i_youth",@"i_match",@"gift",@"i_me"];
        NSMutableArray *vcArr = [NSMutableArray array];
        for (NSInteger i = 0; i < titleArr.count ; i++) {
            NSString *vcName = [NSString stringWithFormat: @"GM%@VC",vcNameArr[i]];
            Class class = NSClassFromString(vcName);
            RootBaseVC * vc  = [[class alloc]init];
           RootBaseNav *nav = [[RootBaseNav alloc]initWithRootViewController:vc];
           // nav.navigationBar.barTintColor=mainColor;
            nav.tabBarItem.title = titleArr[i];
            nav.tabBarItem.image = [UIImage  imageNamed:tabIconNameArr[i]];
            nav.tabBarItem.selectedImage =  [UIImage  imageNamed:tabIconNameArr[i]];
            [vc.navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
            [vcArr   addObject:nav];
            
        }
        self.viewControllers  = vcArr;
         
    
}

@end
