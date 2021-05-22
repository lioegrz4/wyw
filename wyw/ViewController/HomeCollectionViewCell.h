//
//  HomeCollectionViewCell.h
//  wyw
//
//  Created by com.chetuba on 16/3/21.
//  Copyright © 2016年 XIAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomeCollectionViewCell : UICollectionViewCell

/**
 *  图标
 */
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
/**
 *  标题
 */
@property (weak, nonatomic) IBOutlet UILabel *textLabel;

/**
 *  高宽  比例
 */
@property (nonatomic,assign) CGFloat proportion;

@end
