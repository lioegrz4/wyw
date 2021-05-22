//
//  MJPhotoToolbar.m
//  FingerNews
//
//  Created by mj on 13-9-24.
//  Copyright (c) 2013年 itcast. All rights reserved.
//

#import "MJPhotoToolbar.h"
#import "MJPhoto.h"
#import "STAlbumManager.h"
//#import "MBProgressHUD+Add.h"
//#import "DCJAppDelegate.h"

@interface MJPhotoToolbar()
{
//    DCJAppDelegate * app;
    // 显示页码
    UILabel *_indexLabel;
    UIButton *_saveImageBtn;
}
@end

@implementation MJPhotoToolbar

@synthesize Delegate;
@synthesize DeleteImage;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
//        app = (DCJAppDelegate *)[[UIApplication sharedApplication] delegate];
    }
    return self;
}

- (void)setPhotos:(NSArray *)photos
{
    _photos = photos;
    
    if (_photos.count > 1) {
        _indexLabel = [[UILabel alloc] init];
        _indexLabel.font = [UIFont boldSystemFontOfSize:20];
        _indexLabel.frame = self.bounds;
        _indexLabel.backgroundColor = [UIColor clearColor];
        _indexLabel.textColor = [UIColor whiteColor];
        _indexLabel.textAlignment = NSTextAlignmentCenter;
        _indexLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
        [self addSubview:_indexLabel];
    }
    
    // 保存图片按钮
    CGFloat btnWidth = self.bounds.size.height;
    _saveImageBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _saveImageBtn.frame = CGRectMake(20, 0, btnWidth, btnWidth);
    _saveImageBtn.autoresizingMask = UIViewAutoresizingFlexibleHeight;
    
    [_saveImageBtn setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon.png"] forState:UIControlStateNormal];
    
    [_saveImageBtn setImage:[UIImage imageNamed:@"MJPhotoBrowser.bundle/save_icon_highlighted.png"] forState:UIControlStateHighlighted];
    
//    [_saveImageBtn setImage:[UIImage imageNamed:@"photo-gallery-trashcan.png"] forState:UIControlStateHighlighted];
    [_saveImageBtn addTarget:self action:@selector(saveImage) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_saveImageBtn];
    
}
-(void)deleteThisImage
{
    if ( [Delegate respondsToSelector:@selector(DeleteThisImage:)] ) {
        [Delegate DeleteThisImage:_currentPhotoIndex];
    }
}

- (void)saveImage
{
    MJPhoto *photo = _photos[_currentPhotoIndex];
    [[STAlbumManager sharedManager]saveImage:photo.image toAlbum:@"污妖王" completionHandler:^(UIImage *image, NSError *error){
        
        if (error) {
            [SVProgressHUD showErrorWithStatus:@"保存失败"];
        } else {
            MJPhoto *photo = _photos[_currentPhotoIndex];
            photo.save = YES;
            _saveImageBtn.enabled = NO;
            [SVProgressHUD showSuccessWithStatus:@"成功保存到相册" ];
        }
    }];
}


- (void)setCurrentPhotoIndex:(NSUInteger)currentPhotoIndex
{
    _currentPhotoIndex = currentPhotoIndex;
    
    // 更新页码
    _indexLabel.text = [NSString stringWithFormat:@"%d / %d", (int)_currentPhotoIndex + 1, (int)_photos.count];
//    _indexLabel.text = @"";
    
    MJPhoto *photo = _photos[_currentPhotoIndex];
    // 按钮
    _saveImageBtn.enabled = photo.image != nil && !photo.save;
}

@end
