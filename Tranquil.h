#import <UIKit/UIKit.h>

@interface NSDistributedNotificationCenter : NSNotificationCenter
@end

@interface BBBulletin : NSObject
@property(nonatomic, retain) NSDate *date;
@property(nonatomic, retain) NSString *section;
@property(nonatomic, retain) NSString *title;
@property(nonatomic, retain) NSString *subtitle;
@property(nonatomic, retain) NSString *message;

@property(nonatomic, retain) NSString *publisherBulletinID;
@property(nonatomic, retain) NSString *sectionDisplayName;
@property(nonatomic, retain) NSString *sectionID;
@property(nonatomic, retain) NSString *recordID;
@end

@interface SBTodayViewController
-(void)commitInsertionOfSection:(id)section beforeSection:(id)section2;
-(void)commitInsertionOfBulletin:(id)bulletin beforeBulletin:(id)bulletin2 inSection:(id)section forFeed:(unsigned)feed;

-(void)commitReloadOfSections:(id)sections;
-(void)commitRemovalOfBulletin:(id)bulletin fromSection:(id)section;
-(void)commitRemovalOfSection:(id)section;
-(id)infoForBulletin:(id)bulletin inSection:(id)section;
-(id)infoForBulletinSection:(id)bulletinSection;
-(id)infoForWidgetSection:(id)widgetSection;
@end

@interface SBBBSectionInfo : NSObject
-(id)identifier;
@end

@interface SBBulletinListSection
@property(readonly, assign, nonatomic) NSArray *bulletins;
@property(copy, nonatomic) NSString *displayName;
@property(retain, nonatomic) UIImage *iconImage;
@property(retain, nonatomic) UIImage *largeIconImage;
@property(copy, nonatomic) NSString *sectionID;
@property(retain, nonatomic) id widget;
-(BOOL)isBulletinSection;
-(BOOL)isWidgetSection;
@end

@interface Alarm : NSObject {
    BOOL _allowsSnooze;
    unsigned int _daySetting;
    <AlarmDelegate> *_delegate;
    Alarm *_editingProxy;
    unsigned int _hour;
    NSString *_id;
    NSURL *_idUrl;
    NSDate *_lastModified;
    unsigned int _minute;
    UILocalNotification *_notification;
    BOOL _pretendActiveIfProxy;
    NSArray *_repeatDays;
    unsigned int _revision;
    NSMutableDictionary *_settings;
    NSString *_snapshotSound;
    int _snapshotSoundType;
    UILocalNotification *_snoozedNotification;
    NSString *_sound;
    int _soundType;
    NSString *_title;
    UILocalNotification *_weeklyNotifications[7];
}

@property(getter=isActive,readonly) BOOL active;
@property(readonly) NSString * alarmId;
@property(readonly) NSURL * alarmIdUrl;
@property BOOL allowsSnooze;
@property unsigned int daySetting;
@property <AlarmDelegate> * delegate;
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
@interface AlarmManager : NSObject {
    NSMutableArray *_alarms;
    NSString *_defaultSound;
    int _defaultSoundType;
    BOOL _dirty;
    BOOL invalidAlarmsDetected;
    NSDate *lastModified;
    NSMutableArray *logMessageList;
}

@property(readonly) NSArray * alarms;
@property(readonly) NSString * defaultSound;
@property(readonly) int defaultSoundType;
@property BOOL invalidAlarmsDetected;
@property(retain) NSDate * lastModified;
@property(retain) NSMutableArray * logMessageList;

+ (id)copyReadAlarmsFromPreferences;
+ (BOOL)discardOldVersion;
+ (BOOL)isAlarmNotification:(id)arg1;
+ (id)sharedManager;
+ (BOOL)upgrade;
+ (void)writeAlarmsToPreferences:(id)arg1;

- (void)addAlarm:(id)arg1 active:(BOOL)arg2;
- (id)alarmWithId:(id)arg1;
- (id)alarmWithIdUrl:(id)arg1;
- (id)alarms;
- (BOOL)checkIfAlarmsModified;
- (void)countAlarmsInAggregateDictionary;
- (void)dealloc;
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
- (id)nextAlarmForDate:(id)arg1 activeOnly:(BOOL)arg2 allowRepeating:(BOOL)arg3;
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

@interface AlarmView : UIView {
    UILabel *_detailLabel;
    UISwitch *_enabledSwitch;
    NSString *_name;
    NSString *_repeatText;
    int _style;
    DigitalClockLabel *_timeLabel;
}

@property(retain) UILabel * detailLabel;
@property(readonly) UISwitch * enabledSwitch;
@property(copy) NSString * name;
@property(copy) NSString * repeatText;
@property int style;
@property(readonly) DigitalClockLabel * timeLabel;

- (void)dealloc;
- (id)detailLabel;
- (id)enabledSwitch;
- (id)initWithFrame:(struct CGRect { struct CGPoint { float x_1_1_1; float x_1_1_2; } x1; struct CGSize { float x_2_1_1; float x_2_1_2; } x2; })arg1;
- (void)layoutSubviews;
- (id)name;
- (id)repeatText;
- (void)setDetailLabel:(id)arg1;
- (void)setName:(id)arg1 andRepeatText:(id)arg2 textColor:(id)arg3;
- (void)setName:(id)arg1;
- (void)setRepeatText:(id)arg1;
- (void)setStyle:(int)arg1;
- (int)style;
- (id)timeLabel;

@end