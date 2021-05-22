//
//  ItemModel.h
//  wyw
//
//  Created by Xiaoshiheng_pro on 2017/2/21.
//  Copyright © 2017年 XIAO. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ItemModel : NSObject


@property (nonatomic, assign) CGFloat w;
@property (nonatomic, assign) CGFloat h;
@property (nonatomic, copy) NSString *videoUrl;
@property (nonatomic, copy) NSString *img;
@property (nonatomic, copy) NSString *text;

@end
