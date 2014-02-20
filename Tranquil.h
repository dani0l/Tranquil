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

@interface SBTodayViewController : UIViewController
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

@interface Alarm : NSObject

-(id)alarmId;
-(id)alarmIdUrl;
-(void)applySettings:(id)arg1;
-(void)cancelNotifications;
-(id)delegate;
-(void)dropNotifications;
-(unsigned int)hour;
-(id)init;
-(id)initWithDefaultValues;
-(id)initWithNotification:(id)arg1;
-(id)initWithSettings:(id)arg1;
-(BOOL)isActive;
-(BOOL)isSnoozed;
-(unsigned int)minute;
-(id)nextFireDate;
-(id)nextFireDateAfterDate:(id)arg1 notification:(id)arg2 day:(int)arg3;
-(id)rawTitle;
-(void)refreshActiveState;
-(id)repeatDays;
-(BOOL)repeats;
-(unsigned int)revision;
-(void)scheduleNotifications;
-(void)setAllowsSnooze:(BOOL)arg1;
-(void)setDaySetting:(unsigned int)arg1;
-(void)setDelegate:(id)arg1;
-(void)setHour:(unsigned int)arg1;
-(void)setMinute:(unsigned int)arg1;
-(void)setSound:(id)arg1 ofType:(int)arg2;
-(void)setTitle:(id)arg1;
-(id)settings;
-(id)snapshotSound;
-(int)snapshotSoundType;
-(id)sound;
-(int)soundType;
-(id)uiTitle;
@end

@interface AlarmManager : NSObject

@property(readonly) NSArray *alarms;
@property(readonly) NSString *defaultSound;
@property(readonly) int defaultSoundType;
@property BOOL invalidAlarmsDetected;
@property(retain) NSDate *lastModified;
@property(retain) NSMutableArray *logMessageList;

+(id)copyReadAlarmsFromPreferences;
+(BOOL)discardOldVersion;
+(BOOL)isAlarmNotification:(id)arg1;
+(id)sharedManager;
+(BOOL)upgrade;
+(void)writeAlarmsToPreferences:(id)arg1;

-(void)addAlarm:(id)arg1 active:(BOOL)arg2;
-(id)alarmWithId:(id)arg1;
-(id)alarmWithIdUrl:(id)arg1;
-(id)alarms;
-(BOOL)checkIfAlarmsModified;
-(void)countAlarmsInAggregateDictionary;
-(void)dealloc;
-(id)defaultSound;
-(int)defaultSoundType;
-(void)handleAlarm:(id)arg1 startedUsingSong:(id)arg2;
-(void)handleAlarm:(id)arg1 stoppedUsingSong:(id)arg2;
-(void)handleAnyNotificationChanges;
-(void)handleExpiredOrSnoozedNotificationsOnly:(id)arg1;
-(void)handleNotificationFired:(id)arg1;
-(void)handleNotificationSnoozed:(id)arg1;
-(id)init;
-(BOOL)invalidAlarmsDetected;
-(id)lastModified;
-(void)loadAlarms;
-(void)loadDefaultSoundAndType;
-(void)loadScheduledNotifications;
-(void)loadScheduledNotificationsWithCancelUnused:(BOOL)arg1;
-(id)logMessageList;
-(id)nextAlarmForDate:(id)arg1 activeOnly:(BOOL)arg2 allowRepeating:(BOOL)arg3;
-(void)reloadScheduledNotifications;
-(void)reloadScheduledNotificationsWithRefreshActive:(BOOL)arg1 cancelUnused:(BOOL)arg2;
-(void)removeAlarm:(id)arg1;
-(void)saveAlarms;
-(void)setAlarm:(id)arg1 active:(BOOL)arg2;
-(void)setDefaultSound:(id)arg1 ofType:(int)arg2;
-(void)setInvalidAlarmsDetected:(BOOL)arg1;
-(void)setLastModified:(id)arg1;
-(void)setLogMessageList:(id)arg1;
-(void)unloadAlarms;
-(void)updateAlarm:(id)arg1 active:(BOOL)arg2;
@end

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

@interface AlarmView : UIView {
    UILabel *_detailLabel;
    UISwitch *_enabledSwitch;
    NSString *_name;
    NSString *_repeatText;
    int _style;
}

@property(retain) UILabel *detailLabel;
@property(readonly) UISwitch *enabledSwitch;
@property(copy) NSString *name;
@property(copy) NSString *repeatText;
@property int style;
@property(readonly) DigitalClockLabel *timeLabel;

-(void)dealloc;
-(UILabel *)detailLabel;
-(UISwitch *)enabledSwitch;
-(id)initWithFrame:(CGRect)arg1;
-(void)layoutSubviews;
-(NSString *)name;
-(NSString *)repeatText;
-(void)setDetailLabel:(UILabel *)arg1;
-(void)setName:(NSString *)arg1 andRepeatText:(NSString *)arg2 textColor:(UIColor *)arg3;
-(void)setName:(NSString *)arg1;
-(void)setRepeatText:(NSString *)arg1;
-(void)setStyle:(int)arg1;
-(int)style;
-(DigitalClockLabel *)timeLabel;
@end