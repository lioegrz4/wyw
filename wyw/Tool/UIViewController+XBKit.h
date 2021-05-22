//
//  UIViewController+XBKit.h
//  lxtxAppCustomer
//
//  Created by com.chetuba on 15/7/9.
//  Copyright (c) 2015年 Lxtx. All rights reserved.
//
// 创建初始化函数。等于用宏创建一个getter函数

#define cDPodRecordTypeGet (DPodRecordTypeArray == nil ? DPodRecordTypeArray = [[NSArray alloc] initWithObjects:\
@"请创建DPodRecordTypeArray数组,数组对应枚举的字符", nil] : DPodRecordTypeArray)


static const NSArray *DPodRecordTypeArray;
// 枚举 to 字串

#define cDPodRecordTypeString(type) ([cDPodRecordTypeGet objectAtIndex:type])

// 字串 to 枚举

#define cDPodRecordTypeEnum(string) ([cDPodRecordTypeGet indexOfObject:string])



#import <UIKit/UIKit.h>

@interface UIViewController (XBKit)

/**
 *  创建右上角按钮
 *
 *  @param name 按钮文字
 */
- (void)addRightBarButton:(NSString *)name;
/**
 *  创建右上角按钮
 *
 *  @param image 按钮图片
 */
- (void)addRightBarButtonImage:(UIImage *)image;
/**
 *  创建右上角按钮
 *
 *  @param systemItem 系统样式
 */
- (void)addRightBarButtonSystemItem:(UIBarButtonSystemItem)systemItem;
/**
 *  右上角按钮点击事件
 *
 *  @param sender 按钮
 */
- (void)clickRightBarButton:(UIButton *)sender;

//---------------------------------------------------------------

/**
 *  创建左上角按钮
 *
 *  @param name 按钮文字
 */
- (void)addLeftBarButton:(NSString *)name;

/**
 *  创建左上角按钮
 *
 *  @param image 按钮图片
 */
- (void)addLeftBarButtonImage:(UIImage *)image;
/**
 *  创建右上角按钮
 *
 *  @param systemItem 系统样式
 */
- (void)addLeftBarButtonSystemItem:(UIBarButtonSystemItem)systemItem;

/**
 *  左上角按钮事件
 *
 *  @param sender 按钮
 */
- (void)clickLeftBarButton:(UIButton *)sender;
//---------------------------------------------------------------
/**
 *添加监听键盘
 *键盘出现keyboardWillShow
 *键盘隐藏  keyboardWillHide
 */
- (void)addKeyBoard;
///键盘出现
- (void)keyboardWillShow: (NSNotification *)notification;
///键盘隐藏
- (void)keyboardWillHide: (NSNotification *)notification;
//---------------------------------------------------------------

/**
 *  找出当前控制器的前面所有控制器
 *
 *  @return 页数组
 */
- (NSArray *)viewControllers;


/**
 *  dismissTo 返回到指定控制器
 *
 *  @param vc
 *  @param completion 回调
 */

- (void)dismissToViewController:(UIViewController *)vc completion: (void (^)(void))completion;

//----------------------------------------------------------------

/**
 *  当前控制器的前一控制器
 *
 *  @return UIViewController
 */
- (UIViewController *)ToViewController;

/**
 *  当前控制器的前面的控制器
 *
 *  @param number 前面第几个控制器
 *
 *  @return UIViewController
 */
- (UIViewController *)ToViewControllerNumber:(NSInteger)number ;
/**
 *  识别哪个控制器
 *
 *  @param strClassName 控制器的名字
 *
 *  @return UIViewController
 */
- (UIViewController *)ToViewControllerName:(NSString *)strClassName;


/**
 *  返回上一页
 */
-(void)onBack;

/**
 *  跳转到那个sb控制器
 *
 *  @param sbname     SB的名字
 *  @param identifier 视图的名字
 *
 *  @return id
 */
- (id)storyboardWithName:(NSString *)sbname Identifier:(NSString *)identifier;

@end
