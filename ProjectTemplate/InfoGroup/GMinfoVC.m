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

#import "GMpopView.h"

@interface GMinfoVC ()

@end

@implementation GMinfoVC

- (void)viewDidLoad {
    
    [self setNavLeftItemTitle:nil andImage:[UIImage imageNamed:@"rightNav"]];
    [self setNavRightItemTitle:nil andImage:[UIImage imageNamed:@"rightNav"]];
  [super viewDidLoad];

}
-(void)rightItemClick:(id)sender{
    [[GMpopView popView] popShearComtentItem:nil];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
