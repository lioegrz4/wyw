//
//  MPBViewController.m
//  wyw
//
//  Created by Xiaoshiheng_pro on 2017/2/24.
//  Copyright © 2017年 XIAO. All rights reserved.
//

#import "MPBViewController.h"
#import "MPBViewControllerTableViewCell.h"
#import "MPModel.h"

@interface MPBViewController ()<UITableViewDelegate,UITableViewDataSource>


@property (weak, nonatomic) IBOutlet UITableView *tableView;
/// 连接
@property (nonatomic, strong) NSString* url;
@property (nonatomic, strong) NSMutableArray* arrayItemModel;
/**
 *  下拉刷新
 */
@property (nonatomic, strong) MJRefreshNormalHeader* headerLoad;
/**
 *  下拉刷新
 */
@property (nonatomic, strong) MJRefreshBackNormalFooter* footerLoad;
/**
 *  页码
 */
@property (nonatomic, assign) NSInteger pageNumber;

@end

@implementation MPBViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.url = @"http://newapi.meipai.com/output/channels_topics_timeline.json";
    self.arrayItemModel = [NSMutableArray arrayWithCapacity:0];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    //  支持自适应 cell
    self.tableView.estimatedRowHeight = 260;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    
    self.headerLoad = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(upDateS)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    //self.headerLoad.autoChangeAlpha = YES;
    // 设置header
    self.tableView.header = self.headerLoad;
    
    self.footerLoad = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDateX)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    //self.footerLoad.autoChangeAlpha = YES;
    // 设置header
    self.tableView.footer = self.footerLoad;
    
    
    [self upDateS];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)upDateS
{
    self.pageNumber = 1;
//    count     可不传	int	单页返回的记录条数，默认为 20，最多 100。
//    page      可不传	int	返回结果的页码，默认为1。
//    feature	可不传	string	排序方式，new 表示最新，hot 表示最热，频道默认为最新，话题默认为最热
//    max_id	可不传	int	若取最新，需传此字段，为当前分页最后一个美拍的 ID，用于获取下一页时定位
    //    http://newapi.meipai.com/output/channels_topics_timeline.json?count=20\u0026feature=\u0026id=1\u0026max_id=\u0026page=1
    
     NSString* url = [NSString stringWithFormat:@"%@?id=%@&page=%zi&count=20", self.url,self.url_id,self.pageNumber];
    
    [self dateS:url];
}
- (void)upDateX
{
    
    self.pageNumber++;
    NSString* url = [NSString stringWithFormat:@"%@?id=%@&page=%zi&count=20", self.url,self.url_id,self.pageNumber];
    [self dateX:url];
}
- (void)dateS:(NSString*)url{
    
    NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
        
        NSArray* json = [NSJSONSerialization
                              JSONObjectWithData:data
                              options:kNilOptions
                              error:&error];
        
        [self.arrayItemModel removeAllObjects];
        [self.arrayItemModel addObjectsFromArray:json];
        
        
        [self.headerLoad endRefreshing];
        
        if ([self.arrayItemModel count] > 0) {
            
            [self.tableView reloadData];
        }
        
    }];
}
- (void)dateX:(NSString*)url
{
    
        NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
            
            NSArray* json = [NSJSONSerialization
                             JSONObjectWithData:data
                             options:kNilOptions
                             error:&error];

            
            NSMutableArray* arrayItemModel = [[NSMutableArray alloc] initWithCapacity:0];
            [arrayItemModel addObjectsFromArray:json];

            if ([arrayItemModel count] > 0) {
                
                [self.footerLoad endRefreshing];
                
                [self.arrayItemModel addObjectsFromArray:arrayItemModel];
                
                [self.tableView reloadData];
            }
            else {
                
                self.footerLoad.arrowView.image = nil;
                [self.footerLoad noticeNoMoreData];
            }
            
        }];
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return [self.arrayItemModel count];
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
     
     MPBViewControllerTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"MPBCell" forIndexPath:indexPath];
     
     
     MPModel *model = [MPModel mj_objectWithKeyValues:self.arrayItemModel[indexPath.row]];
     
     cell.title.text = model.caption;
     [cell.cover_picImageView sd_setImageWithURL:[NSURL URLWithString:model.cover_pic]];
     
 
  
 
     return cell;
 }


@end
