//
//  GMhomeCateCollectCell.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/11/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMhomeCateCollectCell.h"

#import "GMhomeBlockModel.h"
#import "gameModel.h"

@interface GMhomeCateCollectCell()

@property (nonatomic,strong) UIImageView  * img;
@property (nonatomic,strong)  UILabel     * name;

@end
@implementation GMhomeCateCollectCell
-(instancetype)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame]){
        [self setSubView];
    }
    return self;
}
-(void)setSubView{
     self.img = [[UIImageView alloc]init];
    [self.img sd_setImageWithURL:[NSURL URLWithString:@"http://demo.gm88.com/uploads/images/1493020885.jpeg"] placeholderImage:nil];
    self.name =[[UILabel alloc]init];
    self.name.font = [UIFont systemFontOfSize:12];
    self.name.textAlignment = NSTextAlignmentCenter;
    [self.contentView sd_addSubviews:@[self.img ,self.name]];
  
    self.img.sd_layout
    .topEqualToView(self.contentView)
    .widthRatioToView(self.contentView, 0.6)
    .heightEqualToWidth()
    .centerXEqualToView(self.contentView);
    
   self.name.sd_layout
    .topSpaceToView(self.img, 5)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .bottomSpaceToView(self.contentView, 0);
    

    
}
-(void)setModel:(GMhomeBlockModel *)model{
    _model =model;
    self.name.text =model.title;
}

-(void)setGamemodel:(gameModel *)gamemodel{
    _gamemodel = gamemodel;
    NSLog(@"%@",gamemodel .title);
    [self.img sd_setImageWithURL:[NSURL URLWithString:gamemodel.image] placeholderImage:nil];
    self.name.text =gamemodel.title;
    
}
@end
