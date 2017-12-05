//
//  GMhomeGameCell.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/12/3.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMhomeGameCell.h"
#import "gameModel.h"
@interface  GMhomeGameCell()
@property  (nonatomic,strong)UIImageView   * imgView;
@property  (nonatomic,strong)UILabel       * nameLab;
@property  (nonatomic,strong)UILabel       * nameDetaileLab;
@property  (nonatomic,strong)UILabel       * tagLeftLab;
@property  (nonatomic,strong)UILabel       * tagCenterLab;
@property  (nonatomic,strong)UILabel       * tagRightLab;
@end
@implementation GMhomeGameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self= [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setSubview];
    }
    return self;
}
- (void)setSubview{
    self.imgView = [[UIImageView alloc]init];
    self.imgView.sd_cornerRadius = @4;
    self.nameLab = [[UILabel alloc]init];
    
    self.nameDetaileLab = [[UILabel alloc]init];
    self.nameDetaileLab.font = SYSTEMFONT(13);
    self.nameDetaileLab.textColor = KGray2Color;
    
    self.tagLeftLab = [self tagLab];
    self.tagCenterLab =  [self tagLab];
    self.tagRightLab  =  [self tagLab];
    [self.contentView  sd_addSubviews:@[self.imgView,self.nameLab,self.nameDetaileLab,self.tagLeftLab,self.tagCenterLab,self.tagRightLab]];

    self.imgView.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10)
    .heightIs(80)
    .widthIs(80);
    
    self.nameLab.sd_layout
    .topEqualToView(self.imgView)
    .leftSpaceToView(self.imgView, 5)
    .heightIs(16)
    .rightSpaceToView(self.contentView, 10);
    
    self.nameDetaileLab.sd_layout
    .leftSpaceToView(self.imgView, 15)
    .centerYEqualToView(self.imgView)
    .heightIs(14)
    .rightSpaceToView(self.contentView, 10);
    
    self.tagLeftLab.sd_layout
    .leftSpaceToView(self.imgView, 5)
    .bottomEqualToView(self.imgView)
    .heightIs(15);
    [self.tagLeftLab setSingleLineAutoResizeWithMaxWidth:80];
    
    self.tagCenterLab.sd_layout
    .leftSpaceToView(self.tagLeftLab, 5)
    .bottomEqualToView(self.imgView)
    .heightIs(15);
    [self.tagCenterLab  setSingleLineAutoResizeWithMaxWidth:80];
    
    self.tagRightLab.sd_layout
    .leftSpaceToView(self.tagCenterLab, 5)
    .bottomEqualToView(self.imgView)
    .heightIs(15);
    [self.tagRightLab  setSingleLineAutoResizeWithMaxWidth:80];
    
    [self setupAutoHeightWithBottomView:self.imgView bottomMargin:10];
    
}
-(UILabel * )tagLab{
    UILabel * lab = [[UILabel alloc]init];
    lab.sd_cornerRadius =@2;
    lab.font = SYSTEMFONT(12);
    lab.textColor = [UIColor    orangeColor];
    lab.layer.borderColor = [UIColor orangeColor].CGColor;
    lab.layer.borderWidth = 0.5;
    return  lab;
}
-(void)setGamemodel:(gameModel *)gamemodel{
    _gamemodel = gamemodel;
    
  
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:gamemodel.image] placeholderImage:nil];
    self.nameLab.text = gamemodel.title;
    self.nameDetaileLab.text = [NSString stringWithFormat:@"%@:%@",gamemodel.version,gamemodel.game_size];
    if(gamemodel.tags.length!=0){
        NSArray * arr = [gamemodel.tags componentsSeparatedByString:@","];
        if(arr.count==1){
            self.tagLeftLab.hidden    = NO;
            self.tagCenterLab.hidden  = YES;
            self.tagRightLab. hidden  = YES;
            self.tagLeftLab.text = [NSString stringWithFormat:@" %@ ",arr[0]];
          
        }else if(arr.count==2){
            self.tagLeftLab.hidden    = NO;
            self.tagCenterLab.hidden  = NO;
            self.tagRightLab.hidden   =YES;
            self.tagLeftLab  .text = [NSString stringWithFormat:@" %@ ",arr[0]];
            self.tagCenterLab.text = [NSString stringWithFormat:@" %@ ",arr[1]];
  
        }else{
            self.tagLeftLab.hidden    = NO;
            self.tagCenterLab.hidden  = NO;
            self.tagRightLab. hidden  = NO;
            self.tagLeftLab.  text = [NSString stringWithFormat:@" %@ ",arr[0]];
            self.tagCenterLab.text = [NSString stringWithFormat:@" %@ ",arr[1]];
            self.tagRightLab. text = [NSString stringWithFormat:@" %@ ",arr[2]];
            
        }
    }else{
        self.tagLeftLab.hidden    = YES;
        self.tagCenterLab.hidden  = YES;
        self.tagRightLab. hidden  = YES;
    }
    
}

@end
