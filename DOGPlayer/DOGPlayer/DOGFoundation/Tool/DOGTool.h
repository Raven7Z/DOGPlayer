//
//  DOGTool.h
//  DOGPlayer
//
//  Created by butterfly on 24/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DOGTool : NSObject

/**
 calculate text size

 @param text content
 @param fontSize CGFloat
 @param width CGFloat
 @param name NSString
 @return CGSize
 */
+ (CGSize)dog_CalculateSizeOfNormalText:(NSString *)text
                                   font:(CGFloat)fontSize
                                  width:(CGFloat)width
                           fontWithName:(NSString *)name;
@end
