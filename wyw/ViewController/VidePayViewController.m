//
//  VidePayViewController.m
//  wyw
//
//  Created by Xiaoshiheng_pro on 2016/11/26.
//  Copyright © 2016年 XIAO. All rights reserved.
//

#import "VidePayViewController.h"
#import "KrVideoPlayerController.h"
#import "TFHpple.h"
#import "TFHppleElement.h"

@interface VidePayViewController ()

@property (nonatomic, strong) KrVideoPlayerController  *videoController;

@end

@implementation VidePayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
//    [self playVideo];

    [self huoquDate:self.url];
    
    
    
}

- (void)viewDidDisappear:(BOOL)animated{
    
   

    [super viewDidDisappear:animated];
    
}

- (void)viewWillDisappear:(BOOL)animated{
    
 

    [super viewWillDisappear:animated];
    
}

- (void)dealloc{
    
    
    [self.videoController dismiss];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)huoquDate:(NSString *)url{
    
    NSURLRequest* req = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse* response, NSData* data, NSError* error) {
        
        TFHpple* doc = [[TFHpple alloc] initWithHTMLData:data encoding:@"utf-8"];

        TFHppleElement* node1 = [doc peekAtSearchWithXPathQuery:@"//h1[@class='media-heading']"];
        
        self.navigationItem.title = node1.content;
//        NSLog(@"%@",node1.content);
        
        NSArray* elements = [doc searchWithXPathQuery:@"//a[@target='_blank']"];
        TFHppleElement* node = elements[0];
        
        NSString* string= [node objectForKey:@"href"];
        NSArray *array1 = [string componentsSeparatedByString:@"show/"]; //从字符A中分隔成2个元素的数组
        NSArray *array2 = [array1[1] componentsSeparatedByString:@".htm"];
        
        NSString *urlstring = [NSString stringWithFormat:@"http://gslb.miaopai.com/stream/%@.mp4",array2[0]];
        NSLog(@"urlstring:%@",urlstring);
        NSURL *url = [NSURL URLWithString:urlstring];
        [self addVideoPlayerWithURL:url];
        
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)playVideo{
    
    NSURL *url = [NSURL URLWithString:@"http://s8.pdim.gs/static/7cfb8242b3ca4ef6.swf&amp"];
    //    NSURL *url = [NSURL URLWithString:@"http://krtv.qiniudn.com/150522nextapp"];
    [self addVideoPlayerWithURL:url];
}

- (void)addVideoPlayerWithURL:(NSURL *)url{
    if (!self.videoController) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        self.videoController = [[KrVideoPlayerController alloc] initWithFrame:CGRectMake(0, 64, width, width*(9.0/16.0))];
        
        __weak typeof(self)weakSelf = self;
        
        [self.videoController setDimissCompleteBlock:^{
            weakSelf.videoController = nil;
        }];
        [self.videoController setWillBackOrientationPortrait:^{
            [weakSelf toolbarHidden:NO];
        }];
        [self.videoController setWillChangeToFullscreenMode:^{
            [weakSelf toolbarHidden:YES];
        }];
        [self.view addSubview:self.videoController.view];
        
    }
    self.videoController.contentURL = url;
    
}
//隐藏navigation  电池栏
- (void)toolbarHidden:(BOOL)Bool{
    
    self.navigationController.navigationBar.hidden = Bool;
    [[UIApplication sharedApplication] setStatusBarHidden:Bool withAnimation:UIStatusBarAnimationFade];
}

@end
