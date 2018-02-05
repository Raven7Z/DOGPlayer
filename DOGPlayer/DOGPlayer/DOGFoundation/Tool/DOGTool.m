//
//  DOGTool.m
//  DOGPlayer
//
//  Created by butterfly on 24/1/18.
//  Copyright © 2018年 RavenZ. All rights reserved.
//

#import "DOGTool.h"

@implementation DOGTool

+ (CGSize)dog_CalculateSizeOfNormalText:(NSString *)text font:(CGFloat)fontSize width:(CGFloat)width fontWithName:(NSString *)name {
    
    if (!text || text.length == 0 || [text isEqualToString:@""]) {
        return CGSizeZero;
    }
    
    CGRect textRect = [text boundingRectWithSize:CGSizeMake(width, fontSize)
                                          options:NSStringDrawingUsesFontLeading |NSStringDrawingTruncatesLastVisibleLine |NSStringDrawingUsesLineFragmentOrigin
                                       attributes:@{
                                                    NSFontAttributeName :[UIFont systemFontOfSize:fontSize]
                                                    }
                                          context:NULL];
    return textRect.size;
}

@end
