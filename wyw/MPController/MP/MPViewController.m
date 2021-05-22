//
//  MPViewController.m
//  wyw
//
//  Created by Xiaoshiheng_pro on 2017/2/24.
//  Copyright © 2017年 XIAO. All rights reserved.
//

#import "MPViewController.h"
#import "MPBViewController.h"

@interface MPViewController ()

/**
 *  连接
 */
@property (nonatomic, strong) NSMutableArray* arrayUrl;
/**
 *  名称
 */
@property (nonatomic, strong) NSMutableArray* arrayName;

@end

@implementation MPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
//    话题 id 或频道 id，其中频道目前支持的有：
//    
//    热门(ID:1)搞笑(ID:13)明星名人(ID:16)男神(ID:31)女神(ID:19)音乐(ID:62)舞蹈(ID:63)
//    美食(ID:59)美妆(ID:27)宝宝(ID:18)萌宠(ID:6)手工(ID:450)穿秀(ID:460)吃秀(ID:423)
//    
    self.arrayName = [[NSMutableArray alloc] initWithObjects:@"热门", @"搞笑", @"明星名人", @"男神", @"女神", @"音乐", @"舞蹈",@"美食", @"美妆", @"宝宝", @"萌宠", @"手工", @"穿秀", @"吃秀", nil];
    
    self.arrayUrl = [[NSMutableArray alloc] initWithObjects:
                     @"1",@"13",@"16",@"31",@"19",@"62",@"63",
                     @"59",@"27",@"18",@"6",@"450",@"460",@"423", nil];
    
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 添加所有子控制器
- (void)setUpAllViewController
{
    
    for (int i = 0; i < [self.arrayName count]; i++) {
    
        MPBViewController *wordVc = [self storyboardWithName:@"Main" Identifier:@"MPBViewController"];
        wordVc.title = self.arrayName[i];
        wordVc.url_id = self.arrayUrl[i];
        [self addChildViewController:wordVc];

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
