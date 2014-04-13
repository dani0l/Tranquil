
// Let's define what an "Alarm is..."
@interface Alarm : NSObject
@property(getter=isActive,readonly) BOOL active;
@property(readonly) NSString * alarmId;
@property(readonly) NSURL * alarmIdUrl;
@property BOOL allowsSnooze;
@property unsigned int daySetting;
@property id delegate;
@property(readonly) Alarm * editingProxy;
@property unsigned int hour;
@property(readonly) NSDate * lastModified;
@property unsigned int minute;
@property(readonly) NSString * rawTitle;
@property(readonly) NSArray * repeatDays;
@property(readonly) BOOL repeats;
@property(readonly) unsigned int revision;
@property(readonly) NSDictionary * settings;
@property(readonly) NSString * snapshotSound;
@property(readonly) int snapshotSoundType;
@property(getter=isSnoozed,readonly) BOOL snoozed;
@property(readonly) NSString * sound;
@property(readonly) int soundType;
@property(readonly) NSString * uiTitle;

+ (id)_newSettingsFromNotification:(id)arg1;
+ (BOOL)_verifyNotificationSettings:(id)arg1 againstAlarmSettings:(id)arg2;
+ (BOOL)_verifyNotificationSettings:(id)arg1 againstUserInfo:(id)arg2;
+ (BOOL)isSnoozeNotification:(id)arg1;
+ (BOOL)verifyDaySetting:(id)arg1 withMessageList:(id)arg2;
+ (BOOL)verifyHourSetting:(id)arg1 withMessageList:(id)arg2;
+ (BOOL)verifyIdSetting:(id)arg1 withMessageList:(id)arg2;
+ (BOOL)verifyMinuteSetting:(id)arg1 withMessageList:(id)arg2;
+ (BOOL)verifySettings:(id)arg1;

- (id)_newBaseDateComponentsForDay:(int)arg1;
- (id)_newNotification:(int)arg1;
- (unsigned int)_notificationsCount;
- (id)alarmId;
- (id)alarmIdUrl;
- (BOOL)allowsSnooze;
- (void)applyChangesFromEditingProxy;
- (void)applySettings:(id)arg1;
- (void)cancelNotifications;
- (int)compareTime:(id)arg1;
- (unsigned int)daySetting;
- (void)dealloc;
- (id)debugDescription;
- (id)delegate;
- (id)description;
- (void)dropEditingProxy;
- (void)dropNotifications;
- (id)editingProxy;
- (void)handleAlarmFired:(id)arg1;
- (void)handleNotificationSnoozed:(id)arg1 notifyDelegate:(BOOL)arg2;
- (unsigned int)hash;
- (unsigned int)hour;
- (id)init;
- (id)initWithDefaultValues;
- (id)initWithNotification:(id)arg1;
- (id)initWithSettings:(id)arg1;
- (BOOL)isActive;
- (BOOL)isEqual:(id)arg1;
- (BOOL)isSnoozed;
- (id)lastModified;
- (void)markModified;
- (unsigned int)minute;
- (id)nextFireDate;
- (id)nextFireDateAfterDate:(id)arg1 notification:(id)arg2 day:(int)arg3;
- (id)nowDateForOffsetCalculation;
- (void)prepareEditingProxy;
- (void)prepareNotifications;
- (id)rawTitle;
- (void)refreshActiveState;
- (id)repeatDays;
- (BOOL)repeats;
- (unsigned int)revision;
- (void)scheduleNotifications;
- (void)setAllowsSnooze:(BOOL)arg1;
- (void)setDaySetting:(unsigned int)arg1;
- (void)setDelegate:(id)arg1;
- (void)setHour:(unsigned int)arg1;
- (void)setMinute:(unsigned int)arg1;
- (void)setSound:(id)arg1 ofType:(int)arg2;
- (void)setTitle:(id)arg1;
- (id)settings;
- (id)snapshotSound;
- (int)snapshotSoundType;
- (id)sound;
- (int)soundType;
- (id)timeZoneForOffsetCalculation;
- (BOOL)tryAddNotification:(id)arg1;
- (id)uiTitle;
@end

@protocol AlarmDelegate
- (void)alarmDidUpdate:(Alarm *)arg1;
@end



@interface BBDataProviderProxy : NSObject
@property(copy) NSString *sectionID;

- (void)_makeClientRequest:(id)arg1;
- (void)_makeServerRequest:(id)arg1;
- (void)_processPendingRequests;
- (void)_queue_makeServerRequest:(id)arg1;
- (id)_serverProxy;
- (void)_updateIdentity:(id)arg1;
- (void)addBulletin:(id)arg1 forDestinations:(unsigned int)arg2;
- (void)addBulletin:(id)arg1 interrupt:(BOOL)arg2;
- (void)attachmentAspectRatioForRecordID:(id)arg1 completion:(id)arg2;
- (void)attachmentPNGDataForRecordID:(id)arg1 sizeConstraints:(id)arg2 completion:(id)arg3;
- (void)bulletinsWithRequestParameters:(id)arg1 lastCleared:(id)arg2 completion:(id)arg3;
- (void)clearedInfoAndBulletinsForClearingAllBulletinsWithLimit:(id)arg1 lastClearedInfo:(id)arg2 completion:(id)arg3;
- (void)clearedInfoForBulletins:(id)arg1 lastClearedInfo:(id)arg2 completion:(id)arg3;
- (void)connection:(id)arg1 connectionStateDidChange:(BOOL)arg2;
- (id)dataProvider;
- (void)dataProviderDidLoad;
- (void)dealloc;
- (void)deliverBulletinActionResponse:(id)arg1;
- (void)deliverMessageWithName:(id)arg1 userInfo:(id)arg2;
- (id)description;
- (id)identity;
- (id)initWithDataProvider:(id)arg1 identity:(id)arg2 queue:(id)arg3 dataProviderQueue:(id)arg4;
- (void)invalidate;
- (void)invalidateBulletins;
- (void)modifyBulletin:(id)arg1;
- (void)noteSectionInfoDidChange:(id)arg1;
- (void)ping:(id)arg1;
- (id)proxy:(id)arg1 detailedSignatureForSelector:(SEL)arg2;
- (void)reloadDefaultSectionInfo;
- (void)reloadSectionParameters;
- (void)resume;
- (NSString *)sectionID;
- (void)sectionIdentityWithCompletion:(id)arg1;
- (void)setConnection:(id)arg1;
- (void)setDataProvider:(id)arg1;
- (void)setIdentity:(id)arg1;
- (void)setSectionID:(NSString *)arg1;
- (void)updateClearedInfoWithHandler:(id)arg1;
- (void)updateSectionInfoWithHandler:(id)arg1;
- (void)withdrawBulletinWithPublisherBulletinID:(id)arg1;
- (void)withdrawBulletinsWithRecordID:(id)arg1;
@end


// Now, let's pull the next possible Alarm from the persistant Manager...
@interface SBClockDataProvider {
	BBDataProviderProxy *_dataProviderProxy; //asdfjaslkdfj
	UILocalNotification *_nextAlarmForToday;
	UILocalNotification *_firstAlarmForTomorrow;
	NSDate *_nextTomorrowFireDate;
}

+ (id)sharedInstance;
- (void)_calculateNextTodayAlarmAndBulletinWithScheduledNotifications:(id)scheduledNotifications;
- (void)_publishAlarmsWithScheduledNotifications:(id)scheduledNotifications;

@end

@interface AlarmManager : NSObject

+ (id)copyReadAlarmsFromPreferences;
+ (BOOL)discardOldVersion;
+ (BOOL)isAlarmNotification:(id)arg1;
+ (id)sharedManager;
+ (BOOL)upgrade;
+ (void)writeAlarmsToPreferences:(id)arg1;

- (void)addAlarm:(id)arg1 active:(BOOL)arg2;
- (Alarm *)alarmWithId:(id)arg1;
- (Alarm *)alarmWithIdUrl:(id)arg1;
- (NSArray *)alarms;
- (BOOL)checkIfAlarmsModified;
- (void)countAlarmsInAggregateDictionary;
- (id)defaultSound;
- (int)defaultSoundType;
- (void)handleAlarm:(id)arg1 startedUsingSong:(id)arg2;
- (void)handleAlarm:(id)arg1 stoppedUsingSong:(id)arg2;
- (void)handleAnyNotificationChanges;
- (void)handleExpiredOrSnoozedNotificationsOnly:(id)arg1;
- (void)handleNotificationFired:(id)arg1;
- (void)handleNotificationSnoozed:(id)arg1;
- (id)init;
- (BOOL)invalidAlarmsDetected;
- (id)lastModified;
- (void)loadAlarms;
- (void)loadDefaultSoundAndType;
- (void)loadScheduledNotifications;
- (void)loadScheduledNotificationsWithCancelUnused:(BOOL)arg1;
- (id)logMessageList;
- (id)nextAlarmForDate:(id)arg1 activeOnly:(BOOL)arg2 allowRepeating:(BOOL)arg3; // Bingo!
- (void)reloadScheduledNotifications;
- (void)reloadScheduledNotificationsWithRefreshActive:(BOOL)arg1 cancelUnused:(BOOL)arg2;
- (void)removeAlarm:(id)arg1;
- (void)saveAlarms;
- (void)setAlarm:(id)arg1 active:(BOOL)arg2;
- (void)setDefaultSound:(id)arg1 ofType:(int)arg2;
- (void)setInvalidAlarmsDetected:(BOOL)arg1;
- (void)setLastModified:(id)arg1;
- (void)setLogMessageList:(id)arg1;
- (void)unloadAlarms;
- (void)updateAlarm:(id)arg1 active:(BOOL)arg2;

@end

// Now that we can extract a valid Alarm from the AlarmManager, let's find a view
// to pop it into...
@interface AlarmView : UIView {
    UILabel *_detailLabel;			// Label that holds name and repeat text. ("Alarm, Mon Fri")
    UISwitch *_enabledSwitch;	 	// Will always be on when first viewing, presumably (plain UISwitch).
    NSString *_name;			  	// User-set name, presumably. Use uiTitle or rawTitle ("Alarm").
    NSString *_repeatText;			// What would appear next to the name, manually calculated ("Mon Fri").
    int _style;					   // Not sure if there are style presets... seems to mostly be a zero (0).
    NSObject *_timeLabel;				   // Our big beautiful time, from UIDateLabel (DigitalClockLabel, "9:00").
}

// Hierarchy goes like this:
// timeLabel -- <DigitalClockLabel: 0x12f52ceb0; baseClass = UIDateLabel; frame = (15 4; 149 58); text = '10:30'; clipsToBounds = YES; opaque = NO; userInteractionEnabled = NO; layer = <CALayer: 0x17022a020>>
// detailLabel -- <UILabel: 0x12f52d990; frame = (15 58.5; 40 18); text = 'Alarm'; clipsToBounds = YES; userInteractionEnabled = NO; layer = <CALayer: 0x17022a100>>
// enabledSwitch -- <UISwitch: 0x12f52c910; frame = (254 30; 51 31); layer = <CALayer: 0x17022a0e0>>

- (UILabel *)detailLabel;
// font -- <UICTFont: 0x12f5389e0> font-family: ".HelveticaNeueInterface-M3"; font-weight: normal; font-style: normal; font-size: 15.00pt
// textColor -- UIDeviceRGBColorSpace 0.556863 0.556863 0.576471 1

- (UISwitch *)enabledSwitch;
- (id)initWithFrame:(CGRect)arg1; 	// Frame of NC widget. Default is (0 0; 320 90.5).
- (NSString *)name;
- (NSString *)repeatText;
- (void)setDetailLabel:(id)arg1;
- (void)setName:(id)arg1 andRepeatText:(id)arg2 textColor:(id)arg3;
- (void)setName:(id)arg1;
- (void)setRepeatText:(id)arg1;
- (void)setStyle:(int)arg1;
- (int)style;
- (id)timeLabel; 					// Don't forget we're a DigitalClockLabel.

@end

// Oh, as a sidenote, it might be nice to have this method accessible...
@interface UIView (Private)
- (NSString *)recursiveDescription;
@end

// Ah, but we don't know what a DigitalClockLabel is. Let's follow the trail...
// Parent class exists in UIKit under this nice name:
@interface UIDateLabel : UILabel

+ (id)_dateFormatter;
+ (id)_relativeDateFormatter;
+ (id)_timeFormatWithoutDesignator;
+ (id)_timeOnlyDateFormatter;
+ (id)_weekdayDateFormatter;
+ (id)amString;
+ (id)defaultFont;
+ (id)pmString;

- (id)_calendar;
- (id)_dateString;
- (id)_dateWithDayDiffFromToday:(int)arg1;
- (void)_didUpdateDate;
- (double)_lastWeek;
- (double)_noon;
- (void)_recomputeTextIfNecessary;
- (id)_stringDrawingContext;
- (double)_today;
- (id)_todayDate;
- (double)_tomorrow;
- (double)_yesterday;
- (BOOL)boldForAllLocales;
- (id)date;
- (void)dealloc;
- (void)drawRect:(CGRect)arg1;
- (void)drawTextInRect:(CGRect)arg1;
- (id)font;
- (BOOL)forceTimeOnly;
- (id)initWithFrame:(CGRect)arg1;
- (void)invalidate;
- (float)paddingFromTimeToDesignator;
- (void)setBoldForAllLocales:(BOOL)arg1;
- (void)setDate:(id)arg1;		 // Beautiful method for pretty much half of the AlarmView!
- (void)setForceTimeOnly:(BOOL)arg1;
- (void)setPaddingFromTimeToDesignator:(float)arg1;
- (void)setShouldRecomputeText:(BOOL)arg1;
- (void)setTimeInterval:(double)arg1;
- (BOOL)shouldRecomputeText;
- (CGSize)sizeThatFits:(CGSize)arg1;
- (id)text;
- (id)timeDesignator;
- (BOOL)timeDesignatorAppearsBeforeTime;
- (id)timeDesignatorFont;
- (CGSize)timeDesignatorSize;
- (double)timeInterval;
- (BOOL)use24HourTime;

@end

// Our second, even more wonderfully name class...
@interface ShrinkableDateLabel : UIDateLabel

- (void)setTimeDesignatorFont:(UIFont *)arg1;
- (void)shrinkFontsToFitWidth:(float)arg1;
- (UIFont *)timeDesignatorFont;

@end

// And finally, the golden goose.
@interface DigitalClockLabel : ShrinkableDateLabel {
    NSDate *_baseDate;
    NSCalendar *_calendar;
    int _hour;
    int _minute;
}

- (void)dealloc;
- (void)forceSetHour:(int)arg1 minute:(int)arg2;
- (id)initWithFrame:(CGRect)arg1;
- (void)refreshUI;
- (void)resetFontSizes;
- (BOOL)setHour:(int)arg1 minute:(int)arg2;
- (void)significantTimeChange:(id)arg1;

@end

// For launching on taps...
@interface ClockManager : NSObject
+ (int)sectionFromClockAppURL:(id)arg1;
+ (id)urlForClockAppSection:(int)arg1;
@end

@interface SpringBoard : UIApplication
-(void)applicationOpenURL:(id)url publicURLsOnly:(BOOL)only;
-(void)_applicationOpenURL:(id)url withApplication:(id)application sender:(id)sender publicURLsOnly:(BOOL)only animating:(BOOL)animating additionalActivationFlags:(id)flags activationHandler:(id)handler;
@end

// For the tap-down color
@interface SBNotificationCenterViewController
+ (id)grayControlInteractionTintColor;
@end
