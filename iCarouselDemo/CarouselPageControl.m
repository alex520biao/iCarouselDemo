//
//  CarouselPageControl.m
//  BaiduVideo-iPad
//
//  Created by lihai on 8/18/12.
//  Copyright (c) 2012 Baidu. All rights reserved.
//

#import "CarouselPageControl.h"

@interface CarouselPageControl(private)

- (void) updateDots;

@end


@implementation CarouselPageControl

@synthesize imagePageStateNormal,imagePageStateHightlighted;
@synthesize dotSize;
@synthesize backImage;

- (id)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code. 
        dotSize = CGSizeZero;
    }
    return self;
}

- (void) setImagePageStateNormal:(UIImage *)image
{
	imagePageStateNormal = image;
	[self updateDots];
}

- (void) setImagePageStateHightlighted:(UIImage *)image
{
	imagePageStateHightlighted = image;
	[self updateDots];
}

- (void) endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	[super endTrackingWithTouch:touch withEvent:event];
	[self updateDots];
}

-(void)setCurrentPage:(NSInteger)currentPage{
    [super setCurrentPage:currentPage];
    [self updateDots];
}

- (void) updateDots
{
	if (imagePageStateNormal || imagePageStateHightlighted) {
		NSArray *subView = self.subviews;
		float topOffset = (self.frame.size.height - 12) / 2;
		float leftOffset = (self.frame.size.width / [subView count] - 14) / 2;
		
		for (int i = 0; i < [subView count]; i++) {
			UIImageView *dot = [subView objectAtIndex:i];
            if ([dot isKindOfClass:[UIImageView class]]) {
                dot.image = (self.currentPage == i ? imagePageStateHightlighted : imagePageStateNormal);
                if (dotSize.width == 0) {
                    dot.frame = CGRectMake(self.frame.size.width / [subView count] * i + leftOffset, topOffset, 12, 12);
                }else{
                    dot.frame = CGRectMake(self.frame.size.width / [subView count] * i + leftOffset, topOffset, dotSize.width, dotSize.height);
                }
                // 100, 426, 120, 34
            }
		}
        
	}
}

-(void)drawRect:(CGRect)rect{
	if (imagePageStateNormal || imagePageStateHightlighted) {
		NSArray *subView = self.subviews;
		float topOffset = (self.frame.size.height - 12) / 2;
		float leftOffset = (self.frame.size.width / [subView count] - 14) / 2;
		
		for (int i = 0; i < [subView count]; i++) {
			UIImageView *dot = [subView objectAtIndex:i];
            if ([dot isKindOfClass:[UIImageView class]]) {
                dot.image = (self.currentPage == i ? imagePageStateHightlighted : imagePageStateNormal);
                if (dotSize.width == 0) {
                    dot.frame = CGRectMake(self.frame.size.width / [subView count] * i + leftOffset, topOffset, 12, 12);
                }else{
                    dot.frame = CGRectMake(self.frame.size.width / [subView count] * i + leftOffset, topOffset, dotSize.width, dotSize.height);
                }
            }
		}
        
	}
}
- (void)dealloc {
	imagePageStateNormal = nil;
	imagePageStateHightlighted = nil;
}


@end
