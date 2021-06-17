

#ifndef XSHPlayer_h
#define XSHPlayer_h


#define iPhone4s ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
// 监听TableView的contentOffset
#define kXSHPlayerViewContentOffset          @"contentOffset"

// 颜色值RGB
#define RGBA(r,g,b,a)                       [UIColor colorWithRed:r/255.0f green:g/255.0f blue:b/255.0f alpha:a]
// 图片路径
#define XSHPlayerSrcName(file)               [@"XSHPlayer.bundle" stringByAppendingPathComponent:file]

#import <Masonry/Masonry.h>
//#import "XSHPlayerView.h"
#import "XSHPlayerToolView.h"

#endif
