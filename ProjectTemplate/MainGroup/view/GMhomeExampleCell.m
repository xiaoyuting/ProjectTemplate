//
//  GMhomeExampleCell.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/12/1.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMhomeExampleCell.h"
#import "GMhomeImgCell.h"
#import "GMhomeBlockModel.h"
#import "today_recommendModel.h"
@interface  GMhomeExampleCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic,strong)UICollectionView  * collecView;
@property (nonatomic,strong)UICollectionViewFlowLayout *flowLayer;
@property (nonatomic,strong) NSArray * arr;

@property (nonatomic,strong)UIImageView  * tagImg;
@property (nonatomic,strong)UILabel      * titleLab;
@property (nonatomic,strong)UILabel      * contentLab;
@property (nonatomic,strong)UILabel      * cateName;
@property (nonatomic,strong)UIButton     * moreBtn;


@end
@implementation GMhomeExampleCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    
    if( self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
            [self setSubView];
    }
    return self;
}
-(void)setinfoArr:(NSArray *)arr{
    self.arr=arr;

    
}
-(void)setSubView{
    self.tagImg     =  [[UIImageView alloc]init];
    self.tagImg.backgroundColor =KGray2Color;
    self.cateName   =  [[UILabel alloc]init];
    self.cateName.textAlignment = NSTextAlignmentLeft;
    self.cateName.textColor = KGray2Color;
    self.cateName.font =SYSTEMFONT(16);
    self.moreBtn    =  [[UIButton alloc]init];
    [self.moreBtn setTitle:@"更多推荐" forState:UIControlStateNormal];
    self.moreBtn.titleLabel.font =SYSTEMFONT(16);
    [self.moreBtn setTitleColor:KGray2Color forState:UIControlStateNormal];
    [self.moreBtn setImage:[UIImage imageNamed:@"7.jpg"] forState:UIControlStateNormal];
    self.moreBtn.titleLabel.textAlignment = NSTextAlignmentRight;
    self.moreBtn.imageView.contentMode = UIViewContentModeScaleAspectFit;
    
    self.titleLab = [[UILabel alloc]init];
    self.contentLab =[[UILabel  alloc]init];
    self.contentLab.numberOfLines =2;
    self.contentLab.font = SYSTEMFONT(14);
    self.contentLab.lineBreakMode = NSLineBreakByTruncatingTail;
    self.flowLayer  =  [[UICollectionViewFlowLayout alloc]init];
    [self.flowLayer setScrollDirection:UICollectionViewScrollDirectionHorizontal  ];
    self.collecView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayer];
    self.collecView.delegate = self;
    self.collecView.dataSource = self;
    [self.collecView registerClass:[GMhomeImgCell class] forCellWithReuseIdentifier:@"cell"];
    self.collecView.backgroundColor = [UIColor whiteColor];
    self.collecView.showsHorizontalScrollIndicator = NO;
    
    
    
    
    
    [self.contentView sd_addSubviews:@[self.tagImg,self.cateName,self.moreBtn,self.titleLab,self.contentLab, self.collecView]];
    self.tagImg.sd_layout
    .leftSpaceToView(self.contentView, 10)
    .topSpaceToView(self.contentView, 10)
    .heightIs(40)
    .widthIs(30);
    
    self.cateName.sd_layout
    .centerYEqualToView(self.tagImg)
    .leftSpaceToView(self.tagImg, 10)
    .heightIs(30);
    [self.cateName setSingleLineAutoResizeWithMaxWidth:150];
    self.moreBtn.sd_layout
    .topSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(30)
    .widthRatioToView(self.contentView, 0.4);
    // 设置button的图片的约束
    self.moreBtn.imageView.sd_layout
    .rightSpaceToView  ( self.moreBtn, 10)
    .centerYEqualToView(  self.moreBtn)
    .widthIs(8)
    .heightIs(13);

    
    // 设置button的label的约束
     self.moreBtn.titleLabel.sd_layout
    .centerYEqualToView(self.moreBtn.imageView)
    .rightSpaceToView(self.moreBtn.imageView, 5)
    .widthRatioToView(self.moreBtn, 0.8 )
    .heightRatioToView(self.moreBtn, 1);
    
    self.titleLab.sd_layout
    .topSpaceToView(self.tagImg, 5)
    .leftSpaceToView(self.contentView, 20)
    .rightSpaceToView(self.contentView, 20)
    .autoHeightRatio(0);
    
    self.contentLab.sd_layout
    .topSpaceToView(self.titleLab, 5)
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .autoHeightRatio(0)
    .maxHeightIs(40);
    
    self.collecView.sd_layout
    .topSpaceToView( self.contentLab, 10)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0)
    .heightIs(100);
    
   
   
    
    
}
-(void)setModel:(GMhomeBlockModel *)model{
    _model  = model;
    NSLog(@"%@",model.type);
    self.cateName.text = model.title;
    
    if([model.type isEqualToString:@"topic_recommend"]){
        self.titleLab.autoHeight=0;
        self.contentLab.autoHeight=0;
        [self setinfoArr:model.data];
  [self.collecView reloadData];
    }else if ([model.type isEqualToString:@"today_recommend"]){
         self.moreBtn.hidden=NO ;
        today_recommendModel * info =[today_recommendModel modelWithJSON: model.data];
        self.titleLab.text =info.title;
        self.contentLab.text = info.content;
        
        [self setinfoArr:@[@{@"image":info.image_1},@{@"image":info.image_2}]];

        [self.collecView reloadData];
        
    }else if ([model.type isEqualToString:@"game"]){
        self.moreBtn.hidden=YES;
//        self.titleLab.autoHeight=0;
//        self.contentLab.autoHeight=0;
//         [self setinfoArr:model.data];
//          [self.collecView reloadData];
    }else if ([model.type isEqualToString:@"new_game"]){
//        self.titleLab.autoHeight=0;
//        self.contentLab.autoHeight=0;
//          [self.collecView reloadData];
    }else if ([model.type isEqualToString:@"news_recommend"]){
//        self.titleLab.autoHeight=0;
//        self.contentLab.autoHeight=0;
//        [self.collecView reloadData];
    }
           [self setupAutoHeightWithBottomView:self.collecView bottomMargin:10];
   
}



//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.arr.count;
}

//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identify =@"cell";
    GMhomeImgCell*cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    NSDictionary * dic = self.arr[indexPath.row];
    [cell.imgView sd_setImageWithURL:[NSURL URLWithString:[dic objectForKey:@"image"]] placeholderImage:nil];
    return cell;
}
//设置每个item水平间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}


//设置每个item垂直间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}
//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{  //top, left, bottom, right;
    UIEdgeInsets top = {0,20,0,20};
    return top;
}
/** 头部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section{
    
    
    return CGSizeMake(0, 0);
}

/** 顶部的尺寸*/
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section{
    
    
    return CGSizeMake(0, 0);
}

//设置元素大小
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    //NSLog(@"%f",(kDeviceHeight-88-49)/4.0);
    return CGSizeMake(200,100);
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
}
@end
