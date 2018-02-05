//
//  DOGPlayerProtocol.h
//  DOGPlayer
//
//  Created by RavenZ on 2018/1/21.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 player core protocol
 */
@protocol DOGPlayerProtocol <NSObject>

@optional

/**
 init player
 */
- (void)prepareToPlay;

/**
 stop player
 */
- (void)stop;

/**
 reset player
 */
- (void)reset;

/**
 play player
 */
- (void)play;

/**
 pause player
 */
- (void)pause;

@end
