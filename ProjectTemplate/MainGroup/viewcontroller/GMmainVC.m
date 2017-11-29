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
#import <UIView+SDAutoLayout.h>



#import "GMhomeBannerModel.h"
#import "GMhomeRecommendModel.h"

#import "GMhomeCateCollectCell.h"

@interface GMmainVC ()<UITableViewDelegate, UITableViewDataSource,  SDCycleScrollViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *advView;
@property (nonatomic, strong) SDCycleScrollView *adtView;
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
    self.tableView = [[UITableView alloc]init];
    [self.view addSubview:self.tableView];
    self.tableView.delegate =self;
    self.tableView.dataSource = self;
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
    
    self.advView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    _adtView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:  self placeholderImage:nil];
    [header addSubview:self.adtView];
    _adtView.scrollDirection = UICollectionViewScrollDirectionVertical;
    _adtView.onlyDisplayText = YES;
    
    NSMutableArray *titlesArray = [NSMutableArray new];
    [titlesArray addObject:@"纯文字上下滚动轮播"];
    [titlesArray addObject:@"纯文字上下滚动轮播 -- demo轮播图4"];
    // [titlesArray addObjectsFromArray:titles];
    _adtView.titlesGroup = [titlesArray copy];
    [_adtView disableScrollGesture];
   
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
    
    self.adtView.sd_layout
    .leftSpaceToView(header, 0)
    .topSpaceToView(self.cateCollectView, 0)
    .heightIs(25)
    .rightSpaceToView(header, 0);
    [header setupAutoHeightWithBottomView:self.adtView bottomMargin:0];
    [header layoutSubviews];
    self.tableView.tableHeaderView = header;
}



#pragma mark - tableview delegate / dataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                   reuseIdentifier:nil];
    GMhomeRecommendModel * model = self.dataArr[indexPath.row];
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:model.image] placeholderImage:nil];
    cell.textLabel.text = model.title;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{    NSArray * weathers = @[@"晴", @"多云", @"小雨", @"大雨", @"雪", @""];
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
        for (GMhomeBannerModel   * model in data.banner) {
            [bannerArr  addObject:model.image];
            [bannerTitle addObject:model.title];
            
        
            
        }
        [weakself.dataArr addObjectsFromArray:data.hot_recommend];
        [weakself.cateArr addObjectsFromArray:data.block];
        dispatch_async(dispatch_get_main_queue(), ^{
 
            weakself.advView.titlesGroup  = [bannerTitle copy];
            weakself.advView.imageURLStringsGroup = [bannerArr copy];
            
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
