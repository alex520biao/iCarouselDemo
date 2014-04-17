//
//  VideoObjectData.h
//  BaiduVideo-iPad
//
//  Created by lihai on 8/31/12.
//  Copyright (c) 2012 Baidu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VideoObjectData : NSObject

@property (copy, nonatomic) NSString * videoId;
@property (copy, nonatomic) NSString * title;
@property (copy, nonatomic) NSString * url;
@property (copy, nonatomic) NSString * img_url;
@property (copy, nonatomic) NSString * img_3d_url;
@property (copy, nonatomic) NSString * intro;
@property (copy, nonatomic) NSString * hot;
@property (copy, nonatomic) NSString * update;
@property (copy, nonatomic) NSString * duration;
@property (copy, nonatomic) NSString * rating;
@property (copy, nonatomic) NSString * episode;
@property (copy, nonatomic) NSString * site;
@property (assign, nonatomic) NSInteger is_3d;
@property (assign, nonatomic) NSInteger videoType;
@property (copy, nonatomic) NSString * works_type;
@property (copy, nonatomic) NSString * tv_id;
@property (copy, nonatomic) NSString * brief;

@end
