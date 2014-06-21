//
//  TRAlarmView.m
//  Tranquil
//
//  Created by Julian Weiss on 6/21/14.
//  Copyright (c) 2014 insanj. All rights reserved.
//

#import "TRAlarmView.h"

@implementation TRAlarmView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
	
	if (self) {
        // Initialization code
    }
	
    return self;
}

- (void)setAlarm:(TRAlarm *)alarm {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setDateStyle:NSDateFormatterShortStyle];
	_timeLabel.text = [dateFormatter stringFromDate:alarm.nextFireDate];
	
	if (alarm.repeatingDays) {
		// _repeatingDaysLabel
	}
	
	_nameLabel.text = alarm.name;
	_activeSwitch.on = alarm.active;
}

@end
