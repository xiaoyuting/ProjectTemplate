//
//  viewModel.h
//  ProjectTemplate
//
//  Created by 雨停 on 2017/10/9.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface viewModel : NSObject
-(void)DataWithSuccess:(void(^)(NSArray * arr))success
               failure:(void(^)(NSError *error))failure;
@end
