//
//  DOGPlayer.h
//  DOGPlayer
//
//  Created by RavenZ on 2018/1/21.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <MediaPlayer/MediaPlayer.h>

#import <AVFoundation/AVFoundation.h>
#import "DOGPlayerProtocol.h"

@interface DOGPlayer : AVPlayer <DOGPlayerProtocol>

@end
