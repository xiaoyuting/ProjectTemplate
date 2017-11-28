//
//  GMHomeRequest.h
//  ProjectTemplate
//
//  Created by 雨停 on 2017/11/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GMhomeModel.h"
@interface GMHomeRequest : NSObject
+(void)GMHomeRequestSuccess:(void(^)(GMhomeModel * data))success
                    failure:(void(^)(NSError *error))failure;

@end
