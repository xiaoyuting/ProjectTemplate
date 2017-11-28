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
#import "WRImageHelper.h"
#import "GMHomeRequest.h"
#import <UIView+SDAutoLayout.h>
#import "UIImageView+WebCache.h"
#import "UIButton+WebCache.h"


#import "GMhomeBannerModel.h"
#import "GMhomeRecommendModel.h"

#define NAVBAR_COLORCHANGE_POINT (-IMAGE_HEIGHT + NAV_HEIGHT)
#define NAV_HEIGHT 64
#define IMAGE_HEIGHT 240
#define SCROLL_DOWN_LIMIT 70

#define LIMIT_OFFSET_Y -(IMAGE_HEIGHT + SCROLL_DOWN_LIMIT)
@interface GMmainVC ()<UITableViewDelegate, UITableViewDataSource,  SDCycleScrollViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) SDCycleScrollView *advView;
@property (nonatomic, strong) SDCycleScrollView *adtView;
@property (nonatomic, strong) UIButton *searchButton;
@property (nonatomic, assign) CGFloat  oldOffset;
@property (nonatomic, strong) NSMutableArray  * dataArr;

@end

@implementation GMmainVC

- (void)viewDidLoad
{
    

    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
    [self setupNavItems];
    self.tableView.contentInset = UIEdgeInsetsMake(IMAGE_HEIGHT - [self navBarBottom], 0, 0, 0);
    //[self.tableView addSubview:self.advView];
    [self setScrollerView];
    [self.view addSubview:self.tableView];
    
    [self wr_setNavBarBarTintColor:[UIColor redColor]];
    [self wr_setNavBarBackgroundAlpha:0];
        [self senderRequest];
}

- (void)setupNavItems
{
    self.dataArr = [NSMutableArray array];      
    [self setNavLeftItemTitle:nil andImage:[UIImage imageNamed:@"rightNav"]];
    [self setNavRightItemTitle:nil andImage:[UIImage imageNamed:@"rightNav"]];
    self.searchButton = [[UIButton alloc]initWithFrame:CGRectMake(0, -3, 230, 30)];
    [self.searchButton setTitle:@"搜索职位/公司/商区" forState:UIControlStateNormal];
    self.searchButton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    [self.searchButton setBackgroundImage:[UIImage imageNamed:@"search"] forState:UIControlStateNormal];
    [self.searchButton addTarget:self action:@selector(onClickSearchBtn) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = self.searchButton;
}
-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    
    NSLog(@"beigin==%f",scrollView.contentOffset.y);
    
    
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate{
    NSLog(@"%f",scrollView.contentOffset.y);
   

}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if(self.oldOffset>(-200)){
    if (scrollView.contentOffset.y > _oldOffset) {
        //如果当前位移大于缓存位移，说明scrollView向上滑动
        self.tabBarController.tabBar.hidden =YES;
    }else{
        self.tabBarController.tabBar.hidden =NO;
    }
    
}
    _oldOffset = scrollView.contentOffset.y;//将当前位移变成缓存位移
    

     NSLog(@"timer===%f",scrollView.contentOffset.y);
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY < -IMAGE_HEIGHT) {
     
        [self updateNavBarButtonItemsAlphaAnimated:.0f];
    } else {

        [self updateNavBarButtonItemsAlphaAnimated:1.0f];
    }
    
    if (offsetY > NAVBAR_COLORCHANGE_POINT)
    {
        CGFloat alpha = (offsetY - NAVBAR_COLORCHANGE_POINT) / NAV_HEIGHT;
        [self wr_setNavBarBackgroundAlpha:alpha];
        [self updateSearchBarColor:alpha];
     
    }
    else
    {
      
        [self wr_setNavBarBackgroundAlpha:0];
        [self.searchButton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    }
    
    //限制下拉的距离
    if(offsetY < LIMIT_OFFSET_Y) {
        [scrollView setContentOffset:CGPointMake(0, LIMIT_OFFSET_Y)];
    }
}

- (void)updateNavBarButtonItemsAlphaAnimated:(CGFloat)alpha
{
    [UIView animateWithDuration:0.2 animations:^{
        [self.navigationController.navigationBar wr_setBarButtonItemsAlpha:alpha hasSystemBackIndicator:NO];
    }];
}

- (void)updateSearchBarColor:(CGFloat)alpha
{
    UIColor *color = [[UIColor colorWithRed:29/255.0 green:160/255.0 blue:126/255.0 alpha:1.0] colorWithAlphaComponent:alpha];
    UIImage *image = [UIImage imageNamed:@"search"];
    image = [image wr_updateImageWithTintColor:color alpha:alpha];
    [self.searchButton setBackgroundImage:image forState:UIControlStateNormal];
    [self.searchButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
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
#pragma mark - getter / setter
- (UITableView *)tableView
{
    if (_tableView == nil) {
        CGRect frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        _tableView = [[UITableView alloc] initWithFrame:frame
                                                  style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

- (UIImage *)imageWithImageSimple:(UIImage *)image scaledToSize:(CGSize)newSize
{
    UIGraphicsBeginImageContext(CGSizeMake(newSize.width*2, newSize.height*2));
    [image drawInRect:CGRectMake (0, 0, newSize.width*2, newSize.height*2)];
    UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return newImage;
}
-(void)setScrollerView{

   self.advView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -IMAGE_HEIGHT, kScreenWidth, IMAGE_HEIGHT-40) delegate:self placeholderImage:[UIImage imageNamed:@"placeholder"]];
    
    self.advView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    //cycleScrollView2.titlesGroup = titles;
    self.advView.currentPageDotColor = [UIColor whiteColor]; // 自定义分页控件小圆标颜色
    [self.tableView addSubview:self.advView];
    _adtView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, -40, kScreenWidth, 40) delegate:self placeholderImage:nil];
    _adtView.scrollDirection = UICollectionViewScrollDirectionVertical;
    _adtView.onlyDisplayText = YES;
    
    NSMutableArray *titlesArray = [NSMutableArray new];
    [titlesArray addObject:@"纯文字上下滚动轮播"];
    [titlesArray addObject:@"纯文字上下滚动轮播 -- demo轮播图4"];
    // [titlesArray addObjectsFromArray:titles];
    _adtView.titlesGroup = [titlesArray copy];
    [_adtView disableScrollGesture];
    [self.tableView addSubview:self.adtView];
    
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
        dispatch_async(dispatch_get_main_queue(), ^{
            [weakself.dataArr addObjectsFromArray:data.hot_recommend];
            weakself.advView.titlesGroup  = [bannerTitle copy];
            weakself.advView.imageURLStringsGroup = [bannerArr copy];
            [weakself.tableView reloadData];
        });
     
        
    } failure:^(NSError *error) {
        
    }];
}
- (void)onClickSearchBtn
{}

- (int)navBarBottom
{
    if ([WRNavigationBar isIphoneX]) {
        return 88;
    } else {
        return 64;
    }
}



@end
