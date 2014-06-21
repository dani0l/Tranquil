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

+ (UILocalNotification *)nextAlarmNotification {
    return MSHookIvar<UILocalNotification *>([%c(SBClockDataProvider) sharedInstance], "_nextAlarmForToday");
}

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

    // We can pull the "next alarm" shown in the Notification Center by retrieving
    // the _nextAlarmForToday from SBClockDataProvider. I've put this into a nice
    // little method for external checking (which will allow for smart hiding).
    UILocalNotification *nextAlarmNotification = [self.class nextAlarmNotification];
    if (!nextAlarmNotification) {
        // TODO: add some placeholder view here or something, if we can't figure
        // out how to hide things.
        return;
    }

    _nextAlarm = [[Alarm alloc] initWithNotification:nextAlarmNotification];
    NSLog(@"[Tranquil] Pulled next alarm from provider: %@", _nextAlarm);

    // Now that we presumably have a valid Alarm instance, it's time to create
    // a standard view for it, and load it in with essential elements.
    _nextAlarmView = [[%c(AlarmView) alloc] initWithFrame:self.bounds];

    // Enabled Switch (always on by default)
    [_nextAlarmView.enabledSwitch setOn:YES];
    [_nextAlarmView.enabledSwitch addTarget:self action:@selector(switchStateChanged:) forControlEvents:UIControlEventValueChanged];

    // Time Label (10:30 AM)
    DigitalClockLabel *nextAlarmDigitalLabel = _nextAlarmView.timeLabel;
    nextAlarmDigitalLabel.textColor = [UIColor whiteColor];
    [nextAlarmDigitalLabel setDate:_nextAlarm.nextFireDate];

    // Some simple logic checks for the repeating text. Used to use some complex
    // binary conversion (see commit f447e92ebbdc046e61b00c49c51937d3f827309b
    // /TranquilView.xm#L89).
    NSString *repeatDaysText;
    NSUInteger repeatDaysBinary = _nextAlarm.daySetting;
    switch (repeatDaysBinary) {
        case 0:
        case 127:
            repeatDaysText = @"";
            break;
        case 1:
            repeatDaysText = @"Monday";
            break;
        case 2:
            repeatDaysText = @"Tuesday";
            break;
        case 4:
            repeatDaysText = @"Wednesday";
            break;
        case 8:
            repeatDaysText = @"Thursday";
            break;
        case 16:
            repeatDaysText = @"Friday";
            break;
        case 31:
            repeatDaysText = @"Weekdays";
            break;
        case 32:
            repeatDaysText = @"Saturday";
            break;
        case 64:
            repeatDaysText = @"Sunday";
            break;
        case 96:
            repeatDaysText = @"Weekends";
            break;
    //    case 127:                            // Strangely enough, this is the
    //        repeatDaysText = @"Every day";   // case for non-repeating as well...
    //        break;
        default:
            repeatDaysText = [self repeatDaysForArray:_nextAlarm.repeatDays];
            break;
    }

    // Detail Label (Alarm, xxx xxx xxx)
    UIColor *appleGrayAlarmColor = [UIColor colorWithRed:0.556863 green:0.556863 blue:0.576471 alpha:1];
    NSString *name = [[NSBundle bundleWithPath:@"/Applications/MobileTimer.app"] localizedStringForKey:_nextAlarm.uiTitle value:_nextAlarm.uiTitle table:@"Localizable"];

    [_nextAlarmView setName:name andRepeatText:repeatDaysText textColor:appleGrayAlarmColor];
    [_nextAlarmView detailLabel].textColor = appleGrayAlarmColor;

    [self addSubview:_nextAlarmView];
    NSLog(@"[Tranquil] Created an AlarmView (%@) using the properties set in the next Alarm (%@). Our recursive view hierachy is currently: %@", _nextAlarmView, _nextAlarm, [_nextAlarmView recursiveDescription]);
}

- (NSString *)repeatDaysForArray:(NSArray *)repeatDays {
    NSString *runningRepeatDays = @"";
    for (int i = 0; i < repeatDays.count; i++) {
        runningRepeatDays = [runningRepeatDays stringByAppendingString:@" "];
        switch ([repeatDays[i] intValue]) {
            case 0:
                runningRepeatDays = @"Sun";
                break;
            case 1:
                runningRepeatDays = [runningRepeatDays stringByAppendingString:@"Mon"];
                break;
            case 2:
                runningRepeatDays = [runningRepeatDays stringByAppendingString:@"Tue"];
                break;
            case 3:
                runningRepeatDays = [runningRepeatDays stringByAppendingString:@"Wed"];
                break;
            case 4:
                runningRepeatDays = [runningRepeatDays stringByAppendingString:@"Thu"];
                break;
            case 5:
                runningRepeatDays = [runningRepeatDays stringByAppendingString:@"Fri"];
                break;
            case 6:
                runningRepeatDays = [runningRepeatDays stringByAppendingString:@"Sat"];
                break;
        }
    }

    return runningRepeatDays;
}

- (void)switchStateChanged:(UISwitch *)sender {
    if (!sender.isOn) {
        SBClockDataProvider *provider = [%c(SBClockDataProvider) sharedInstance];
        BBDataProviderProxy *proxy = MSHookIvar<BBDataProviderProxy *>(provider, "_dataProviderProxy");
        [proxy withdrawBulletinsWithRecordID:@"NextTodayAlarm"];

        [_nextAlarm dropNotifications];
        [_nextAlarm refreshActiveState];
        [[%c(AlarmManager) sharedManager] handleAnyNotificationChanges];

// - (void)reloadScheduledNotificationsWithRefreshActive:(BOOL)arg1 cancelUnused:(BOOL)arg2;
//- (void)loadScheduledNotificationsWithCancelUnused:(BOOL)arg1;
//- (void)loadScheduledNotifications;
//- (void)handleAnyNotificationChanges;

    //  [provider _calculateNextTodayAlarmAndBulletinWithScheduledNotifications:nil];


        // id <AlarmDelegate> delegate = _nextAlarm.delegate;
        // [delegate alarmDidUpdate:_nextAlarm];
    /*
        SBApplicationClockLocalNotificationsUpdated
        scheduledLocalNotifications
        BBBulletinRequest *reschedule = [BBBulletinRequest alloc] init];
        [reschedule setSectionID:@"com.apple.mobiletimer"];
        [reschedule setRecordID:@"Alarm"];
        [reschedule setEndDate:[NSDate distantFuture]];
        [reschedule setPublisherBulletinID:[[%c(NSUUID) UUID] UUIDString]]; */

    // Alarm *next = [[Alarm alloc] initWithNotification:MSHookIvar<UILocalNotification *>(provider, "_nextAlarmForToday")];
    // [[AlarmManager sharedManager] updateAlarm:next active:NO];
    // [provider _publishAlarmsWithScheduledNotifications:MSHookIvar<UILocalNotification *>(provider, "_nextAlarmForToday")];

    //    [self loadFullView];
    }
}

// Layout views added in -loadFullView to fit the view properly
- (void)layoutSubviews {
    [super layoutSubviews];

    if (_backgroundImageView) {
        _backgroundImageView.frame = CGRectInset(self.bounds, 2.0f, 0.0f);
    }
}

// User pressed down with finger on widget...
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    _touchDown = YES;
    self.backgroundColor = [%c(SBNotificationCenterViewController) grayControlInteractionTintColor];
    // ^ SpringBoard's reference to the low-opacity touch-down color ("UIDeviceWhiteColorSpace 1 0.15")
}

// User lifted up with finger on widget...
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_touchDown) {
        _touchDown = NO;
        self.backgroundColor = [UIColor clearColor];

        // Private URL (maybe used for inter-app business):
        // NSURL *launchURL = _nextAlarm ? _nextAlarm.alarmIdUrl : [NSURL URLWithString:@"x-apple-clock:"];
        NSLog(@"[Tranquil] Detected tap on widget, launching MobileTimer to second tab...");
        [(SpringBoard *)[UIApplication sharedApplication] applicationOpenURL:[%c(ClockManager) urlForClockAppSection:1] publicURLsOnly:NO];
    }
}

// User slid away from widget (or some other manner of preventing tap up)...
- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    if (_touchDown) {
        _touchDown = NO;
        self.backgroundColor = [UIColor clearColor];
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
