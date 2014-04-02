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

    BOOL _touchDown;
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

// Load views to display in parent view (which is a child to ViewController),
// called manually from TranquilViewControllerNew.
- (void)loadFullView {

    // Since this method is called every time the NC is revealed, we should clean
    // up after ourselves (ARC prevents a lot of garbage).
    if (_nextAlarmView) {
        _nextAlarm = nil;
        [_nextAlarmView removeFromSuperview];
    }

    /*UIActivityIndicatorView *spinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    [spinner startAnimating];
    spinner.center = self.center;
    [self addSubview:spinner];*/

    //CFPreferencesAppSynchronize(CFSTR("com.apple.mobiletimer"));
    //AlarmManager *manager = [%c(AlarmManager) sharedManager];
    //[manager loadAlarms];

    // Instead of reverting a bunch of times to use my nextAlarm algorithm, we
    // can use this to pull actually valid information (which it won't do by
    // default, since all alarms are marked inactive in preferences) by either
    // finding the valid prefs, and using YES for activeOnly:, or just by
    // checking isActive status somewhere, and cycling by adding a millisecond
    // to the ForDate: argument.
//    _nextAlarm = [manager nextAlarmForDate:[NSDate date] activeOnly:NO allowRepeating:YES];
    UILocalNotification *nextAlarmNotification = MSHookIvar<UILocalNotification *>([%c(SBClockDataProvider) sharedInstance], "_nextAlarmForToday");
    if (!nextAlarmNotification) {
        return;
    }

    _nextAlarm = [[Alarm alloc] initWithNotification:nextAlarmNotification];
    NSLog(@"[Tranquil] Pulled next alarm from provider: %@", _nextAlarm);
    //NSLog(@"[Tranquil / DEBUG] Out of all read alarms:%@, it was decided %@ was most valid...", manager.alarms, _nextAlarm);

    // Now that we presumably have a valid Alarm instance, it's time to create
    // a standard view for it, and load it in with essential elements.
    _nextAlarmView = [[%c(AlarmView) alloc] initWithFrame:self.bounds];

    [_nextAlarmView.enabledSwitch setOn:_nextAlarm.isActive];
    [_nextAlarmView.enabledSwitch addTarget:self action:@selector(switchStateChanged:) forControlEvents:UIControlEventValueChanged];

    // Time Label (10:30 AM)
    DigitalClockLabel *nextAlarmDigitalLabel = _nextAlarmView.timeLabel;
    nextAlarmDigitalLabel.textColor = [UIColor whiteColor];
    [nextAlarmDigitalLabel setDate:_nextAlarm.nextFireDate];

    // The Alarm class doesn't give us any handy way to convert weekdays to the
    // casual text used in each AlarmView. This is pretty simple to reverse, however
    // using the daySetting property of every Alarm. Using some simple cycript
    // inspections, I was able to discover that EVERY day is represented by
    // it's corresponding power of two. So:
    //    Monday = (technical) 1st day of week = 2 ^ 0
    // Which also corresponds to its repeatingDays, which is just a list of
    // NSNumbers that are the day's day-of-week, as well as power of two:
    //    Tuesday = @[2] = 2 ^ 1 = 2
    // This pattern continues clearly for every day of the week:
    // daySetting = 0 = None
    //            = 1 = Every Monday = @[1]
    //            = 2 = Every Tuesday = @[2]
    //            = 4 = Every Wednesday = @[3]
    //            = 8 = Every Thursday = @[4]
    //            = 16 = Every Friday = @[5]
    //            = 32 = Every Saturday = @[6]
    //            = 64 = Every Sunday = @[0]
    // And translates directly into the sets of repeating days. So, for weekdays,
    // the daySetting value is (for repeatingDays @[1,2,3,4,5]):
    //    Monday + Tuesday + Wednesday + Thursday + Friday
    //    2 ^ 0  + 2 ^ 1   + 2 ^ 2     + 2 ^ 3    + 2 ^ 4   = 31
    // And so forth...
    //            = 31 = Weekdays = @[1,2,3,4,5]
    //            = 96 = Weekends = @[0, 6]
    //            = 127 = Every day = @[0,1,2,3,4,5,6]
    // In order to separate every day, it's simply a process of reducing this
    // great big number into its smaller, fitting parts:
    //    123 = 2^0+2^1+2^3+2^4+2^5+2^6 = Mon Tue Thu Fri Sat Sun
    // It's just binary conversion from there on!
    NSString *dayText;
    NSUInteger decimalDays = [_nextAlarm daySetting];
    switch (decimalDays) {
        case 0:
            dayText = @"";
            break;
        case 1:
            dayText = @"Monday";
            break;
        case 2:
            dayText = @"Tuesday";
            break;
        case 4:
            dayText = @"Wednesday";
            break;
        case 8:
            dayText = @"Thursday";
            break;
        case 16:
            dayText = @"Friday";
            break;
        case 31:
            dayText = @"Weekdays";
            break;
        case 32:
            dayText = @"Saturday";
            break;
        case 64:
            dayText = @"Sunday";
            break;
        case 96:
            dayText = @"Weekends";
            break;
        case 127:
            dayText = @"Every day";
            break;
        default:
            dayText = [self dayTextFromDecimalDays:decimalDays];
            break;
    }

    // Detail Label (Alarm, xxx xxx xxx)
    UIColor *appleGrayAlarmColor = [UIColor colorWithRed:0.556863 green:0.556863 blue:0.576471 alpha:1];
    NSString *name = [[NSBundle bundleWithPath:@"/Applications/MobileTimer.app"] localizedStringForKey:_nextAlarm.uiTitle value:_nextAlarm.uiTitle table:@"Localizable"];

    [_nextAlarmView setName:name andRepeatText:dayText textColor:appleGrayAlarmColor];
    [_nextAlarmView detailLabel].textColor = appleGrayAlarmColor;

    // Add view to main widget view holder
    // [spinner removeFromSuperview];
    [self addSubview:_nextAlarmView];

    NSLog(@"[Tranquil] Created an AlarmView (%@) using the properties set in the next Alarm (%@). Our recursive view hierachy is currently: %@", _nextAlarmView, _nextAlarm, [_nextAlarmView recursiveDescription]);
}

- (NSString *)dayTextFromDecimalDays:(NSUInteger)decimal {
    NSUInteger binaryDays = decimal;
    NSString *binaryString = @"";
    for (int i = 0; binaryDays > 0; i++) {
        binaryString = [NSString stringWithFormat:@"%u%@", (unsigned int) binaryDays&1, binaryString];
        binaryDays = binaryDays >> 1;
    }

    NSMutableArray *repeatDays = [[NSMutableArray alloc] init];
    [binaryString enumerateSubstringsInRange:NSMakeRange(0, [binaryString length]) options:(NSStringEnumerationByComposedCharacterSequences) usingBlock:^(NSString *substring, NSRange substringRange, NSRange enclosingRange, BOOL *stop) {
        if ([substring boolValue]) {
            [repeatDays addObject:@(pow(2, [binaryString length] - (substringRange.location + 1)))];
        }
    }];

    NSString *dayDays = @"";
    for (int i = 0; i < repeatDays.count; i++) {
        dayDays = [dayDays stringByAppendingString:@" "];
        int day = [repeatDays[i] intValue];
        switch (day) {
            case 1:
                dayDays = @"Mon";
                break;
            case 2:
                dayDays = [dayDays stringByAppendingString:@"Tue"];
                break;
            case 4:
                dayDays = [dayDays stringByAppendingString:@"Wed"];
                break;
            case 8:
                dayDays = [dayDays stringByAppendingString:@"Thu"];
                break;
            case 16:
                dayDays = [dayDays stringByAppendingString:@"Fri"];
                break;
            case 32:
                dayDays = [dayDays stringByAppendingString:@"Sat"];
                break;
            case 64:
                dayDays = [dayDays stringByAppendingString:@"Sun"];
                break;
        }
    }

    return dayDays;
}

- (void)switchStateChanged:(UISwitch *)sender {
    if (!sender.isOn) {
        // TODO: make this actually take effect in the MT app and all that
        SBClockDataProvider *provider = [%c(SBClockDataProvider) sharedInstance];
        Alarm *next = [[Alarm alloc] initWithNotification:MSHookIvar<UILocalNotification *>(provider, "_nextAlarmForToday")];
        [[AlarmManager sharedManager] updateAlarm:next active:NO];
        [provider _calculateNextTodayAlarmAndBulletinWithScheduledNotifications:nil];
        [provider _publishAlarmsWithScheduledNotifications:MSHookIvar<UILocalNotification *>(provider, "_nextAlarmForToday")];

        [self loadFullView];
    }
}

// Layout views added in -loadFullView to fit the view properly
- (void)layoutSubviews {
    [super layoutSubviews];

    _nextAlarmView.frame = _nextAlarm ? self.bounds : CGRectMake(0.0, 0.0, _nextAlarmView.frame.size.width, 1.0);

    if (_backgroundImageView) {
        _backgroundImageView.frame = CGRectInset(self.bounds, 2.0f, 0.0f);
    }
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _touchDown = YES;
    self.backgroundColor = [UIColor darkGrayColor];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {

    // Should launch Clock app to alarm presented in NC using the private
    // alarmIDUrl set in the Alarm class.
    if (_touchDown) {
        self.backgroundColor = [UIColor clearColor];
        NSURL *launchURL = _nextAlarm ? _nextAlarm.alarmIdUrl : [NSURL URLWithString:@"x-apple-clock:"];
        NSLog(@"[Tranquil] Detected tap on widget, url to launch is: %@", launchURL);
        [(SpringBoard *)[UIApplication sharedApplication] applicationOpenURL:[%c(ClockManager) urlForClockAppSection:1] publicURLsOnly:NO];
        // [(SpringBoard *)[UIApplication sharedApplication] applicationOpenURL:[%c(ClockManager) urlForClockAppSection:[%c(ClockManager) sectionFromClockAppURL:launchURL]] publicURLsOnly:NO];
        _touchDown = NO;
    }
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_touchDown) {
        self.backgroundColor = [UIColor clearColor];
        _touchDown = NO;
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
