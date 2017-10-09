//
//  viewModel.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/10/9.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "viewModel.h"

@implementation viewModel
-(void)DataWithSuccess:(void (^)(NSArray *))success
               failure:(void (^)(NSError *))failure{
    [RequestManager requestWithType:HttpRequestTypeGet
                          urlString: @"http://cloud.bmob.cn/f8bb56aa119e68ee/news_list_2_0"
                         parameters:@{
        @"limit" : @20,
        @"skip" : @0
    
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
