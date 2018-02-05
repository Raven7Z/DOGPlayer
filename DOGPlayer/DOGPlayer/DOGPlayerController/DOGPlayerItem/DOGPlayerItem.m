//
//  DOGPlayerItem.m
//  DOGPlayer
//
//  Created by butterfly on 26/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerItem.h"

@interface DOGPlayerItem ()

@property (nonatomic, copy) NSString *videoURL;

@end

@implementation DOGPlayerItem

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        _videoURL = [dictionary objectForKey:kVideoURL];
    }
    return self;
}

@end
