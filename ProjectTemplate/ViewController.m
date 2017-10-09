//
//  ViewController.m
//  ProjectTemplate
//
//  Created by 雨停 on 2017/9/28.
//  Copyright © 2017年 yuting. All rights reserved.
//

#import "ViewController.h"
#import "viewModel.h"
#import "UITapGestureRecognizer+Block.h"
#import "HomeTableViewCell.h"
#import "UIImageView+WebCache.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tab;
@property (nonatomic,assign)    int a ;
@property (nonatomic,strong)   NSMutableArray * dataArr;
@end

@implementation ViewController

- (void)viewDidLoad {
    self.dataArr = [NSMutableArray array];
    self.automaticallyAdjustsScrollViewInsets =NO;
    self.a=0;
    [super viewDidLoad];
    UIImageView * img = [[UIImageView alloc]initWithFrame:CGRectMake(0, 200, 200, 200)];
    img.userInteractionEnabled =YES;
    //img.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
    //[self.view addSubview:img];
    img.backgroundColor = [UIColor redColor];
    [img addGestureRecognizer:[UITapGestureRecognizer getureRecognizerWithActionBlock:^(id gestureRecognizer) {
             NSLog(@"viewM点击事件-------");
    }]];
    [self setRequest];
    [self.tab setRowHeight:100];
    // Do any additional setup after loading the view, typically from a nib.
}
/*-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    

    switch ( self.a ) {
            case 0:
                [MBProgressHUD showTipMessageInView:@"11111"];
          
            break;
            case 1:
            [MBProgressHUD showTipMessageInWindow:@"111111"];
      
            break;
            case 2:
            //[MBProgressHUD showActivityMessageInView:@"2222"];
         [MBProgressHUD showActivityMessageInView:@"33333" timer:1];
            break;
            case 3:
            //[MBProgressHUD showActivityMessageInWindow:@"222222"];
            [MBProgressHUD showActivityMessageInWindow:@"333333333" timer:1];
            break;
            case 4:
            [MBProgressHUD showSuccessMessage:@"success"];
            break;
            case 5:
            [MBProgressHUD showErrorMessage:@"error"];
            break;
            case 6:
            [MBProgressHUD showWarnMessage:@"warn"];
            break;
            case 7:
            [MBProgressHUD showInfoMessage:@"info"];
            break;
            case 8:
            [MBProgressHUD showCustomIconInView:@"nil" message:@"bire"];
            break;
            case 9:
            [MBProgressHUD showTopTipMessage:@"nihao"];
            break;
            case 10:
            
            break;
            case 11:
            
            break;


        default:
            break;
    }
   self.a++;
}*/
-(void)setSubview{
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
     return self.dataArr.count;
}
//-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
//    return self.dataArr.count;
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellIde=@"cellIde";
    HomeTableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:cellIde];
    if (!cell) {
        cell=[[HomeTableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIde];
    }
    
    NSDictionary * dic  = self.dataArr[indexPath.row];
   // [cell.imageView   ]
    NSLog(@"%@",dic[@"newsImage"]);
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:dic[@"newsImage"]]   placeholderImage:nil];
    return cell;

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setRequest{
    viewModel * model = [[viewModel alloc]init];
    kWeakSelf(self);
    [model DataWithSuccess:^(NSArray *arr) {
        [weakself.dataArr removeAllObjects];
        [weakself.dataArr addObjectsFromArray:arr];
        dispatch_async(dispatch_get_main_queue(), ^{
        [weakself.tab reloadData];
        });
    } failure:^(NSError *error) {
        
    }];
}

@end
