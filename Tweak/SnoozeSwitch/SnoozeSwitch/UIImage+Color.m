//
//  UIImage+Color.m
//  SnoozeSwitch
//
//  Created by Julian Weiss on 4/27/14.
//  Copyright (c) 2014 Julian Weiss. All rights reserved.
//

#import "UIImage+Color.h"

@implementation UIImage (Color)

// Derived from Matt Stevens' popular UIImage solution
+ (UIImage *)imageWithColor:(UIColor *)color forSize:(CGSize)size{
	CGRect drawRect = (CGRect){CGPointZero, size};
	
	UIGraphicsBeginImageContext(drawRect.size);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, color.CGColor);
	CGContextFillRect(context, drawRect);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

@end
