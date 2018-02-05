//
//  DOGPlayerItem.h
//  DOGPlayer
//
//  Created by butterfly on 26/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <Foundation/Foundation.h>

static const NSString * _Nonnull kVideoURL = @"dog_play_video_url";

@interface DOGPlayerItem : NSObject


/**
 video play URL
 */
@property (nonatomic, copy, readonly, nonnull) NSString *videoURL;

- (instancetype _Nullable)initWithDictionary:(NSDictionary *_Nullable)dictionary;

@end
