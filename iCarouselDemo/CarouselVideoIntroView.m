//
//  CarouselVideoIntroView.m
//  BaiduVideo-iPad
//
//  Created by liujianjing on 8/9/13.
//  Copyright (c) 2013 Baidu. All rights reserved.
//

#import "CarouselVideoIntroView.h"

#define kVideoTitleLabelFrame										CGRectMake(20, 15, 220, 27)
#define kVideoPlayedTimesLabelFrame									CGRectMake(20, 49, 220, 15)
#define kVideoInfoLabelFrame										CGRectMake(20, 75, 280, 40)



static const CGFloat kBgImageViewTop = 25;
static const CGFloat kBgImageViewLeft = 0;
static const CGFloat kBgImageViewWidth = 245;
static const CGFloat kBgImageViewHeight = 85;

static const CGFloat kPlayBtnLeft = 185;
static const CGFloat kPlayBtnTop = 0;

static const CGFloat kTitleLabelLeft = 3;
static const CGFloat kTitleLabelTop = 0;
static const CGFloat kTitleLabelHeight = 30;
static const CGFloat kTitleLabelWidth = 180;

static const CGFloat kSeasonLabelLeftPadding = 6;
static const CGFloat kSeasonLabelWidth = 50;

static const CGFloat kBriefLabelHeight = 20;

static const CGFloat kPlayedTimesIconImageViewTopPadding = 13;
static const CGFloat kPlayedTimesIconImageViewLeft = 3;

static const CGFloat kPlayedTimesLabelLeftPadding = 5;
static const CGFloat kPlayedTimesLabelHeight = 20;
static const CGFloat kPlayedTimesLabelWidth = 40;
static const CGFloat kPlayedTimesLabelMaxWidth = 80;


@interface UIColor (HexValue)

+ (id)colorWithHexValue:(NSUInteger)hexValue alpha:(NSUInteger)alpha;
+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue;

@end

@implementation UIColor (HexValue)

+ (id)colorWithHexValue:(NSUInteger)hexValue alpha:(NSUInteger)alpha
{
    CGFloat r = ((hexValue & 0x00FF0000) >> 16) / 255.0;
    CGFloat g = ((hexValue & 0x0000FF00) >> 8) / 255.0;
    CGFloat b = (hexValue & 0x000000FF) / 255.0;
    CGFloat a = alpha / 255.0;
    
    return [self colorWithRed:r green:g blue:b alpha:a];
}

+ (UIColor *)colorWithHexValue:(NSUInteger)hexValue
{
    return [self colorWithHexValue:hexValue alpha:255];
}

@end


@interface CarouselVideoIntroView ()
{
    UILabel *_titleLabel;                   // 影片名称
    UILabel *_seasonLabel;                  // 第几季
    UILabel *_briefLabel;                   // 一句话简介
    UILabel *_playedTimesLabel;             // 影片播放次数
    UIImageView *_playedTimesIconImageView; // 播放次数的icon
    UILabel *_prefixPlayedTimesLabel;       // "已播放"
    UILabel *_suffixPlayedTimesLabel;       // “次”、”万次”、“亿次”
    UIButton *_playBtn;                     // 播放按钮
}

@end

@implementation CarouselVideoIntroView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self initUI];
    }
    
    return self;
}

- (void)initUI
{
    // 背景
    [self setBackgroundColor:[UIColor clearColor]];
    
    // 蓝色背景
    UIImageView * bgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kBgImageViewLeft, kBgImageViewTop, kBgImageViewWidth, kBgImageViewHeight)];
    [bgImageView setImage:[UIImage imageNamed:@"bg_picplayer_home"]];
	[self addSubview:bgImageView];
    
    // 播放按钮
    UIImage *playBtnImage = [UIImage imageNamed:@"ic_player_normal_home"];
    _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _playBtn.frame = CGRectMake(kPlayBtnLeft, kPlayBtnTop,
                                     playBtnImage.size.width, playBtnImage.size.height); 
	[_playBtn setBackgroundImage:playBtnImage forState:UIControlStateNormal];
	[_playBtn setBackgroundImage:[UIImage imageNamed:@"ic_player_pressed_home"] forState:UIControlStateHighlighted];
    [_playBtn addTarget:self action:@selector(playBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self bringSubviewToFront:_playBtn];
	[self addSubview:_playBtn];
    
    // 影片标题
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(kTitleLabelLeft, kTitleLabelTop, kTitleLabelWidth, kTitleLabelHeight)];
	_titleLabel.textColor = [UIColor colorWithHexValue:0xffffff];
	_titleLabel.backgroundColor = [UIColor clearColor];
	_titleLabel.textAlignment = UITextAlignmentLeft;
    _titleLabel.lineBreakMode = UILineBreakModeWordWrap | UILineBreakModeTailTruncation;
	_titleLabel.font = [UIFont boldSystemFontOfSize:23];
    [bgImageView addSubview:_titleLabel];
    
    // 一句话简介
    _briefLabel = [[UILabel alloc] initWithFrame:CGRectMake(kTitleLabelLeft, _titleLabel.frame.origin.y+_titleLabel.frame.size.height, bgImageView.frame.size.width-kTitleLabelLeft*2, kBriefLabelHeight)];
	_briefLabel.backgroundColor = [UIColor clearColor];
	_briefLabel.textColor = [UIColor colorWithHexValue:0xffffff];
	_briefLabel.textAlignment = UITextAlignmentLeft;
	_briefLabel.font = [_briefLabel.font fontWithSize:14];
	_briefLabel.numberOfLines = 0;
	_briefLabel.lineBreakMode = UILineBreakModeWordWrap | UILineBreakModeTailTruncation;
	[bgImageView addSubview:_briefLabel];
    
    // 播放次数的icon
    UIImage *playedTimesIconImage = [UIImage imageNamed:@"ic_views_home"];
    CGFloat playedTimesIconImageViewTop = _briefLabel.frame.origin.y+_briefLabel.frame.size.height+kPlayedTimesIconImageViewTopPadding;
    _playedTimesIconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(kPlayedTimesIconImageViewLeft, playedTimesIconImageViewTop, playedTimesIconImage.size.width, playedTimesIconImage.size.height)];
    [_playedTimesIconImageView setImage:playedTimesIconImage];
    [bgImageView addSubview:_playedTimesIconImageView];
    
    // “已播放”
    CGFloat playedTimesLabelTop = playedTimesIconImageViewTop - 5;
    _prefixPlayedTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(_playedTimesIconImageView.frame.origin.x+_playedTimesIconImageView.frame.size.width+kPlayedTimesLabelLeftPadding, playedTimesLabelTop, 40, kPlayedTimesLabelHeight)];
    [_prefixPlayedTimesLabel setText:@"已播放 "];
	_prefixPlayedTimesLabel.backgroundColor = [UIColor clearColor];
	_prefixPlayedTimesLabel.textColor = [UIColor colorWithHexValue:0xffffff];
	_prefixPlayedTimesLabel.textAlignment = UITextAlignmentLeft;
	_prefixPlayedTimesLabel.font = [_briefLabel.font fontWithSize:12];
	[bgImageView addSubview:_prefixPlayedTimesLabel];
    
    // 影片播放次数
    _playedTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(_prefixPlayedTimesLabel.frame.origin.x+_prefixPlayedTimesLabel.frame.size.width, playedTimesLabelTop, kPlayedTimesLabelWidth, kPlayedTimesLabelHeight)];
	_playedTimesLabel.backgroundColor = [UIColor clearColor];
	_playedTimesLabel.textColor = [UIColor colorWithHexValue:0xffffff];
	_playedTimesLabel.textAlignment = UITextAlignmentCenter;
    _playedTimesLabel.lineBreakMode = NSLineBreakByTruncatingTail;
	_playedTimesLabel.font = [UIFont italicSystemFontOfSize:15];
	[bgImageView addSubview:_playedTimesLabel];
    
    // “次”、“万次”、“亿次”
    _suffixPlayedTimesLabel = [[UILabel alloc] initWithFrame:CGRectMake(_playedTimesLabel.frame.origin.x+_playedTimesLabel.frame.size.width+kPlayedTimesLabelLeftPadding, playedTimesLabelTop, 28, kPlayedTimesLabelHeight)];
    [_suffixPlayedTimesLabel setText:@""];
	_suffixPlayedTimesLabel.backgroundColor = [UIColor clearColor];
	_suffixPlayedTimesLabel.textColor = [UIColor colorWithHexValue:0xffffff];
	_suffixPlayedTimesLabel.textAlignment = UITextAlignmentLeft;
	_suffixPlayedTimesLabel.font = [_briefLabel.font fontWithSize:12];
	[bgImageView addSubview:_suffixPlayedTimesLabel];
}

// 更新影片简介信息
- (void)updateVideoIntroVewWithVideoObjectData:(VideoObjectData *)videoObjectData
{
    _titleLabel.text = videoObjectData.title;
    
    if (videoObjectData.hot && ![videoObjectData.hot isEqualToString:@""]) // 不为空
    {
        NSInteger playedTimes = [videoObjectData.hot intValue];
        NSString *playedTimesText = @"";
        NSString *suffixPlayedTimesText = @"次";
        if (playedTimes < 10000)
        {
            playedTimesText = [NSString stringWithFormat:@"%@", videoObjectData.hot];
            suffixPlayedTimesText = @"次";
        }
        else if (playedTimes >= 10000 && playedTimes < 100000000)
        {
            playedTimesText = [NSString stringWithFormat:@"%.2f", playedTimes/10000.0];
            suffixPlayedTimesText = @"万次";
        }
        else
        {
            playedTimesText = [NSString stringWithFormat:@"%.2f", playedTimes/100000000.0];
            suffixPlayedTimesText = @"亿次";
        }
    
        if ([playedTimesText length] > 0) {
            CGSize size = [playedTimesText sizeWithFont:[UIFont italicSystemFontOfSize:15] constrainedToSize:CGSizeMake(kPlayedTimesLabelMaxWidth, kPlayedTimesLabelHeight) lineBreakMode:NSLineBreakByTruncatingTail];
            
            [_playedTimesLabel setFrame:CGRectMake(_playedTimesLabel.frame.origin.x, _playedTimesLabel.frame.origin.y, size.width, _playedTimesLabel.frame.size.height)];
            [_playedTimesLabel setText:playedTimesText];
            
            _suffixPlayedTimesLabel.frame = CGRectMake(_playedTimesLabel.frame.origin.x+_playedTimesLabel.frame.size.width+kPlayedTimesLabelLeftPadding, _suffixPlayedTimesLabel.frame.origin.y, _suffixPlayedTimesLabel.frame.size.width, _suffixPlayedTimesLabel.frame.size.height);
            [_suffixPlayedTimesLabel setText:suffixPlayedTimesText];
        }
    }
    
    if (!videoObjectData.hot || [videoObjectData.hot isEqualToString:@""] || [videoObjectData.hot isEqualToString:@"0"])
    {
        _prefixPlayedTimesLabel.hidden = YES;
        _suffixPlayedTimesLabel.hidden = YES;
        _playedTimesLabel.hidden = YES;
        _playedTimesIconImageView.hidden = YES;
    }
    else
    {
        _prefixPlayedTimesLabel.hidden = NO;
        _suffixPlayedTimesLabel.hidden = NO;
        _playedTimesLabel.hidden = NO;
        _playedTimesIconImageView.hidden = NO;
    }
    
    _briefLabel.text = videoObjectData.brief;
    
    if(!videoObjectData.url || [videoObjectData.url isEqualToString:@""]  || [videoObjectData.url length] <= 0)
    {
        [self setPlayBtnHidden:YES];
    }
    else  
    {
        NSString *bdhdURL = [videoObjectData.url uppercaseString];
        if ([bdhdURL hasPrefix:@"BDHD://"]) // 影音资源，需要隐藏播放按钮
        {
            [self setPlayBtnHidden:YES];
        }
        else
        {
            [self setPlayBtnHidden:NO];
        }
    }
    
    _playBtn.enabled = YES;
    
    if (videoObjectData.works_type)
    {
        // WebView，隐藏播放按钮
        if ([videoObjectData.works_type isEqualToString:@"WebView"])
        {
            [self setPlayBtnHidden:YES];
        }
        else if ([videoObjectData.works_type isEqualToString:@"channel"])
        { // channel，显示并禁用播放按钮
            [self setPlayBtnHidden:NO];
            _playBtn.enabled = NO;
        }
    }
}

- (void)setPlayBtnHidden:(BOOL)hidden
{
    _playBtn.hidden = hidden;
    
    if (hidden)
    {
        [_titleLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y, kBgImageViewWidth, _titleLabel.frame.size.height)];
    }
    else
    {
        [_titleLabel setFrame:CGRectMake(_titleLabel.frame.origin.x, _titleLabel.frame.origin.y, kTitleLabelWidth, _titleLabel.frame.size.height)];
    }
}

// 播放按钮点击事件
- (void)playBtnClicked:(UIButton *)btn
{
    if (self.delegate && [self.delegate respondsToSelector:@selector(carouselVideoIntroViewDidClickedPlayBtn:)])
    {
        [self.delegate performSelector:@selector(carouselVideoIntroViewDidClickedPlayBtn:) withObject:self];
    }
}


@end
