//
//  DOGPlayerControlViewProtocol.h
//  DOGPlayer
//
//  Created by RavenZ on 2018/1/20.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DOGPlayerDunkerViewProtocol.h"
@class DOGPlayerControlView;

@protocol DOGPlayerControlViewProtocol <DOGPlayerDunkerViewProtocol>

@optional
/**
 play button control video play or stop

 @param controlView DOGPlayerControlView
 @param play YES / play
 */
- (void)playerControlView:(DOGPlayerControlView *)controlView
                videoPlay:(BOOL)play;

/**
 controlview hidden
 @param controlView DOGPlayerControlView
 @param hidden YES / hidden
 */
- (void)playerControlView:(DOGPlayerControlView *)controlView
                   hidden:(BOOL)hidden;

/**
 controlview fullbutton selected
 */
- (void)playerControlViewFullButtonAction;

@end
