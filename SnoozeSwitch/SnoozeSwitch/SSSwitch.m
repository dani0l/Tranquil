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

@implementation SSSwitch

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	[self performSelector:@selector(completeSnoozeLongPress) withObject:nil afterDelay:SNOOZE_INTERVAL];
	[super touchesBegan:touches withEvent:event];
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
	// Post notification to un-snooze the Alarm associated with this switch.
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	[self.class cancelPreviousPerformRequestsWithTarget:self selector:@selector(completeSnoozeLongPress) object:nil];
	[super touchesCancelled:touches withEvent:event];
}

- (void)completeSnoozeLongPress {
	if (self.on) {
		NSLog(@"Detected completion of long press event, coloring for snooze...");
		
		self.backgroundColor = SNOOZE_COLOR; // ((UIView *)((UIView *)self.subviews[0]).subviews[0]).tintColor;
		self.layer.cornerRadius = 16.0;
		
		UIView *confirmationPulse = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, 10.0, 10.0)];
		confirmationPulse.backgroundColor = SNOOZE_COLOR;
		confirmationPulse.center = self.center;
		confirmationPulse.alpha = 0.5;

		confirmationPulse.layer.cornerRadius = confirmationPulse.frame.size.height / 2.0;
		confirmationPulse.layer.masksToBounds = YES;
		
		[self.superview insertSubview:confirmationPulse belowSubview:self];
				
		[UIView animateWithDuration:0.5 animations:^(void){
			[confirmationPulse setTransform:CGAffineTransformMakeScale(25.0, 25.0)];
			confirmationPulse.alpha = 0.0;
		} completion:^(BOOL finished) {
			[confirmationPulse removeFromSuperview];
		}];
		
		// Post notification to snooze the Alarm associated with this switch.
	}
}

@end
