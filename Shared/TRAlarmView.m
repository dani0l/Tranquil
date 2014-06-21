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
		CGFloat padding = 5.0;
		
		_timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 5.0, frame.size.width / 2.0, (frame.size.height / 2.0) - (padding * 2.0))];
		_timeLabel.numberOfLines = 1;
		_timeLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:20.0];
		_timeLabel.adjustsFontSizeToFitWidth = YES;
		_timeLabel.textColor = [UIColor colorWithWhite:0.75 alpha:0.75];
		[self addSubview:_timeLabel];
		
		// _repeatingDaysLabel
		
		CGRect nameLabelFrame = _timeLabel.frame;
		nameLabelFrame.origin.y += _timeLabel.frame.size.height + padding;
		
		_nameLabel = [[UILabel alloc] initWithFrame:nameLabelFrame];
		_nameLabel.numberOfLines = 1;
		_nameLabel.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:12.0];
		_nameLabel.textColor = [UIColor colorWithWhite:0.25 alpha:0.75];
		[self addSubview:_nameLabel];
		
		CGFloat activeSwitchSize = 50.0;
		_activeSwitch = [[TRSwitch alloc] initWithFrame:CGRectMake(frame.size.width - (activeSwitchSize + padding), _timeLabel.frame.origin.y, activeSwitchSize, activeSwitchSize)];
		[self addSubview:_activeSwitch];
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
