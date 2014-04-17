//
//  ViewController.m
//  iCarouselDemo
//
//  Created by baidu on 13-11-3.
//  Copyright (c) 2013年 alex. All rights reserved.
//

#import "ViewController.h"
#import "UIImageView+WebCache.h"
#define kScrollViewFrame								CGRectMake(167, 0, 690, 315)
#define kPageControllerFrame							CGRectMake(445, 315, 134, 12)
#define kTravelUserGuideDotActiveImage                  @"ic_home_page_fouces.png"
#define kTravelUserGuideDotInActiveImage                @"ic_home_page_mormal.png"

#define ITEM_SPACING 300
#import "CarouselView.h"

@interface ViewController ()
@property (nonatomic, strong)iCarousel *carousel;
@property (nonatomic, strong)NSMutableArray *picList;
@property (nonatomic, strong)CarouselPageControl *m_pageControl;
@property (nonatomic, assign)NSTimer *carouselTimer;


@property (nonatomic, strong) UISlider *tiltSlider;
@property (nonatomic, strong) UISlider *spacingSlider;


@end

@implementation ViewController
@synthesize carousel=_carousel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor=[UIColor clearColor];
    
    //configure carousel
    iCarousel *carousel=[[iCarousel alloc] initWithFrame:CGRectMake(0, 0, 1024, 331)];
    carousel.type = iCarouselTypeCoverFlow2;
    carousel.pagingEnabled=YES;
    carousel.delegate=self;
    carousel.dataSource=self;
    [self.view addSubview:carousel];
    self.carousel=carousel;
    [self.carousel scrollToItemAtIndex:1 duration:0];
    self.carousel.backgroundColor=[UIColor whiteColor];
    
    if (self.m_pageControl) {
		[self.m_pageControl removeFromSuperview];
		self.m_pageControl = nil;
	}
	self.m_pageControl = [[CarouselPageControl alloc] initWithFrame:kPageControllerFrame];
	self.m_pageControl.backgroundColor=[UIColor clearColor];
	[self.m_pageControl setImagePageStateNormal:[UIImage imageNamed:kTravelUserGuideDotInActiveImage]];
	[self.m_pageControl setImagePageStateHightlighted:[UIImage imageNamed:kTravelUserGuideDotActiveImage]];
	self.m_pageControl.numberOfPages = self.picList.count;
	if (self.picList.count == 1) {
		self.m_pageControl.currentPage = 0;
	}
	[self.view addSubview:self.m_pageControl];
    
    UISlider *tiltSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 350, 200, 20)];//初始化
	tiltSlider.minimumValue = 0.00100000004749745;//指定可变最小值
	tiltSlider.maximumValue = 1;//指定可变最大值
    tiltSlider.value = 0.899999976158142;//指定初始值
 	[tiltSlider addTarget:self action:@selector(reloadCarousel) forControlEvents:UIControlEventValueChanged];//设置响应事件
    [self.view addSubview:tiltSlider];
    self.tiltSlider=tiltSlider;
    
    UISlider *spacingSlider = [[UISlider alloc] initWithFrame:CGRectMake(0, 380, 200, 20)];//初始化
	spacingSlider.minimumValue = 0.00100000004749745;//指定可变最小值
	spacingSlider.maximumValue = 2;//指定可变最大值
    spacingSlider.value = 1;//指定初始值
 	[spacingSlider addTarget:self action:@selector(reloadCarousel) forControlEvents:UIControlEventValueChanged];//设置响应事件
    [self.view addSubview:spacingSlider];
    self.spacingSlider=spacingSlider;
    
    UIButton *checkButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    checkButton.frame = CGRectMake(100, 400, 100, 50);
    checkButton.contentVerticalAlignment = UIControlContentVerticalAlignmentCenter;
    checkButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    [checkButton setTitle:@"刷新" forState:UIControlStateNormal];
    [checkButton addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    checkButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:checkButton];
}

-(void)checkAction{
    NSMutableArray *picList=[[NSMutableArray alloc] initWithObjects:
                             @"http://c.hiphotos.baidu.com/video/pic/item/aa18972bd40735fad410d5979c510fb30f24083f.jpg",
                             @"http://b.hiphotos.baidu.com/video/pic/item/96dda144ad3459829ad694820ef431adcbef8445.jpg",
                             @"http://g.hiphotos.baidu.com/video/pic/item/32fa828ba61ea8d3cba73b21950a304e251f5809.jpg",
                             @"http://b.hiphotos.baidu.com/video/pic/item/c75c10385343fbf2af4cd733b27eca8065388fb9.jpg",
                             @"http://c.hiphotos.baidu.com/video/pic/item/1f178a82b9014a90a573dc93ab773912b31bee4b.jpg",
                             @"http://e.hiphotos.baidu.com/video/pic/item/060828381f30e92436f822074e086e061d95f7ac.jpg",
                             @"http://g.hiphotos.baidu.com/video/pic/item/a8014c086e061d9505700d2879f40ad162d9caef.jpg",
                             nil];
    self.picList=picList;

    [self.carousel reloadData];
    [self.carousel scrollByNumberOfItems:1 duration:0];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    [self startCarouselTimer];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];

    [self stopCarouselTimer];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    self.carousel = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation ==UIInterfaceOrientationLandscapeRight)||(interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}

#pragma mark custom
- (void)startCarouselTimer
{        
    if (!self.carouselTimer) {
        [self stopCarouselTimer];
    }
    
    // 开启carousel（轮播图） timer
    NSTimer *carouselTimer = [NSTimer scheduledTimerWithTimeInterval:3.0f
                                                              target:self
                                                            selector:@selector(onTimer:)
                                                            userInfo:nil
                                                             repeats:YES];
    self.carouselTimer=carouselTimer;
}

- (void)stopCarouselTimer
{
    [self.carouselTimer invalidate];
    self.carouselTimer = nil;
}

- (void)onTimer:(id)sender
{
    [self.carousel scrollByNumberOfItems:1 duration:0.5f];
}

- (void)reloadCarousel
{
    [_carousel reloadData];
}

#pragma mark -
#pragma mark iCarousel methods
//- (CGFloat)carouselItemWidth:(iCarousel *)carousel
//{
//    return ITEM_SPACING;
//}
//
//- (BOOL)carouselShouldWrap:(iCarousel *)carousel{
//    return YES;
//}

- (NSUInteger)numberOfItemsInCarousel:(iCarousel *)carousel
{
    return self.picList.count;
}

- (UIView *)carousel:(iCarousel *)carousel viewForItemAtIndex:(NSUInteger)index reusingView:(CarouselView *)view
{	
	//create new view if no view is available for recycling
	if (view == nil)
	{        
        view=[[CarouselView alloc] initWithFrame:kScrollViewFrame];
	}
	
    NSString *str=[self.picList objectAtIndex:index];
    [view.imgView setImageWithURL:[NSURL URLWithString:str]];
    
    VideoObjectData *video=[[VideoObjectData alloc] init];
    video.img_url=str;
    video.title=@"我是特种兵之火凤凰";
    video.brief=@"揭秘真实女子霸王花";
    video.hot=@"412561";
    video.url=@"http://www.56.com/u79/v_OTkyNDczNDg.html";
    [view.videoIntroView updateVideoIntroVewWithVideoObjectData:video];
    view.backgroundColor=[UIColor redColor];
	return view;
}

- (void)carouselCurrentItemIndexDidChange:(iCarousel *)carousel{
    CarouselView *currentView=(CarouselView*)[self.carousel currentItemView];
    NSArray *views=[self.carousel visibleItemViews];
    for (CarouselView *view in views) {
        if (view==currentView) {
            [UIView animateWithDuration:0.3 animations:^{
                currentView.maskView.alpha=0;
            }];
            view.videoIntroView.hidden=NO;
        }else{
            [UIView animateWithDuration:0.3 animations:^{
                view.maskView.alpha=0.3;
            }];
            view.videoIntroView.hidden=YES;
        }
    }
}

- (CGFloat)carousel:(iCarousel *)carousel valueForOption:(iCarouselOption)option withDefault:(CGFloat)value{
    switch (option)
    {
        case iCarouselOptionWrap:
        {
            return YES;
        }
//        case iCarouselOptionTilt:
//        {
//            return 0.1f;
//        }
//        case iCarouselOptionSpacing:
//        {
//            return 0.9;
//        }
        case iCarouselOptionTilt:
        {
            NSLog(@"tilt:%f",_tiltSlider.value);
            return _tiltSlider.value;
        }
        case iCarouselOptionSpacing:
        {
            NSLog(@"spaceing:%f",_spacingSlider.value);
            return value * _spacingSlider.value;
        }
        default:
        {
            return value;
        }
    }
}

- (void)carouselDidScroll:(iCarousel *)carousel
{
    int currentPage=carousel.currentItemIndex-1;
    if (currentPage<0) {
        currentPage=self.m_pageControl.numberOfPages-1;
    }
    self.m_pageControl.currentPage =currentPage;
}

- (void)carouselWillBeginDragging:(iCarousel *)carousel{
	[self stopCarouselTimer];
}
- (void)carouselDidEndDragging:(iCarousel *)carousel willDecelerate:(BOOL)decelerate{
	[self startCarouselTimer];

}
- (void)carouselWillBeginDecelerating:(iCarousel *)carousel{

}
- (void)carouselDidEndDecelerating:(iCarousel *)carousel{

}


@end
