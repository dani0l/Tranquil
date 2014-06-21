//
//  SSSwitch.m
//  SnoozeSwitch
//
//  Created by Julian Weiss on 4/27/14.
//  Copyright (c) 2014 Julian Weiss. All rights reserved.
//

#import "SSSwitch.h"
#define SNOOZE_INTERVAL 1.0
#define SNOOZE_COLOR [UIColor colorWithWhite:0.88 alpha:1.0]

@interface UISwitch (Private)
- (void)_animateToOn:(BOOL)arg1 withDuration:(float)arg2 sendAction:(BOOL)arg3;
- (void)_setPressed:(BOOL)arg1 on:(BOOL)arg2 animated:(BOOL)arg3 completion:(id)arg4;
- (void)_onAnimationDidStop:(id)arg1 finished:(id)arg2 context:(void*)arg3;
@end

@interface UIGestureRecognizerTarget: NSObject {
	@public
    SEL _action;
    id _target;
}

- (id)description;
@end

@implementation SSSwitch

static char * kSnoozeSwitchIgnoreKey;

- (instancetype)initWithFrame:(CGRect)frame {
	self = [super initWithFrame:frame];
	if (self) {
		[self addTarget:self action:@selector(actionFired) forControlEvents:UIControlEventValueChanged];
	}
	
	return self;
}

- (void)actionFired {
	NSLog(@"fired!");
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *lastTouch = [touches anyObject];
	CGPoint location = [lastTouch locationInView:lastTouch.view];
	CGFloat threshold = -self.frame.size.width * 0.5;
	
	if (location.x < threshold) {
		[self.class cancelPreviousPerformRequestsWithTarget:self selector:@selector(completeSnoozeLongPress) object:nil];
		[self performSelector:@selector(completeSnoozeLongPress) withObject:nil afterDelay:SNOOZE_INTERVAL];
	}
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.class cancelPreviousPerformRequestsWithTarget:self selector:@selector(completeSnoozeLongPress) object:nil];
	[super touchesEnded:touches withEvent:event];
		
	if (self.on) {
		[self performSelector:@selector(resetSnoozeColor) withObject:nil afterDelay:0.1];
	}
}

- (void)resetSnoozeColor {
	self.backgroundColor = [UIColor clearColor];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.class cancelPreviousPerformRequestsWithTarget:self selector:@selector(completeSnoozeLongPress) object:nil];
	[super touchesCancelled:touches withEvent:event];
}

- (void)completeSnoozeLongPress {
	[self.class cancelPreviousPerformRequestsWithTarget:self selector:@selector(completeSnoozeLongPress) object:nil];
	
	if (!self.on) {
		NSLog(@"Detected completion of long press event, coloring for snooze...");
		
		self.backgroundColor = SNOOZE_COLOR; // ((UIView *)((UIView *)self.subviews[0]).subviews[0]).tintColor;
		self.layer.cornerRadius = 16.0;
		
		UIPanGestureRecognizer *pan = [self valueForKey:@"_panGesture"];
		pan.enabled = NO;
		
		NSArray *targets = [pan valueForKey:@"_targets"];
		for (UIGestureRecognizerTarget *target in targets) {
			[target performSelector:target->_action withObject:pan];
		}
		
		// [pan reset];
		// [self setValue:@(YES) forKey:@"_onStateChangedByPanGestureRecognizer"];
		// [self _animateToOn:NO withDuration:0.5 sendAction:NO];
		// [self _setPressed:YES on:NO animated:NO completion:nil];
		// [self _onAnimationDidStop:nil finished:nil context:NULL];
		pan.enabled = YES;

		objc_setAssociatedObject(self, &kSnoozeSwitchIgnoreKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		// Post notification to snooze the Alarm associated with this switch.
	}
}

-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
	NSLog(@"got action");
	BOOL shouldIgnore = [objc_getAssociatedObject(self, &kSnoozeSwitchIgnoreKey) boolValue];
	
	if (!shouldIgnore) {
		[super sendAction:action to:target forEvent:event];
		objc_setAssociatedObject(self, &kSnoozeSwitchIgnoreKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
}

@end
