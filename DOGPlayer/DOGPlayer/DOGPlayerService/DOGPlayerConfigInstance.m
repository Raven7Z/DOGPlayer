//
//  DOGPlayerConfigInstance.m
//  DOGPlayer
//
//  Created by butterfly on 7/3/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGPlayerConfigInstance.h"

@implementation DOGPlayerConfigInstance

+ (DOGPlayerConfigInstance *)shareInstance {
    static DOGPlayerConfigInstance *_shareInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _shareInstance = [[DOGPlayerConfigInstance alloc] init];
    });
    return _shareInstance;
}

@end
