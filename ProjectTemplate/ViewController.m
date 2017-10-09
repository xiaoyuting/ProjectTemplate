//
//  ViewController.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/9/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "ViewController.h"
#import "UITapGestureRecognizer+Block.h"
@interface ViewController ()
@property (nonatomic,assign)    int a ;
@end

@implementation ViewController

- (void)viewDidLoad {
    self.a=0;
    [super viewDidLoad];
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, 200, 200)];
    img.userInteractionEnabled =YES;
    //img.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    [self.view addSubview:img];
    img.backgroundColor = [UIColor redColor];
    [img addGestureRecognizer:[UITapGestureRecognizer getureRecognizerWithActionBlock:^(id gestureRecognizer) {
             NSLog(@"viewM点击事件-------");
    }]];
    // Do any additional setup after loading the view, typically from a nib.
}
/*-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    

    switch ( self.a ) {
            case 0:
                [MBProgressHUD showTipMessageInView:@"11111"];
          
            break;
            case 1:
            [MBProgressHUD showTipMessageInWindow:@"111111"];
      
            break;
            case 2:
            //[MBProgressHUD showActivityMessageInView:@"2222"];
         [MBProgressHUD showActivityMessageInView:@"33333" timer:1];
            break;
            case 3:
            //[MBProgressHUD showActivityMessageInWindow:@"222222"];
            [MBProgressHUD showActivityMessageInWindow:@"333333333" timer:1];
            break;
            case 4:
            [MBProgressHUD showSuccessMessage:@"success"];
            break;
            case 5:
            [MBProgressHUD showErrorMessage:@"error"];
            break;
            case 6:
            [MBProgressHUD showWarnMessage:@"warn"];
            break;
            case 7:
            [MBProgressHUD showInfoMessage:@"info"];
            break;
            case 8:
            [MBProgressHUD showCustomIconInView:@"nil" message:@"bire"];
            break;
            case 9:
            [MBProgressHUD showTopTipMessage:@"nihao"];
            break;
            case 10:
            
            break;
            case 11:
            
            break;


        default:
            break;
    }
   self.a++;
}*/

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
