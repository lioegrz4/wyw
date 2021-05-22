//
//  VodViewController.h
//  wyw
//
//  Created by Xiaoshiheng_pro on 2016/11/17.
//  Copyright © 2016年 XIAO. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VodViewController : UIViewController



@property (nonatomic, strong) NSMutableArray *photos;

@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end
