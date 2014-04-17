//
//  CarouselView.h
//  iCarouselDemo
//
//  Created by baidu on 13-11-3.
//  Copyright (c) 2013年 alex. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarouselVideoIntroView.h"

@interface CarouselView : UIView
@property(nonatomic,strong)UIImageView *shadowView;
@property(nonatomic,strong)UIImageView *imgView;
@property(nonatomic,strong)UIView *maskView;
@property(nonatomic,strong)CarouselVideoIntroView *videoIntroView;




@end
