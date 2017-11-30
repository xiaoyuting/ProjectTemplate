//
//  GMinfoVC.m
//  ProjectTemplate
//
//  Created by xy on 2017/11/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMinfoVC.h"

#import "GMloadType.h"
#import "ShareContentItem.h"
@interface GMinfoVC ()

@end

@implementation GMinfoVC

- (void)viewDidLoad {
    
    for(int i =0 ;i<10;i++){
        UIButton * btn  = [[UIButton alloc]initWithFrame:CGRectMake(0,64+50*i, KScreenWidth, 60)];
        [btn setTitle:[NSString stringWithFormat:@"==%d==",i] forState:UIControlStateNormal ];
        btn.backgroundColor = [UIColor orangeColor];
        btn.tag =i;
        [btn addTarget:self action:@selector(select:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn];
    }
  [super viewDidLoad];

}
-(void)select:(UIButton *)sender{
    if (sender.tag == ShareTypeWeiBo) {
        
        [GMloadType shareWithContent:[ShareContentItem shareShareContentItem] shareType:ShareTypeWeiBo shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
        
    }else if (sender.tag == ShareTypeQQ){
        [GMloadType shareWithContent:[ShareContentItem shareShareContentItem] shareType:ShareTypeQQ shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
    }else if (sender.tag == ShareTypeQQZone){
        
       
        [GMloadType shareWithContent:[ShareContentItem shareShareContentItem] shareType:ShareTypeQQZone shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
    }else if (sender.tag == ShareTypeWeiXinTimeline){
        [GMloadType shareWithContent:[ShareContentItem shareShareContentItem] shareType:ShareTypeWeiXinTimeline shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
    }else if (sender.tag == ShareTypeWeiXinSession){
        [GMloadType shareWithContent:[ShareContentItem shareShareContentItem] shareType:ShareTypeWeiXinSession shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
    }else if (sender.tag == ShareTypeWeiXinFavorite){
        [GMloadType shareWithContent:[ShareContentItem shareShareContentItem] shareType:ShareTypeWeiXinFavorite shareResult:^(NSString *shareResult) {
            NSLog(@"🐒🐒🐒🐒🐒🐒---%@", shareResult);
        }];
    }else if (sender.tag == ShareTypeWeiXinFavorite+1){
        [GMloadType loadTypeSelect:channelTypeWX resulet:^(NSDictionary *result, NSString *error) {
                    if(result){
                        NSLog(@"result ===%@",result);
                    }else{
                        NSLog(@"error ===%@",error);
                    }
                }];
    }else if (sender.tag == ShareTypeWeiXinFavorite+2){
        [GMloadType loadTypeSelect:channelTypeWB resulet:^(NSDictionary *result, NSString *error) {
                    if(result){
                        NSLog(@"result ===%@",result);
                    }else{
                        NSLog(@"error ===%@",error);
                    }
                }];
    }else if (sender.tag == ShareTypeWeiXinFavorite+3){
        [GMloadType loadTypeSelect:channelTypeQQ resulet:^(NSDictionary *result, NSString *error) {
                    if(result){
                        NSLog(@"result ===%@",result);
                    }else{
                        NSLog(@"error ===%@",error);
                    }
                }];
    }}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [GMloadType loadTypeSelect:channelTypeWX resulet:^(NSDictionary *result, NSError *error) {
//        if(result){
//            NSLog(@"result ===%@",result);
//        }else{
//            NSLog(@"error ===%@",error);
//        }
//    }];
    
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
