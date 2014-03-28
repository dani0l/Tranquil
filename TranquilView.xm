//
//  TranquilView.m
//  Tranquil
//
//  Created by Julian Weiss <insanjmail@gmail.com> on 27.03.2014.
//  Copyright (c) 2014 Julian Weiss <insanjmail@gmail.com>. All rights reserved.
//

#import "TranquilView.h"

@interface TranquilView () {
    Alarm *_nextAlarm;
    AlarmView *_nextAlarmView;

    UIImageView *_backgroundImageView;
}

@end

@implementation TranquilView

#ifndef kCFCoreFoundationVersionNumber_iOS_7_0
#define kCFCoreFoundationVersionNumber_iOS_7_0 838.00
#endif

#define iOS7 (kCFCoreFoundationVersionNumber >= kCFCoreFoundationVersionNumber_iOS_7_0)

- (void)setBackgroundImage:(UIImage *)backgroundImage {
    if (backgroundImage) {
        if (!_backgroundImageView) {
            _backgroundImageView = [[UIImageView alloc] init];
            [self addSubview:_backgroundImageView];
        }

        _backgroundImageView.image = backgroundImage;
    }

    else {
        if (_backgroundImageView) {
            [_backgroundImageView removeFromSuperview];
            _backgroundImageView = nil;
        }
    }
}

// Load views to display in parent view (which is a child to ViewController)
- (void)loadFullView {
    _nextAlarm = [[%c(AlarmManager) sharedManager] nextAlarmForDate:[NSDate date] activeOnly:YES allowRepeating:YES];

    _nextAlarmView = [[%c(AlarmView) alloc] initWithFrame:self.bounds];

    // Time Label (10:30 AM)
    DigitalClockLabel *nextAlarmDigitalLabel = _nextAlarmView.timeLabel;
    [nextAlarmDigitalLabel setDate:_nextAlarm.nextFireDate];

    // Detail Label (Alarm, XXX XXX XXX)
    [_nextAlarmView setName:_nextAlarm.uiTitle andRepeatText:[_nextAlarm.repeatDays description] textColor:[UIColor colorWithRed:0.556863 green:0.556863 blue:0.576471 alpha:1]];

    // Enabled Switch (ON / OFF)
    [_nextAlarmView.enabledSwitch setOn:YES];

    // Add view to main widget view holder
    [self addSubview:_nextAlarmView];

    NSLog(@"[Tranquil] Created an AlarmView (%@) using the properties set in the next Alarm (%@). Our recursive view hierachy is currently: %@", _nextAlarmView, _nextAlarm, [_nextAlarmView recursiveDescription]);

/*
    DigitalClockLabel *nextAlarmDigitalLabel = [[%c(DigitalClockLabel) alloc] initWithFrame:CGRectMake(0.0, 0.0, _nextAlarmView.frame.size.width / 2.0, (3.0 * _nextAlarmView.frame.size.height) / 4.0)];

  NSString *days = [nextAlarm repeats] ? @"" : nil;
    if(days){
        NSArray *repeatDays = [nextAlarm repeatDays];
        for(int i = 0; i < repeatDays.count; i++){
            if(i < repeatDays.count - 1)
                days = [days stringByAppendingString:[NSString stringWithFormat:@"%@, ", repeatDays[i]]];

            else
                days = [days stringByAppendingString:repeatDays[i]];
        }
    }

    [nextAlarmView setName:MSHookIvar<NSString *>(nextAlarm, "_title") andRepeatText:days textColor:[UIColor colorWithWhite:0.9 alpha:0.9]];
    [[nextAlarmView timeLabel] setDate:[nextAlarm nextFireDate]];
    nextAlarmView.tag = 5451;

    CGRect expanded = cell.frame;
    expanded.size.height = CGRectGetHeight(expanded) + CGRectGetHeight(nextAlarmView.frame);
    [cell setFrame:expanded];
    [cell addSubview:nextAlarmView];
    [self addSubview:_alarmView];*/
}

// Layout views added in -loadFullView to fit the view properly
- (void)layoutSubviews {
    [super layoutSubviews];

    _nextAlarmView.frame = self.bounds;

    if (_backgroundImageView) {
        _backgroundImageView.frame = CGRectInset(self.bounds, 2.0f, 0.0f);
    }
}

// Unload views added in -loadFullView (which is called by ViewController)
- (void)dealloc {
    if (_backgroundImageView) {
        [_backgroundImageView removeFromSuperview];
		_backgroundImageView = nil;
    }

    [_nextAlarmView removeFromSuperview];
    _nextAlarmView = nil;
}

@end
