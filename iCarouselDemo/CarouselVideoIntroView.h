//
//  CarouselVideoIntroView.h
//  BaiduVideo-iPad
//
//  Created by liujianjing on 8/9/13.
//  Copyright (c) 2013 Baidu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VideoObjectData.h"

@class CarouselVideoIntroView;
@protocol CarouselVideoIntroViewDelegate <NSObject>

@optional
/**
 * @brief 轮播图上简介按钮的点击事件
 * @param introView 轮播图上的半透明简介
 */
- (void)carouselVideoIntroViewDidClickedPlayBtn:(CarouselVideoIntroView *)introView;

@end

/**
 * @brief  轮播图上的影片简介
 * @detail 包含了名称、播放次数和内容概要信息
 */
@interface CarouselVideoIntroView : UIView

@property (nonatomic, weak)id<CarouselVideoIntroViewDelegate> delegate;

/**
 * @brief 设置影片简介信息
 * @param videoObjectData 影片内容数据
 */
- (void)updateVideoIntroVewWithVideoObjectData:(VideoObjectData *)videoObjectData;

@end

