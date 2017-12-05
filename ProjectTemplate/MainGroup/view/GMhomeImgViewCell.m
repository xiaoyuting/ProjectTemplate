//
//  GMhomeImgViewCell.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/12/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMhomeImgViewCell.h"
@interface GMhomeImgViewCell()
@property   (nonatomic,strong) UIImageView  * tagImgView;
@property   (nonatomic,strong) UILabel      * cateNme;

@end
@implementation GMhomeImgViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        
    }
    return self;
}
-(void)setSubview{
    self.tagImgView = [[UIImageView alloc]init];
    [self.contentView addSubview:self.tagImgView];
    self.cateNme = [[UILabel alloc]init];
    [self.contentView addSubview:self.cateNme];
    UILabel * directions = [[UILabel alloc]init];
    
    
}
@end
