//
//  RootBaseVC.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/9/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "RootBaseVC.h"

@interface RootBaseVC ()

@end

@implementation RootBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)pushViewController:(RootBaseVC *)VC animated:(BOOL)animated{
    VC.hidesBottomBarWhenPushed =YES;
    [self.navigationController pushViewController:VC animated:animated];
}
-(void)rootPushViewContreller:(RootBaseVC *)VC animated:(BOOL)animated{
    VC.hidesBottomBarWhenPushed =YES;
    [ self.navigationController popToViewController:VC animated:animated];
}

-(void)popNav{
    BOOL aninated =YES;
    if(self.navigationController.viewControllers.count==2){
       
        aninated =NO;
        
    }
    [self.navigationController popViewControllerAnimated:aninated];
}
- (NSMutableString *)webImageFitToDeviceSize:(NSMutableString *)strContent
{
    [strContent appendString:@"<html>"];
    [strContent appendString:@"<head>"];
    [strContent appendString:@"<meta charset=\"utf-8\">"];
    [strContent appendString:@"<meta id=\"viewport\" name=\"viewport\" content=\"width=device-width*0.9,initial-scale=1.0,maximum-scale=1.0,user-scalable=false\" />"];
    [strContent appendString:@"<meta name=\"apple-mobile-web-app-capable\" content=\"yes\" />"];
    [strContent appendString:@"<meta name=\"apple-mobile-web-app-status-bar-style\" content=\"black\" />"];
    [strContent appendString:@"<meta name=\"black\" name=\"apple-mobile-web-app-status-bar-style\" />"];
    [strContent appendString:@"<style>img{width:100%;}</style>"];
    [strContent appendString:@"<style>table{width:100%;}</style>"];
    [strContent appendString:@"<title>webview</title>"];
    return strContent;
}
- (void)setBackBarButtonItem {
    UIBarButtonItem *backItem =[[UIBarButtonItem alloc] init];
    UIButton *btnleftView = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 44, 44)];
    btnleftView.imageEdgeInsets =UIEdgeInsetsMake(0, -30, 0, 0);
    
    if ([self.navigationController.viewControllers count] > 1) {
        
        [btnleftView setImage:[UIImage imageNamed:@"nav_back"] forState:UIControlStateNormal];
        [btnleftView setContentMode:UIViewContentModeScaleAspectFit];
        [backItem  setCustomView:btnleftView];
        [btnleftView addTarget:self action:@selector(popNav) forControlEvents:UIControlEventTouchUpInside];
        self.navigationItem.leftBarButtonItem = backItem;
        
    }
}

- (void)setNavLeftItemTitle:(NSString *)str andImage:(UIImage *)image {
    //    if ([self.navigationController.viewControllers count] ==1){
    if ([str isEqualToString:@""] || !str)
    {
        UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
    else if(str&&image ){
        UIButton  * btn= [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(-10, 0, 80, 20);
        [btn setTitle:str  forState:UIControlStateNormal];
        [btn setImage:[UIImage imageNamed:@"zhankai"] forState:UIControlStateNormal];
        UIBarButtonItem *LeftBarButton = [[UIBarButtonItem alloc] initWithCustomView:btn];
        self.navigationItem.leftBarButtonItem =LeftBarButton;
        [btn addTarget:self action:@selector(location:) forControlEvents:UIControlEventTouchUpInside];
    }else if([str isEqualToString:@"返回"]){
        //创建一个UIButton
        UIButton *backButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 24)];
        backButton.adjustsImageWhenHighlighted = NO;
        //设置UIButton的图像
        [backButton setTitle:@"返回" forState:UIControlStateNormal];
        backButton.titleLabel.font = [UIFont boldSystemFontOfSize:14];
        backButton.imageEdgeInsets = UIEdgeInsetsMake(0, -5, 0, 0);
        backButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 0, 0);
        backButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
        [backButton setImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        //给UIButton绑定一个方法，在这个方法中进行popViewControllerAnimated
        [backButton addTarget:self action:@selector(leftItemClick:) forControlEvents:UIControlEventTouchUpInside];
        //然后通过系统给的自定义BarButtonItem的方法创建BarButtonItem
        UIBarButtonItem *backItem = [[UIBarButtonItem alloc]initWithCustomView:backButton];
        //覆盖返回按键
        self.navigationItem.leftBarButtonItem = backItem;
    }
    else
    {
        UIBarButtonItem *leftItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(leftItemClick:)];
        self.navigationItem.leftBarButtonItem = leftItem;
    }
}

-(void)location :(id)sender{
}
- (void)setNavRightItemTitle:(NSString *)str andImage:(UIImage *)image
{
    if ([str isEqualToString:@""] || !str)
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
    else
    {
        UIBarButtonItem *rightItem =[[UIBarButtonItem alloc] initWithTitle:str style:UIBarButtonItemStylePlain target:self action:@selector(rightItemClick:)];
        [rightItem setTintColor:[UIColor whiteColor]];
        [rightItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont boldSystemFontOfSize:14],NSFontAttributeName, nil] forState:UIControlStateNormal];
        self.navigationItem.rightBarButtonItem = rightItem;
    }
}

- (void)rightItemClick:(id)sender {
    
}

- (void)leftItemClick:(id)sender{
    
}

- (float)getTextWidth:(float)textHeight text:(NSString *)text font:(UIFont *)font {
    if (!text.length) {
        return 0;
    }
    float origin = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, textHeight) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.width;
    return ceilf(origin);
}

- (float)getTextHeight:(float)textWidth text:(NSString *)text font:(UIFont *)font {
    if (!text.length) {
        return 0;
    }
    float origin = [text boundingRectWithSize:CGSizeMake(textWidth, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName: font} context:nil].size.height;
    return ceilf(origin);
}


- (void)loadNewData {
    
}
- (void)loadMoreData{
    
}
- (void)setSubviews {
    
}
- (CGFloat)cellContentViewWith
{
    CGFloat width = [UIScreen mainScreen].bounds.size.width;
    
    // 适配ios7横屏
    if ([UIApplication sharedApplication].statusBarOrientation != UIInterfaceOrientationPortrait && [[UIDevice currentDevice].systemVersion floatValue] < 8) {
        width = [UIScreen mainScreen].bounds.size.height;
    }
    return width;
}

- (CGFloat)naviGationH{
    CGFloat h =0;
    // 状态栏(statusbar)
    
    CGRect StatusRect = [[UIApplication sharedApplication] statusBarFrame];
    
    //标题栏
    
    CGRect NavRect = self.navigationController.navigationBar.frame;
    
    h= StatusRect.size.height+NavRect.size.height;
    
    return h;
    
}
@end
