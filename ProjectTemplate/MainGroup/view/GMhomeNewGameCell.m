//
//  GMhomeNewGameCell.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/12/4.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMhomeNewGameCell.h"
#import "SegmentCate.h"
#import "GMhomeBlockModel.h"
#import "GMhomeCateCollectCell.h"
#import "new_gameModel.h"
#import "gameModel.h"
@interface   GMhomeNewGameCell()<UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UILabel  * cateName;
@property (nonatomic,strong) UICollectionView   * collect;
@property (nonatomic,strong) UICollectionViewFlowLayout * flowlayout;
@property (nonatomic,strong) NSArray     * arr;
@property (nonatomic,strong) SegmentCate  * seg;
@property (nonatomic,strong) new_gameModel * gameGroupmodel;
@end
@implementation GMhomeNewGameCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setSubview];
    }
    return self;
}

- (void)setSubview{

    self.cateName = [[UILabel alloc]init];
    self.seg = [[SegmentCate alloc]init];
    self.seg.segmentedControlBorederStyle = SegmentedControlButtonBorderShow;
    
    self.flowlayout = [[UICollectionViewFlowLayout alloc]init];
   [self.flowlayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    self.collect = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowlayout];
    self.collect.backgroundColor = KWhiteColor;
    [self.collect  registerClass:[GMhomeCateCollectCell class] forCellWithReuseIdentifier: @"cell"];
    self.collect.delegate =self;
    self.collect.dataSource =self;
    
    [self.contentView sd_addSubviews:@[self.cateName,self.seg,self.collect]];
    
    
    
    self.cateName.sd_layout
    .topSpaceToView(self.contentView, 10)
    .leftSpaceToView(self.contentView, 10)
    .heightIs(30);
    [self.cateName setSingleLineAutoResizeWithMaxWidth:150];
    self.seg.sd_layout
    .topSpaceToView(self.cateName, 10)
    .leftSpaceToView(self.contentView, 10)
    .rightSpaceToView(self.contentView, 10)
    .heightIs(40);
    
    self.collect.sd_layout
    .topSpaceToView(self.seg, 10)
    .heightIs(100)
    .leftSpaceToView(self.contentView, 0)
    .rightSpaceToView(self.contentView, 0);
    [self setupAutoHeightWithBottomView:self.collect bottomMargin:10];
    
}
- (void)setGameNewmodel:(GMhomeBlockModel *)gameNewmodel{
    _gameNewmodel = gameNewmodel  ;
    self.cateName.text =gameNewmodel.title;
    self.gameGroupmodel  = [new_gameModel modelWithJSON:gameNewmodel.data];
//    [gameNewmodel.data enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//        
//    }];
    
    self.arr = self.gameGroupmodel.casualGaming;
    
    [self.collect   reloadData];
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
    GMhomeCateCollectCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:identify forIndexPath:indexPath];
    gameModel   * model = [gameModel modelWithJSON:self.arr[indexPath.row]];

    cell.gamemodel  =model;
   
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
    return CGSizeMake(80,100);
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    
}

@end
