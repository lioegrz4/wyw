//
//  HomeBViewController.h
//  wyw
//
//  Created by com.chetuba on 16/3/23.
//  Copyright © 2016年 XIAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeBViewController : UICollectionViewController

/**
 *  连接
 */
@property (nonatomic, strong) NSString* url;

@property (nonatomic, strong) NSMutableArray *photos;


@end
