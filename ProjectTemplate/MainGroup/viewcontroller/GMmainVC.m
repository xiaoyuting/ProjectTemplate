//
//  GMmainVC.m
//  ProjectTemplate
//
//  Created by xy on 2017/11/26.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "GMmainVC.h"

#import "UITapGestureRecognizer+Block.h"
#import "WRNavigationBar.h"
#import "SDCycleScrollView.h"
#import "GMHomeRequest.h"




#import "GMhomeBannerModel.h"
#import "GMhomeRecommendModel.h"
#import "GMhomeBlockModel.h"
#import "today_recommendModel.h"
#import "gameModel.h"
#import "new_gameModel.h"


#import "GMhomeCateCollectCell.h"
#import "GMhomeExampleCell.h"
#import "GMhomeGameCell.h"
#import "GMhomeNewGameCell.h"
@interface GMmainVC ()<UITableViewDelegate, UITableViewDataSource,  SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SDCycleScrollView * advView;
@property (nonatomic, strong) SDCycleScrollView * adTacticView;
@property (nonatomic, strong) SDCycleScrollView * adNewsView;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, assign) CGFloat  oldOffset;
@property (nonatomic, strong) NSMutableArray  * dataArr;
@property (nonatomic,strong)  UICollectionView * cateCollectView;
@property (nonatomic,strong)  NSMutableArray   * cateArr;


@end

@implementation GMmainVC

- (void)viewDidLoad
{
    
    [super viewDidLoad];

    [self setupNavItems ];
    [self setTabView    ];
    [self setTabHeadView];
    [self senderRequest ];
}

- (void)setupNavItems
{
    self.dataArr = [NSMutableArray array];
    self.cateArr = [NSMutableArray array];
    
    [self setNavLeftItemTitle:nil andImage:[UIImage imageNamed:@"rightNav"]];
    [self setNavRightItemTitle:nil andImage:[UIImage imageNamed:@"rightNav"]];
    
    UIImageView * titleView =  [[UIImageView alloc]initWithFrame:CGRectMake(0, -3, 230, 30)];
    
    titleView.image =[UIImage imageNamed:@"search"];

    self.navigationItem.titleView = titleView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.oldOffset>(0)){
    if (scrollView.contentOffset.y > _oldOffset) {
        //如果当前位移大于缓存位移，说明scrollView向上滑动
        self.tabBarController.tabBar.hidden =YES;
        self.navigationController.navigationBar.hidden =YES;
    }else{
        self.tabBarController.tabBar.hidden =NO;
        self.navigationController.navigationBar.hidden =NO;
    }
    
}
    _oldOffset = scrollView.contentOffset.y;//将当前位移变成缓存位移
    

    
}
- (void)setTabView{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];

    [self.view addSubview:self.tableView];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
    [self.tableView registerClass:[GMhomeGameCell class] forCellReuseIdentifier:NSStringFromClass([GMhomeGameCell class])];
    [self.tableView registerClass:[GMhomeNewGameCell class] forCellReuseIdentifier:NSStringFromClass([GMhomeNewGameCell class])];
    self.tableView.sd_layout.spaceToSuperView(UIEdgeInsetsMake(0, 0, 0, 0));
}




- (void)setTabHeadView{
    UIView *header = [UIView new];
    
    header.width = [UIScreen mainScreen].bounds.size.width;
    
    
    self.advView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    [header addSubview:self.advView];
    self.advView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    
    UICollectionViewFlowLayout * flowLayout = [[UICollectionViewFlowLayout alloc]init];
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal  ];
    self.cateCollectView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:flowLayout];
    self.cateCollectView.delegate   = self;
    self.cateCollectView.dataSource = self;
    
    self.cateCollectView.showsHorizontalScrollIndicator=NO;
    [self.cateCollectView registerClass:[GMhomeCateCollectCell class] forCellWithReuseIdentifier:NSStringFromClass([GMhomeCateCollectCell class])];
    [header addSubview:self.cateCollectView];
    self.cateCollectView.backgroundColor = KWhiteColor;
    
    UIImageView * imgView = [[UIImageView alloc]init];
    imgView.backgroundColor = KGray2Color;
    [header addSubview:imgView];
    
    UILabel * tactic = [self adLableTitle:@"攻略"];
    [header addSubview:tactic];
    
    UILabel * new = [self adLableTitle:@"新闻"];
    [header addSubview:new];
  
    
    self.advView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    _adTacticView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:  self placeholderImage:nil];
    [header addSubview:self.adTacticView];
    _adTacticView.scrollDirection     = UICollectionViewScrollDirectionVertical;
    _adTacticView.onlyDisplayText     = YES;
    _adTacticView.titleLabelBackgroundColor = KWhiteColor;
    _adTacticView.titleLabelTextColor = KGray2Color;
    _adTacticView.titleLabelHeight    = 30;
    [_adTacticView disableScrollGesture];
    
    
    _adNewsView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:  self placeholderImage:nil];
    [header addSubview:self.adNewsView];
    _adNewsView.scrollDirection      = UICollectionViewScrollDirectionVertical;
    _adNewsView.onlyDisplayText      = YES;
    _adNewsView.titleLabelBackgroundColor = KWhiteColor;
    _adNewsView.titleLabelTextColor = KGray2Color;
    _adNewsView.titleLabelHeight     = 30;
    [_adNewsView disableScrollGesture];
    
    
   
    self.advView.sd_layout
    .leftSpaceToView(header, 0)
    .topSpaceToView(header, 0)
    .rightSpaceToView(header, 0)
    .heightIs(Iphone6ScaleHeight*200);
    
    self.cateCollectView.sd_layout
    .topSpaceToView(self.advView , 0)
    .leftSpaceToView(header, 0)
    .rightSpaceToView(header, 0)
    .heightIs(Iphone6ScaleHeight * 100);
    
    imgView.sd_layout
    .topSpaceToView(self.cateCollectView, 5)
    .leftSpaceToView(header, 10)
    .bottomSpaceToView(header, 10)
    .widthIs(80);
    
    tactic.sd_layout
    .topSpaceToView(self.cateCollectView, 5)
    .leftSpaceToView(imgView, 10)
    .heightIs(15);
    [tactic setSingleLineAutoResizeWithMaxWidth:80];
    new.sd_layout
    .topSpaceToView(tactic, 10)
    .leftSpaceToView(imgView, 10)
    .heightIs(15);
    [new setSingleLineAutoResizeWithMaxWidth:80];
    
    self.adTacticView.sd_layout
    .leftSpaceToView(new, 0)
    .centerYEqualToView(tactic)
    .heightIs(25)
    .rightSpaceToView(header, 0);
    self.adNewsView.sd_layout
    .leftSpaceToView(new, 0)
    .centerYEqualToView(new)
    .heightIs(25)
    .rightSpaceToView(header, 0);
    
    [header setupAutoHeightWithBottomView:new bottomMargin:10];
    [header layoutSubviews];
    self.tableView.tableHeaderView = header;
}
-(UILabel * )adLableTitle:(NSString *)title{
    UILabel * tactic = [[UILabel alloc]init];
    tactic.text = [NSString stringWithFormat: @" %@ ",title];
    tactic.textColor = [UIColor redColor];
    tactic.font =SYSTEMFONT(12);
    tactic.layer.borderColor = KRedColor.CGColor;
    tactic.layer.borderWidth =1;

    tactic .sd_cornerRadius =@4;
    return tactic;
}
- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return self.dataArr.count;
}
#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"section====%ld",section);
    GMhomeBlockModel * model =self.dataArr[section];
    if([model.type isEqualToString:@"topic_recommend"]){
        
        return 1;
    
    }else if ([model.type isEqualToString:@"today_recommend"]){
    
     
        return 1 ;
    
    }else if ([model.type isEqualToString:@"game"]){
   
        NSArray * arr =model.data;
    
        return arr.count;
    
    }else if ([model.type isEqualToString:@"new_game"]){
    
        return 1;
    
    }else if ([model.type isEqualToString:@"news_recommend"]){
    //        self.titleLab.autoHeight=0;
    //        self.contentLab.autoHeight=0;
    //        [self.collecView reloadData];
    }
    
    return 0 ;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GMhomeBlockModel * model =self.dataArr[indexPath.section];
    
    if ([model.type isEqualToString:@"game"]){
        GMhomeGameCell   * cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GMhomeGameCell class])];
        
        NSArray * arr = model.data;
        gameModel * model = [gameModel modelWithJSON:arr[indexPath.row]];
        cell.gamemodel = model;
          return  cell;
    }else if ([model.type isEqualToString:@"new_game"]){
        GMhomeNewGameCell * cell = nil;
        cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GMhomeNewGameCell class])];
        
        cell.gameNewmodel = model ;
        return  cell;
    }else{
        
        static NSString * identifer = @"identifer";
        GMhomeExampleCell * cell =[tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GMhomeExampleCell class])];
        if(cell==nil){
            cell = [[GMhomeExampleCell   alloc]initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:identifer ];
            
        }
        
    if([model.type isEqualToString:@"topic_recommend"]){
        cell.model =self.dataArr[indexPath.section];
          return  cell;
    }else if ([model.type isEqualToString:@"today_recommend"]){
         cell.model =self.dataArr[indexPath.section];
       
          return  cell;
    }else if ([model.type isEqualToString:@"news_recommend"]){
        //        self.titleLab.autoHeight=0;
        //        self.contentLab.autoHeight=0;
        //        [self.collecView reloadData];
    }
    }
    UITableViewCell * cell =nil;
    return  cell;
        
  
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // >>>>>>>>>>>>>>>>>>>>> * cell自适应步骤2 * >>>>>>>>>>>>>>>>>>>>>>>>
    /* model 为模型实例， keyPath 为 model 的属性名，通过 kvc 统一赋值接口 */
    GMhomeBlockModel * model =self.dataArr[indexPath.section];
    if([model.type isEqualToString:@"topic_recommend"]){
    return [self.tableView cellHeightForIndexPath:indexPath model:self.dataArr[indexPath.section]  keyPath:@"model" cellClass:[GMhomeExampleCell class] contentViewWidth:[self cellContentViewWith]];
    }else if ([model.type isEqualToString:@"today_recommend"]){
       
        return [self.tableView cellHeightForIndexPath:indexPath model:self.dataArr[indexPath.section]  keyPath:@"model" cellClass:[GMhomeExampleCell class] contentViewWidth:[self cellContentViewWith]];
        
        
    }else if ([model.type isEqualToString:@"game"]){
        NSArray * arr = model.data;
        gameModel * model = [gameModel modelWithJSON:arr[indexPath.row]];
       return [self.tableView cellHeightForIndexPath:indexPath model:model keyPath:@"gamemodel" cellClass:[GMhomeGameCell class] contentViewWidth:[self cellContentViewWith]];
    }else if ([model.type isEqualToString:@"new_game"]){
       
       
        return [self.tableView cellHeightForIndexPath:indexPath model: self.dataArr[indexPath.section]  keyPath:@"gameNewmodel" cellClass:[GMhomeNewGameCell class] contentViewWidth:[self cellContentViewWith]];
        
    }else if ([model.type isEqualToString:@"news_recommend"]){
        //        self.titleLab.autoHeight=0;
        //        self.contentLab.autoHeight=0;
        //        [self.collecView reloadData];
    }
    return [self.tableView cellHeightForIndexPath:indexPath model:self.dataArr[indexPath.section]  keyPath:@"model" cellClass:[GMhomeExampleCell class] contentViewWidth:[self cellContentViewWith]];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];// 取消选中
    NSArray * weathers = @[@"晴", @"多云", @"小雨", @"大雨", @"雪", @""];
     NSString *weather = weathers[arc4random() % weathers.count];
     if(!kiOSBefore){
        [self setAppIconWithName:weather];
        
     }
}
- (void)setAppIconWithName:(NSString *)iconName {
    if (![[UIApplication sharedApplication] supportsAlternateIcons]) {
        return;
    }
    
    if ([iconName isEqualToString:@""]) {
        iconName = nil;
    }
    [[UIApplication sharedApplication] setAlternateIconName:iconName completionHandler:^(NSError * _Nullable error) {
        if (error) {
            NSLog(@"更换app图标发生错误了 ： %@",error);
        }
    }];
}




- (void)senderRequest{
    kWeakSelf(self);
   
    [GMHomeRequest GMHomeRequestSuccess:^(GMhomeModel *data) {
    
        NSMutableArray * bannerArr = [NSMutableArray array];
        NSMutableArray * bannerTitle = [NSMutableArray array];
        NSMutableArray * newArr = [NSMutableArray array];
        NSMutableArray * newTactic = [NSMutableArray array];
        for (GMhomeBannerModel   * model in data.banner) {
            [bannerArr  addObject:model.image];
            [bannerTitle addObject:model.title];
        }
        for(GMhomeRecommendModel  * model  in data.hot_recommend){
            if([model.cate_name isEqualToString:@"新闻"]){
                [newArr addObject: model.title];
                
            }else{
                [newTactic addObject: model.title];
            }
        }
        [weakself.dataArr addObjectsFromArray:data.block];
        [weakself.cateArr addObjectsFromArray:data.block];
        dispatch_async(dispatch_get_main_queue(), ^{
 
            weakself.advView.titlesGroup  = [bannerTitle copy];
            weakself.advView.imageURLStringsGroup = [bannerArr copy];
            weakself.adTacticView.titlesGroup = [newTactic copy];
            weakself.adNewsView.titlesGroup   = [newArr copy];
            [weakself.cateCollectView reloadData];
            [weakself.tableView reloadData];
        });
     
        
    } failure:^(NSError *error) {
        
    }];
}


- (int)navBarBottom
{
    if ([WRNavigationBar isIphoneX]) {
        return 88;
    } else {
        return 64;
    }
}

//设置分区
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView{
    
    return 1;
}

//每个分区上的元素个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.cateArr.count;
}

//设置元素内容
- (UICollectionViewCell*)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    GMhomeCateCollectCell * cell = nil;
    cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([GMhomeCateCollectCell class]) forIndexPath:indexPath];
    cell.model = self.cateArr[indexPath.row];
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
    return 0;
}
//设置元素的的大小框
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{  //top, left, bottom, right;
    UIEdgeInsets top = {0,0,0,0};
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
    return CGSizeMake(Iphone6ScaleHeight*100,Iphone6ScaleHeight*100);
}

//点击元素触发事件
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
   
    
}



@end
