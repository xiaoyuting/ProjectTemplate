//
//  GMHomeRequest.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/11/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMHomeRequest.h"

@implementation GMHomeRequest
+(void)GMHomeRequestSuccess:(void (^)(id))success
                    failure:(void (^)(NSError *))failure{
    [RequestManager requestWithType:HttpRequestTypeGet
                          urlString: @"hhttp://demo.gm88.com/gateway/index.php"
                         parameters:@{
                                    
                                      @"action":@"index.home"
                                      
                                      }
                       successBlock:^(id response) {
                           NSLog(@"response===%@",response);
                           if (response[@"status"]){
                               NSMutableArray *tmpArr=[NSMutableArray array];
                               NSDictionary *dic = response[@"data"];
                               [tmpArr addObjectsFromArray:dic[@"results"]];
                               success(tmpArr);
                           }
                           
                           
                       } failureBlock:^(NSError *error) {
                           failure(error);
                       } progress:^(int64_t bytesProgress, int64_t totalBytesProgress) {
                           
                       }];
}

@end
