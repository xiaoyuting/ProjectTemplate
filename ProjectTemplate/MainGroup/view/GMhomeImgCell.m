//
//  GMhomeImgCell.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/12/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMhomeImgCell.h"

@implementation GMhomeImgCell
-(id)initWithFrame:(CGRect)frame{
    if(self =[super initWithFrame:frame]){
        self.imgView  = [[UIImageView alloc]init];
        [self.contentView addSubview:self.imgView];
        self.imgView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
    }
    return self;
}
@end
