//
//  DOGPlayerConfigInstance.h
//  DOGPlayer
//
//  Created by butterfly on 7/3/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "DOGPlayerTabBarController.h"

@interface DOGPlayerConfigInstance : NSObject

+ (DOGPlayerConfigInstance *)shareInstance;

@property (nonatomic, weak) DOGPlayerTabBarController *rootController;

@end
