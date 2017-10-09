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
    
        
    /*  NSArray *titleArr       = @[@"资讯",@"青训",@"赛事",@"我的"];
        NSArray *vcNameArr      = @[@"infor",@"youth",@"match",@"me"];
        NSArray *tabIconNameArr = @[@"i_infor",@"i_youth",@"i_match",@"i_me"];
        NSMutableArray *vcArr = [NSMutableArray array];
        for (NSInteger i = 0; i < titleArr.count ; i++) {
            NSString *vcName = [NSString stringWithFormat: @"%@",vcNameArr[i]];
            XYBaseVC *vc  = [[UIStoryboard  storyboardWithName:@"Main" bundle:nil]instantiateViewControllerWithIdentifier:vcName];;
            NavigationVC  *nav = [[NavigationVC alloc]initWithRootViewController:vc];
            nav.navigationBar.barTintColor=mainColor;
            nav.tabBarItem.title = titleArr[i];
            nav.tabBarItem.image =Img(tabIconNameArr[i]);
            nav.tabBarItem.selectedImage =  Img(tabIconNameArr[i]);
            [vc.navigationController.tabBarItem setTitlePositionAdjustment:UIOffsetMake(0, -4)];
            [vcArr   addObject:nav];
            
        }
        self.viewControllers  = vcArr;*/
         
    
}

@end
