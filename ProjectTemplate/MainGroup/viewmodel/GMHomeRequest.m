//
//  GMHomeRequest.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/11/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMHomeRequest.h"

@implementation GMHomeRequest
+(void)GMHomeRequestSuccess:(void (^)(GMhomeModel *))success
                    failure:(void (^)(NSError *))failure
{
    [RequestManager requestWithType:HttpRequestTypeGet
                          urlString: @"http://gm88.com/gateway/index.php"
                         parameters:@{
                                    
                                      @"action":@"index.home"
                                      
                                      }
                       successBlock:^(id response) {
                           NSLog(@"response===%@",response);
                           if (response[@"status"]){
                               
                               GMhomeModel * model = [GMhomeModel modelWithJSON:response[@"data"]];
                               success(model);
                           }
                           
                           
                       } failureBlock:^(NSError *error) {
                           failure(error);
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
}

@end
