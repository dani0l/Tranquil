#import "SnoozeSwitchDemo.h"

%hook UISwitch

static char * kSnoozeSwitchIgnoreKey;

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"-touchesBegan on:%@, superview:%@", self, self.superview);

	if ([self.superview isKindOfClass:%c(AlarmView)]) {
		[self performSelector:@selector(completeSnoozeLongPress) withObject:nil afterDelay:SNOOZE_INTERVAL];
	}

	%orig();
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"-touchesEnded on:%@, superview:%@", self, self.superview);

	[self.class cancelPreviousPerformRequestsWithTarget:self selector:@selector(completeSnoozeLongPress) object:nil];
	if (self.on && [self.superview isKindOfClass:%c(AlarmView)]) {
		[self performSelector:@selector(resetSnoozeColor) withObject:nil afterDelay:0.1];
	}

	%orig();
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
	NSLog(@"-touchesCancelled on:%@, superview:%@", self, self.superview);
	
	[self.class cancelPreviousPerformRequestsWithTarget:self selector:@selector(completeSnoozeLongPress) object:nil];
	%orig();
}

%new - (void)resetSnoozeColor {
	self.backgroundColor = [UIColor clearColor];
	// Post notification to un-snooze the Alarm associated with this switch.
}

%new - (void)completeSnoozeLongPress {
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
		
		objc_setAssociatedObject(self, &kSnoozeSwitchIgnoreKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
		// Post notification to snooze the Alarm associated with this switch.
	}
}

-(void)sendAction:(SEL)action to:(id)target forEvent:(UIEvent *)event {
	BOOL shouldIgnore = [objc_getAssociatedObject(self, &kSnoozeSwitchIgnoreKey) boolValue];
	
	if (shouldIgnore) {
		NSLog(@"[SnoozeSwitchDemo] Detected that we should ignore action for event: %@", event);
		objc_setAssociatedObject(self, &kSnoozeSwitchIgnoreKey, nil, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}

	else {
		%orig();
	}
}

%end