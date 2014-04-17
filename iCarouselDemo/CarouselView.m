//
//  CarouselView.m
//  iCarouselDemo
//
//  Created by baidu on 13-11-3.
//  Copyright (c) 2013年 alex. All rights reserved.
//

#import "CarouselView.h"
#define kVideoIntroViewFrame							CGRectMake(445, 157, 245, 111.5)

@interface CarouselView ()
//@property(nonatomic,strong)UIImageView *shadowView;
//@property(nonatomic,strong)UIImageView *imgView;
//@property(nonatomic,strong)UIView *maskView;

@end

@implementation CarouselView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        UIImage * shadowImg = [UIImage imageNamed:@"pic_home_first"];
        UIImageView * shadowView = [[UIImageView alloc]initWithImage:shadowImg];
        shadowView.frame = CGRectMake(0, frame.size.height - shadowImg.size.height, shadowImg.size.width, shadowImg.size.height);//kScrollViewImgShadowFrame;
        [self addSubview:shadowView];
        shadowView.backgroundColor=[UIColor clearColor];
        self.shadowView=shadowView;
        
        CGRect clickFrame=CGRectMake(0,22,self.frame.size.width, self.frame.size.height-44);
        UIView * clipView = [[UIView alloc]initWithFrame:clickFrame];
        clipView.backgroundColor = [UIColor clearColor];
        clipView.clipsToBounds = YES;
        [self addSubview:clipView];
        
        UIImageView * imgView = [[UIImageView alloc]initWithFrame:clipView.bounds];
        [clipView addSubview:imgView];
        self.imgView=imgView;
        
        CarouselVideoIntroView *videoIntroView = [[CarouselVideoIntroView alloc] initWithFrame:kVideoIntroViewFrame];
        [videoIntroView setDelegate:self];
        [self addSubview:videoIntroView];
        self.videoIntroView=videoIntroView;
        
        UIView * maskView = [[UIView alloc]initWithFrame:clipView.bounds];
        maskView.backgroundColor = [UIColor blackColor];
        maskView.alpha = 0.3;
        [clipView addSubview:maskView];
        self.maskView=maskView;
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
