//
//  XBImageSize.h
//  wyw
//
//  Created by Xiaoshiheng_pro on 2017/2/21.
//  Copyright © 2017年 XIAO. All rights reserved.
//

#import <Foundation/Foundation.h>

// @interface
#define singleton_interface(className) \
+ (className *)shared##className;


// @implementation
#define singleton_implementation(className) \
static className *_instance; \
+ (id)allocWithZone:(NSZone *)zone \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [super allocWithZone:zone]; \
}); \
return _instance; \
} \
+ (className *)shared##className \
{ \
static dispatch_once_t onceToken; \
dispatch_once(&onceToken, ^{ \
_instance = [[self alloc] init]; \
}); \
return _instance; \
}

@interface XBImageSize : NSObject

singleton_interface(XBImageSize)
/**
 获取网络图片的Size, 先通过文件头来获取图片大小
 如果失败 会下载完整的图片Data 来计算大小 所以最好别放在主线程
 如果你有使用SDWebImage就会先看下 SDWebImage有缓存过改图片没有
 支持文件头大小的格式 png、gif、jpg
 */
+(CGSize)downloadImageSizeWithURL:(id)imageURL;

@end
