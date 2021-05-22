//
//  HomeViewController.m
//  wyw
//
//  Created by com.chetuba on 16/3/21.
//  Copyright © 2016年 XIAO. All rights reserved.
//

#import "HomeViewController.h"
#import "HomeBViewController.h"

@interface HomeViewController ()

/**
 *  连接
 */
@property (nonatomic, strong) NSMutableArray* arrayUrl;
/**
 *  名称
 */
@property (nonatomic, strong) NSMutableArray* arrayName;

@end

@implementation HomeViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.arrayName = [[NSMutableArray alloc] initWithObjects:@"所有", @"大胸妹", @"小翘臀", @"黑丝袜", @"美腿控", @"有颜值", @"大杂烩", nil];

    self.arrayUrl = [[NSMutableArray alloc] initWithObjects:
                                                @"http://www.dbmeinv.com/dbgroup/show.htm",
                                            @"http://www.dbmeinv.com/dbgroup/show.htm?cid=2",
                                            @"http://www.dbmeinv.com/dbgroup/show.htm?cid=6",
                                            @"http://www.dbmeinv.com/dbgroup/show.htm?cid=7",
                                            @"http://www.dbmeinv.com/dbgroup/show.htm?cid=3",
                                            @"http://www.dbmeinv.com/dbgroup/show.htm?cid=4",
                                            @"http://www.dbmeinv.com/dbgroup/show.htm?cid=5", nil];

    [self setUpContentViewFrame:^(UIView* contentView) {

        contentView.frame = CGRectMake(0, NavHigh, ScreenWidth, ScreenHigh - BarHigh - NavHigh);

    }];

    [self setUpTitleEffect:^(UIColor *__autoreleasing *titleScrollViewColor, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor, UIFont *__autoreleasing *titleFont, CGFloat *titleHeight, CGFloat *titleWidth) {
        *norColor = [UIColor lightGrayColor];
        *selColor = [UIColor blackColor];
        *titleWidth = [UIScreen mainScreen].bounds.size.width / 4;
    }];
    
    // 标题渐变
    // *推荐方式(设置标题渐变)
    [self setUpTitleGradient:^(YZTitleColorGradientStyle *titleColorGradientStyle, UIColor *__autoreleasing *norColor, UIColor *__autoreleasing *selColor) {
        
    }];
    
    [self setUpUnderLineEffect:^(BOOL *isUnderLineDelayScroll, CGFloat *underLineH, UIColor *__autoreleasing *underLineColor,BOOL *isUnderLineEqualTitleWidth) {
        //        *isUnderLineDelayScroll = YES;
        *isUnderLineEqualTitleWidth = YES;
    }];

    /**
     *  及时的 就不要刷新   用延迟就刷新
     */
    // 添加所有子控制器
    [self setUpAllViewController];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 添加所有子控制器
- (void)setUpAllViewController
{

    for (int i = 0; i < [self.arrayName count]; i++) {

        // 段子
        HomeBViewController *wordVc = [self storyboardWithName:@"Main" Identifier:@"HomeB"];
        wordVc.title = self.arrayName[i];
        wordVc.url = self.arrayUrl[i];
        [self addChildViewController:wordVc];
        //[self.controllers addObject:wordVc];
    }
}
- (id)storyboardWithName:(NSString*)sbname Identifier:(NSString*)identifier
{
    UIStoryboard* storyboard = [UIStoryboard storyboardWithName:sbname bundle:nil];

    return [storyboard instantiateViewControllerWithIdentifier:identifier];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
