//
//  RootBaseNav.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/9/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "RootBaseNav.h"

@interface RootBaseNav ()

@end

@implementation RootBaseNav

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationBar];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    if (self.childViewControllers.count > 0) {
        viewController.hidesBottomBarWhenPushed = YES;
    }
    [super pushViewController:viewController animated:animated];
}

-(void)setupNavigationBar{
    
    [[UINavigationBar appearance] setBarTintColor:[UIColor redColor]];
    UIImage *bgImage = [self imageWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [self naviBarH]) alphe:1.0 color:[UIColor redColor]];
    [[UINavigationBar appearance] setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setTitleTextAttributes:@{
                                                           NSFontAttributeName:[UIFont boldSystemFontOfSize:18],
                                                           NSForegroundColorAttributeName:[UIColor whiteColor]
                                                           }];
    //    UINavigationBar * bar = self.navigationController.navigationBar;
    //    UIImage *bgImage = [self imageWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 64) alphe:1.0];
    //    [bar setBackgroundImage:bgImage forBarMetrics:UIBarMetricsDefault];
    
    
}
- (UIImage *) imageWithFrame:(CGRect)frame alphe:(CGFloat)alphe color:(UIColor *)color{
    frame = CGRectMake(0, 0, frame.size.width, frame.size.height);
    //UIColor *redColor = [UIColor colorWithRed:1 green:0 blue:0 alpha:alphe];
    UIGraphicsBeginImageContext(frame.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, frame);
    UIImage *theImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return theImage;
}
-(CGFloat)naviBarH{
    CGFloat  h = 0;
   
    // 状态栏(statusbar)
    
    CGRect StatusRect = [[UIApplication sharedApplication] statusBarFrame];
    
    //标题栏
    
    CGRect NavRect = self.navigationBar.frame;
    
    h= StatusRect.size.height+NavRect.size.height;
    
    return h;
    

}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
