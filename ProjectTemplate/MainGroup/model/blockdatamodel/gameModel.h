//
//  gameModel.h
//  ProjectTemplate
//
//  Created by 雨停 on 2017/12/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface gameModel : NSObject
@property (nonatomic,copy)   NSString *  game_id ;
@property (nonatomic,copy)   NSString *  title ;
@property (nonatomic,copy)   NSString *  tags ;
@property (nonatomic,copy)   NSString *  game_size ;
@property (nonatomic,copy)   NSString *  down_cnt ;
@property (nonatomic,copy)   NSString *  image ;
@property (nonatomic,copy)   NSString *  game_type ;
@property (nonatomic,copy)   NSString *  down_url ;
@property (nonatomic,copy)   NSString *  package_name ;
@property (nonatomic,copy)   NSString *  version ;
@end
