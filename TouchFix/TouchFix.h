#ifndef __LP64__

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#import "UITouch+Private.h"

@interface UIEvent (Tranquil__TouchFix)

- (instancetype)initWithTouch:(UITouch *)touch;

@end

@interface UITouch (Tranquil__TouchFix)

- (instancetype)initWithPoint:(CGPoint)point andView:(UIView *)view;

@end

#endif