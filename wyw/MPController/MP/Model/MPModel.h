//
//  MPModel.h
//  wyw
//
//  Created by Xiaoshiheng_pro on 2017/2/24.
//  Copyright © 2017年 XIAO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MPModel : NSObject

///视频封面
@property (nonatomic, strong) NSString* cover_pic;
///视频描述
@property (nonatomic, strong) NSString* caption;
///视频链接
@property (nonatomic, strong) NSString* url;

@end
