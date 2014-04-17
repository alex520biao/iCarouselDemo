//
//  CarouselPageControl.h
//  BaiduVideo-iPad
//
//  Created by lihai on 8/18/12.
//  Copyright (c) 2012 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface CarouselPageControl : UIPageControl {
	UIImage *imagePageStateNormal;
	UIImage *imagePageStateHightlighted;
    CGSize  dotSize;
}

- (id) initWithFrame:(CGRect)frame;

@property (nonatomic, strong) UIImage *imagePageStateNormal;
@property (nonatomic, strong) UIImage *imagePageStateHightlighted;
@property (nonatomic, strong) UIImageView *backImage;
@property (nonatomic, assign) CGSize       dotSize;

-(void)setCurrentPage:(NSInteger)currentPage;
@end
