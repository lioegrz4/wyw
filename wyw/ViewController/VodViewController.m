//
//  VodViewController.m
//  wyw
//
//  Created by Xiaoshiheng_pro on 2016/11/17.
//  Copyright © 2016年 XIAO. All rights reserved.
//

#import "VodViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"
#import "HomeCollectionViewCell.h"
#import "TFHpple.h"
#import "TFHppleElement.h"
#import "VidePayViewController.h"

#import "XBImageSize.h"
#import "ItemModel.h"

@interface VodViewController ()<UICollectionViewDataSource, UICollectionViewDelegate, CHTCollectionViewDelegateWaterfallLayout>

/**
 *  连接
 */
@property (nonatomic, strong) NSString* url;

@property (nonatomic,assign) BOOL isImages;

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

@implementation VodViewController

static NSString * const reuseIdentifier = @"HomeCell";

- (void)viewDidLoad {
    [super viewDidLoad];

    self.collectionView.delegate =self;
    self.collectionView.dataSource = self;
    
    self.title = @"视频精选";
    
    self.url = @"http://www.dbmeinv.com/dbgroup/videos.htm";
    self.isImages = NO;
    
    [self addRightBarButton:@"切换"];
    
    CHTCollectionViewWaterfallLayout* layout = [[CHTCollectionViewWaterfallLayout alloc] init];
    
    layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    //    layout.headerHeight = 15;
    //    layout.footerHeight = 10;
    layout.minimumColumnSpacing = 4;
    layout.minimumInteritemSpacing = 4;
    
    self.collectionView.collectionViewLayout = layout;
    
    self.headerLoad = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(upDateS)];
    
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    //self.headerLoad.autoChangeAlpha = YES;
    // 设置header
    self.collectionView.header = self.headerLoad;
    
    self.footerLoad = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(upDateX)];
    // 设置自动切换透明度(在导航栏下面自动隐藏)
    //self.footerLoad.autoChangeAlpha = YES;
    // 设置header
    self.collectionView.footer = self.footerLoad;
    
    self.photos = [[NSMutableArray alloc] initWithCapacity:0];
    self.arrayItemModel = [[NSMutableArray alloc] initWithCapacity:0];
    
    [self upDateS];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)clickRightBarButton:(UIButton *)sender{
    
    
    if (self.isImages) {
        
        self.isImages = NO;
        self.title = @"视频精选";
        
        self.url = @"http://www.dbmeinv.com/dbgroup/videos.htm";
        
        [self upDateS];
        
    }else{
        
        self.isImages = YES;
        
        self.title = @"图片精选";
    
        self.url = @"http://www.dbmeinv.com/dbgroup/rank.htm";
    
    
        [self upDateS];
    }
    
    
}
- (void)upDateS
{
    self.pageNumber = 1;
    [self dateS:self.url];
}
- (void)upDateX
{
    
    //    pager_offset=2
    //    &pager_offset=2
    //http://www.dbmeinv.com/dbgroup/videos.htm?pager_offset=2
    
//    http://www.dbmeinv.com/dbgroup/rank.htm?pager_offset=2
    
    self.pageNumber++;

    NSString* url = [NSString stringWithFormat:@"%@?%@%zi", self.url, @"?pager_offset=", self.pageNumber];

//    NSLog(@"%@", url);
    [self dateX:url];
}

- (void)dateS:(NSString*)url
{
    
    
    if (self.isImages) {
        
        NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
            
            TFHpple* doc = [[TFHpple alloc] initWithHTMLData:data];
            
            [self.arrayItemModel removeAllObjects];
            
            
            NSArray* elements = [doc searchWithXPathQuery:@"//img[@class='height_min']"];
            
            for (TFHppleElement* node in elements) {
                
                ItemModel *model =[[ItemModel alloc]init];
                model.img = [node objectForKey:@"src"];
                model.text =  [node objectForKey:@"title"];
                
                //图片的宽高 比例 一定要后台提供 否则没有办法进行处理
                CGSize size = [XBImageSize downloadImageSizeWithURL:[node objectForKey:@"src"]];
                CGFloat width = (ScreenWidth - 4) / 2;
                
                if (size.width == 0 || size.height == 0) {
                    model.w = width;
                    model.h =width;
                    
                }else{
                    model.w = width;
                    model.h = (size.height / size.width) * width;
                    
                    
                }
                
                [self.arrayItemModel addObject:model];
                
            }
            
            [self.headerLoad endRefreshing];
            
            if ([self.arrayItemModel count] > 0) {
                
                [self.collectionView reloadData];
            }
            
        }];
    
    }else{
        NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
            
            TFHpple* doc = [[TFHpple alloc] initWithHTMLData:data encoding:@"utf-8"];
            
            [self.arrayItemModel removeAllObjects];
            
            
            NSArray* elements = [doc searchWithXPathQuery:@"//a[@target='_videos_detail']"];
            NSArray* elementsTitle = [doc searchWithXPathQuery:@"//span[@class='fl p5 meta']"];
            
            for (int i = 0; i<[elements count]; i++) {
                
                ItemModel *model =[[ItemModel alloc]init];
                
                TFHppleElement* node = elements[i];
                model.videoUrl = [node objectForKey:@"href"];
                
                TFHppleElement *nodeValue= [node firstChildWithTagName:@"img"];
                model.img = [nodeValue objectForKey:@"src"];
                
                TFHppleElement* nodeTitle = elementsTitle[i];
                model.text =  nodeTitle.text;
                
                //图片的宽高 比例 一定要后台提供 否则没有办法进行处理
                CGSize size = [XBImageSize downloadImageSizeWithURL:model.img];
                CGFloat width = (ScreenWidth - 4) / 2;
                
                if (size.width == 0 || size.height == 0) {
                    model.w = width;
                    model.h =width;
                    
                }else{
                    model.w = width;
                    model.h = (size.height / size.width) * width;
                    
                    
                }
                
                [self.arrayItemModel addObject:model];
                
            }
            
            [self.headerLoad endRefreshing];
            
            if ([self.arrayItemModel count] > 0) {
                
                [self.collectionView reloadData];
            }
            
        }];
    }
    
}

- (void)dateX:(NSString*)url
{
    
    if (self.isImages) {
        
        NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
            
            TFHpple* doc = [[TFHpple alloc] initWithHTMLData:data];
            
            NSMutableArray* arrayItemModel = [[NSMutableArray alloc] initWithCapacity:0];
            
            
            NSArray* elements = [doc searchWithXPathQuery:@"//img[@class='height_min']"];
            
            for (TFHppleElement* node in elements) {
                
                ItemModel *model =[[ItemModel alloc]init];
                model.img = [node objectForKey:@"src"];
                model.text =  [node objectForKey:@"title"];
                
                //图片的宽高 比例 一定要后台提供 否则没有办法进行处理
                CGSize size = [XBImageSize downloadImageSizeWithURL:[node objectForKey:@"src"]];
                CGFloat width = (ScreenWidth - 4) / 2;
                
                if (size.width == 0 || size.height == 0) {
                    model.w = width;
                    model.h =width;
                    
                }else{
                    model.w = width;
                    model.h = (size.height / size.width) * width;
                }
                [arrayItemModel addObject:model];
                
                
            }
            
            if ([arrayItemModel count] > 0) {
                
                [self.footerLoad endRefreshing];
                
                [self.arrayItemModel addObjectsFromArray:arrayItemModel];
                
                
                [self.collectionView reloadData];
            }
            else {
                
                self.footerLoad.arrowView.image = nil;
                [self.footerLoad noticeNoMoreData];
            }
            
        }];
        
    }else{
        NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
        [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
            
            TFHpple* doc = [[TFHpple alloc] initWithHTMLData:data encoding:@"utf-8"];
            
            NSMutableArray* arrayItemModel = [[NSMutableArray alloc] initWithCapacity:0];
            
            NSArray* elements = [doc searchWithXPathQuery:@"//a[@target='_videos_detail']"];
            NSArray* elementsTitle = [doc searchWithXPathQuery:@"//span[@class='fl p5 meta']"];
            
            for (int i = 0; i<[elements count]; i++) {
                
                ItemModel *model =[[ItemModel alloc]init];
                
                TFHppleElement* node = elements[i];
                model.videoUrl = [node objectForKey:@"href"];
                
                TFHppleElement *nodeValue= [node firstChildWithTagName:@"img"];
                model.img = [nodeValue objectForKey:@"src"];
                
                TFHppleElement* nodeTitle = elementsTitle[i];
                model.text =  nodeTitle.text;
                
                //图片的宽高 比例 一定要后台提供 否则没有办法进行处理
                CGSize size = [XBImageSize downloadImageSizeWithURL:model.img];
                CGFloat width = (ScreenWidth - 4) / 2;
                
                if (size.width == 0 || size.height == 0) {
                    model.w = width;
                    model.h =width;
                    
                }else{
                    model.w = width;
                    model.h = (size.height / size.width) * width;
                    
                    
                }
                
                [arrayItemModel addObject:model];
                
            }
            
            if ([arrayItemModel count] > 0) {
                
                [self.footerLoad endRefreshing];
                
                [self.arrayItemModel addObjectsFromArray:arrayItemModel];
                
                [self.collectionView reloadData];
            }
            else {
                
                self.footerLoad.arrowView.image = nil;
                [self.footerLoad noticeNoMoreData];
            }
            
        }];
    }

}
#pragma mark <UICollectionViewDataSource>

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView*)collectionView
{
    
    return 1;
}

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section
{
    
    return [self.arrayItemModel count];
}

- (UICollectionViewCell*)collectionView:(UICollectionView*)collectionView cellForItemAtIndexPath:(NSIndexPath*)indexPath
{
    
    HomeCollectionViewCell* cell = [collectionView dequeueReusableCellWithReuseIdentifier:reuseIdentifier forIndexPath:indexPath];
    ItemModel *model = self.arrayItemModel[indexPath.row];
    [cell.iconImage sd_setImageWithURL:[NSURL URLWithString:model.img]];
    
    
    NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"@／：；（）¥「」＂、[]{}#%-*+=_\\|~＜＞$€^•'@#$%^&*()_+'\""];
    cell.textLabel.text = [[model.text stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] stringByTrimmingCharactersInSet:set];

    
//    NSLog(@"%@",model.text);
    
    return cell;
}

#pragma mark <UICollectionViewDelegate>
- (void)collectionView:(UICollectionView*)collectionView didSelectItemAtIndexPath:(NSIndexPath*)indexPath
{

    if (self.isImages) {
        
        [self.photos removeAllObjects];
        
        NSInteger row = 0;
        MJPhotoBrowser* photoBrowser = [[MJPhotoBrowser alloc] init];
        for ( ItemModel *model in self.arrayItemModel) {
            
            MJPhoto* photo = [[MJPhoto alloc] init];
            photo.url = [NSURL URLWithString:model.img];
            //用这样的
            photo.srcImageView  = ((HomeCollectionViewCell*)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0]]).iconImage;
            row++;
            [self.photos addObject:photo];
            
            //NSLog(@"%@,----%@", photo.srcImageView, photo.url);
        }
        photoBrowser.photos = self.photos;
        photoBrowser.currentPhotoIndex = indexPath.row;
        [photoBrowser show];
        
    }else{
        
        ItemModel *model = self.arrayItemModel[indexPath.row];
        VidePayViewController *VC = [[VidePayViewController alloc]init];
        VC.url = model.videoUrl;
        [self.navigationController pushViewController:VC animated:YES];
    }

   
    
}

#pragma mark <UICollectionViewDelegateFlowLayout>

- (CGSize)collectionView:(UICollectionView*)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath*)indexPath
{
    
    ItemModel *model = self.arrayItemModel[indexPath.row];
    return CGSizeMake(model.w,model.h + 22);
}





@end
