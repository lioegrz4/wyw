//
//  UIViewController+XBKit.m
//  lxtxAppCustomer
//
//  Created by com.chetuba on 15/7/9.
//  Copyright (c) 2015年 Lxtx. All rights reserved.
//

#import "UIViewController+XBKit.h"



@implementation UIViewController (XBKit)



//用替换方法来改变 返回 按钮的样式
+ (void)load
{
    
    static dispatch_once_t predicate;
    dispatch_once(&predicate, ^{
        
        Method originalMethod = class_getInstanceMethod(self, @selector(viewDidLoad));
        Method swizzledMethod = class_getInstanceMethod(self, @selector(XBKitviewDidLoad));
        method_exchangeImplementations(originalMethod, swizzledMethod);
    });
    
}


- (void)XBKitviewDidLoad
{
//    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
//    [backItem setBackButtonBackgroundImage:[UIImage imageNamed:@"Login"] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
//    
//    [backItem setTitle:@""];
//    
//    self.navigationItem.backBarButtonItem = backItem;
    
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] init];
    backItem.title = @"";
    self.navigationItem.backBarButtonItem = backItem;
}


#pragma ##############################################################

- (void)addRightBarButton:(NSString *)name{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:name style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBarButton:)];
    self.navigationItem.rightBarButtonItem=rightButton;
}
- (void)addRightBarButtonImage:(UIImage *)image{
    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(clickRightBarButton:)];
    self.navigationItem.rightBarButtonItem=rightButton;
}
- (void)addRightBarButtonSystemItem:(UIBarButtonSystemItem)systemItem{
    
    UIBarButtonItem *rightButton =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:systemItem target:self action:@selector(clickRightBarButton:)];
    
    
    
    
    self.navigationItem.rightBarButtonItem=rightButton;
}
/*
 *  点击事件
 */
- (void)clickRightBarButton:(UIButton *)sender{
    NSLog(@"请在对应的控制器里重写此方法,clickRightBarButton");
}

//----------------------------------------------------------------------------------------
- (void)addLeftBarButton:(NSString *)name{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:name style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftBarButton:)];
    self.navigationItem.leftBarButtonItem=leftBarButton;
}

- (void)addLeftBarButtonImage:(UIImage *)image{
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc]initWithImage:image style:UIBarButtonItemStyleDone target:self action:@selector(clickLeftBarButton:)];
    self.navigationItem.leftBarButtonItem=leftBarButton;
}
- (void)addLeftBarButtonSystemItem:(UIBarButtonSystemItem)systemItem{
    
    UIBarButtonItem *leftBarButton =[[UIBarButtonItem alloc]initWithBarButtonSystemItem:systemItem target:self action:@selector(clickLeftBarButton:)];
    self.navigationItem.rightBarButtonItem=leftBarButton;
    
}


- (void)clickLeftBarButton:(UIButton *)sender{
    NSLog(@"请在对应的类里重写此方法,clickLeftBarButton");
}

//----------------------------------------------------------------------------------------


/*  监听键盘
 *
 */
- (void)addKeyBoard{
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}
/*
 *      键盘出来
 */
- (void)keyboardWillShow: (NSNotification *)notification
{
    NSLog(@"键盘出来keyboardWillShow");
}
/*
 *      键盘隐藏
 */
- (void)keyboardWillHide: (NSNotification *)notification
{
    NSLog(@"键盘隐藏keyboardWillHide");
}


/*
 *      找出当前页面的前面所有页面
 */
- (NSArray *)viewControllers{
    NSMutableArray *array = [[NSMutableArray alloc]initWithCapacity:0];
    UIViewController *vc = self.presentingViewController;
    [array addObject:vc];
    if (!vc.presentingViewController) {
        return array;
    }
    while (vc.presentingViewController) {
        vc = vc.presentingViewController;
        [array addObject:vc];
    }
    return array;
}

/*
 *      dismissTo  返回到指定页面
 */

- (void)dismissToViewController:(UIViewController *)vc completion: (void (^)(void))completion{
    
    [vc dismissViewControllerAnimated:NO completion:completion];
    
}


- (UIViewController *)ToViewController{
    UIViewController *object=[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-2];
    return object;
}



- (UIViewController *)ToViewControllerNumber:(NSInteger)number{
    
    UIViewController *object=[self.navigationController.viewControllers objectAtIndex:[self.navigationController.viewControllers count]-1-number];
    return object;
    
}


- (UIViewController *)ToViewControllerName:(NSString *)strClassName{
    
    Class cls = NSClassFromString(strClassName);
    
    NSArray *array = self.navigationController.viewControllers;
    
    
    for(NSInteger i = [array count];i>=0;i--){
        UIViewController *controller = [array objectAtIndex:i-1];
        
        if (([controller isKindOfClass:[cls class]])) {
            
            UIViewController *object= controller;
            
            return object;
            
        }
        
    }
    
    
    return nil;
    
}

-(void)onBack{
    if (self.navigationController) {
        [self.navigationController popViewControllerAnimated:YES];
    }else{
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (id)storyboardWithName:(NSString *)sbname Identifier:(NSString *)identifier
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:sbname bundle:nil];
    
    return  [storyboard instantiateViewControllerWithIdentifier:identifier];
}

@end
