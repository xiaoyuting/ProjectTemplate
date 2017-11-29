//
//  GMinfoVC.m
//  ProjectTemplate
//
//  Created by xy on 2017/11/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMinfoVC.h"

#import "GMloadType.h"

#import "GMshearType.h"
@interface GMinfoVC ()

@end

@implementation GMinfoVC

- (void)viewDidLoad {
  [super viewDidLoad];

}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    
//    [GMloadType loadTypeSelect:channelTypeQQ resulet:^(NSDictionary *result, NSError *error) {
//        if(result){
//            NSLog(@"result ===%@",result);
//        }else{
//            NSLog(@"error ===%@",error);
//        }
//    }];
    
    [GMshearType shearTypeSelct:channelTypeWB resulet:^(NSDictionary *result, NSError *error) {
        
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end
