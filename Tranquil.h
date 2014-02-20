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

@interface SBBulletinObserverViewController : UIViewController {
	// BBObserver *_observer;
	id _delegate;
	// id<SBWidgetViewControllerHostDelegate> _widgetDelegate;
	NSMutableArray *_requestQueue;
	NSMutableDictionary *_enabledSectionInfosByID;
	NSMutableArray *_visibleSectionIDs;
	NSMutableDictionary *_bulletinIDsByFeed;
	// SBBulletinViewController *_bulletinViewController;
	int _sectionOrderRule;
	int _supportedCategory;
	NSArray *_sectionOrder;
	NSMutableArray *_makeshiftSectionOrder;
	int _requestHandlingDisabledCount;
	struct {
		unsigned suppliesInsertionAnimation : 1;
		unsigned suppliesRemovalAnimation : 1;
		unsigned suppliesReplacementAnimation : 1;
		unsigned decidesHighlight : 1;
		unsigned interestedInSelection : 1;
	} _bulletinObserverViewControllerFlags;
}
// @property(readonly, assign, nonatomic) SBBulletinViewController *bulletinViewController;
// @property(assign, nonatomic) id<SBBulletinActionHandler> delegate;
@property(assign, nonatomic, getter=isRequestHandlingEnabled) BOOL requestHandlingEnabled;
@property(assign, nonatomic) BOOL scrollsToTop;
@property(readonly, assign, nonatomic) int supportedCategory;
// @property(assign, nonatomic) id<SBWidgetViewControllerHostDelegate> widgetDelegate;
+ (id)allCategories;
- (id)initWithNibName:(id)nibName bundle:(id)bundle;
- (id)initWithObserverFeed:(unsigned)observerFeed;
- (void)_addBulletinID:(id)anId toSetForFeed:(unsigned)feed;
- (void)_addBulletinID:(id)anId toSetForFeeds:(unsigned)feeds;
- (void)_addSection:(id)section toCategory:(int)category widget:(id)widget;
- (void)_associateBulletin:(id)bulletin withSection:(id)section forFeed:(unsigned)feed;
- (id)_bulletinAfterBulletin:(id)bulletin inSection:(id)section;
- (id)_bulletinWithIdentifier:(id)identifier inSection:(id)section;
- (BOOL)_canEnqueueRequestsInQueue:(id)queue;
- (BOOL)_canProcessRequestsInQueue:(id)queue;
- (void)_clearQueues;
- (void)_dequeueAndProcessItemsInQueues;
- (BOOL)_dequeueAndProcessNextItemInQueue:(id)queue;
- (BOOL)_dequeueAndProcessNextItemInQueues;
- (void)_disassociateBulletin:(id)bulletin fromSection:(id)section;
- (id)_enabledSectionWithIdentifier:(id)identifier;
- (void)_enqueueInQueue:(id)queue orProcessRequest:(id)request;
- (unsigned)_feedsForBulletinID:(id)bulletinID;
- (void)_insertBulletinViewControllerView;
- (void)_insertSectionIfNecessary:(id)necessary commit:(BOOL)commit;
- (void)_invokeBlockWithAllWidgets:(id)allWidgets;
- (BOOL)_isBulletin:(id)bulletin associatedWithSection:(id)section;
- (BOOL)_isBulletin:(id)bulletin associatedWithSection:(id)section forFeed:(unsigned)feed;
- (BOOL)_isSectionVisible:(id)visible;
- (BOOL)_isServerConnected;
- (void)_loadSection:(id)section;
- (unsigned)_numberOfBulletinsInSection:(id)section;
- (unsigned)_numberOfVisibleSections;
- (id)_reassociateBulletin:(id)bulletin withSection:(id)section;
- (void)_removeBulletinIDFromAllFeeds:(id)allFeeds;
- (void)_setSection:(id)section enabled:(BOOL)enabled;
- (void)_setSection:(id)section visible:(BOOL)visible;
- (void)_setSectionOrder:(id)order forCategory:(int)category;
- (void)_setSectionOrderRule:(int)rule;
- (void)_sortAndCommitReloadOfSectionsInCategory:(int)category;
- (void)_updateMakeshiftSectionOrderIfNecessary:(id)necessary;
- (void)_updateSection:(id)section forCategory:(int)category;
- (id)_widgetForSection:(id)section inCategory:(int)category;
- (void)addBulletin:(id)bulletin toSection:(id)section forFeed:(unsigned)feed;
- (id)bulletinAtIndex:(unsigned)index inSection:(id)section;
- (BOOL)bulletinViewController:(id)controller didSelectBulletin:(id)bulletin inSection:(id)section;
- (int)bulletinViewController:(id)controller insertionAnimationForBulletin:(id)bulletin inSection:(id)section;
- (int)bulletinViewController:(id)controller removalAnimationForBulletin:(id)bulletin inSection:(id)section;
- (int)bulletinViewController:(id)controller replacementAnimationForBulletin:(id)bulletin inSection:(id)section;
- (BOOL)bulletinViewController:(id)controller shouldHighlightBulletin:(id)bulletin inSection:(id)section;
- (UIEdgeInsets)bulletinViewControllerContentInsetsForMode:(int)mode;
- (void)clearSection:(id)section;
- (void)commitInsertionOfBulletin:(id)bulletin beforeBulletin:(id)bulletin2 inSection:(id)section forFeed:(unsigned)feed;
- (void)commitInsertionOfSection:(id)section beforeSection:(id)section2;
- (void)commitMoveOfBulletin:(id)bulletin inSection:(id)section beforeBulletin:(id)bulletin3 inSection:(id)section4;
- (void)commitMoveOfSection:(id)section beforeSection:(id)section2;
- (void)commitReloadOfSections:(id)sections;
- (void)commitRemovalOfBulletin:(id)bulletin fromSection:(id)section;
- (void)commitRemovalOfSection:(id)section;
- (void)commitReplacementWithBulletin:(id)bulletin ofBulletin:(id)bulletin2 inSection:(id)section;
- (void)commitReplacementWithSection:(id)section ofSection:(id)section2;
- (void)dealloc;
- (void)didAssociateBulletin:(id)bulletin withSection:(id)section forFeed:(unsigned)feed;
- (id)firstSection;
- (void)hostDidDismiss;
- (void)hostDidPresent;
- (void)hostWillDismiss;
- (void)hostWillPresent;
- (unsigned)indexOfBulletin:(id)bulletin inSection:(id)section;
- (unsigned)indexOfSectionWithIdentifier:(id)identifier;
- (id)infoForBulletin:(id)bulletin inSection:(id)section;
- (id)infoForBulletinSection:(id)bulletinSection;
- (id)infoForSection:(id)section;
- (id)infoForWidget:(id)widget inSection:(id)section;
- (id)infoForWidgetSection:(id)widgetSection;
- (void)invalidateContentLayout;
- (BOOL)isRePushingUpdates;
- (int)layoutMode;
- (void)loadView;
- (id)observer;
- (void)observer:(id)observer addBulletin:(id)bulletin forFeed:(unsigned)feed;
- (id)observer:(id)observer composedAttachmentImageForType:(int)type thumbnailData:(id)data key:(id)key;
- (CGSize)observer:(id)observer composedAttachmentSizeForType:(int)type thumbnailWidth:(float)width height:(float)height key:(id)key;
- (void)observer:(id)observer modifyBulletin:(id)bulletin forFeed:(unsigned)feed;
- (void)observer:(id)observer noteInvalidatedBulletinIDs:(id)ids;
- (void)observer:(id)observer noteSectionParametersChanged:(id)changed forSectionID:(id)sectionID;
- (void)observer:(id)observer noteServerConnectionStateChanged:(BOOL)changed;
- (void)observer:(id)observer removeBulletin:(id)bulletin;
- (id)observer:(id)observer thumbnailSizeConstraintsForAttachmentType:(int)attachmentType;
- (void)observer:(id)observer updateSectionInfo:(id)info inCategory:(int)category;
- (void)observer:(id)observer updateSectionOrder:(id)order forCategory:(int)category;
- (void)observer:(id)observer updateSectionOrderRule:(int)rule;
- (BOOL)observerShouldFetchAttachmentImageBeforeBulletinDelivery:(id)observer;
- (BOOL)observerShouldFetchAttachmentSizeBeforeBulletinDelivery:(id)observer;
- (void)pushUpdatesAgainForFeeds:(unsigned)feeds;
- (void)pushUpdatesAgainForSectionWithIdentifier:(id)identifier feeds:(unsigned)feeds;
- (void)removeAndDisableSection:(id)section;
- (void)removeBulletin:(id)bulletin fromSection:(id)section;
- (void)removeSection:(id)section;
- (void)replaceBulletin:(id)bulletin inSection:(id)section;
- (id)sectionAfterSection:(id)section;
- (id)sectionIdentifierAtIndex:(unsigned)index;
- (int)sectionOrderRule;
- (id)sectionWithIdentifier:(id)identifier;
- (void)sizeObservingView:(id)view didChangeSize:(CGSize)size;
- (void)sortVisibleSectionsForCategory:(int)category;
- (void)updateSection:(id)section withInfo:(id)info;
- (void)updateSection:(id)section withParameters:(id)parameters;
- (void)viewDidLoad;
- (void)viewWillLayoutSubviews;
- (void)widget:(id)widget didUpdatePreferredSize:(CGSize)size;
- (void)widget:(id)widget requestsLaunchOfURL:(id)url;
- (void)widget:(id)widget requestsPresentationOfViewController:(id)viewController presentationStyle:(int)style context:(id)context completion:(id)completion;
- (int)widgetIdiomForCategory:(int)category;
- (void)willAssociateBulletin:(id)bulletin withSection:(id)section forFeed:(unsigned)feed;
- (void)willDisassociateBulletin:(id)bulletin fromSection:(id)section;
@end


@interface SBTodayViewController : SBBulletinObserverViewController {
	NSMutableDictionary *_sectionIDsToOrderedBulletins;
	NSArray *_todaySnippetBulletinOrder;
	NSArray *_tomorrowSnippetBulletinOrder;
	//SBBBSectionInfo *_todaySectionInfo;
	//SBBBSectionInfo *_tomorrowSectionInfo;
}
- (id)initWithNibName:(id)nibName bundle:(id)bundle;
- (id)_bulletinOrderStringForBulletinInfo:(id)bulletinInfo;
- (void)_sortBulletinsForSectionWithIdentifier:(id)identifier referencingOrder:(id)order;
- (id)_todaySnippetBulletinOrder;
- (id)_tomorrowSnippetBulletinOrder;
- (int)bulletinViewController:(id)controller insertionAnimationForBulletin:(id)bulletin inSection:(id)section;
- (UIEdgeInsets)bulletinViewControllerContentInsetsForMode:(int)mode;
- (void)commitInsertionOfBulletin:(id)bulletin beforeBulletin:(id)bulletin2 inSection:(id)section forFeed:(unsigned)feed;
- (void)commitInsertionOfSection:(id)section beforeSection:(id)section2;
- (void)commitReloadOfSections:(id)sections;
- (void)commitRemovalOfBulletin:(id)bulletin fromSection:(id)section;
- (void)commitRemovalOfSection:(id)section;
- (void)commitReplacementWithBulletin:(id)bulletin ofBulletin:(id)bulletin2 inSection:(id)section;
- (void)dealloc;
- (id)infoForBulletin:(id)bulletin inSection:(id)section;
- (id)infoForBulletinSection:(id)bulletinSection;
- (id)infoForWidgetSection:(id)widgetSection;
- (id)todayTableHeaderView;
- (void)updateTableHeader;
- (void)viewDidLoad;
- (void)viewWillAppear:(BOOL)view;
- (void)viewWillLayoutSubviews;
- (void)widget:(id)widget didUpdatePreferredSize:(CGSize)size;
- (int)widgetIdiomForCategory:(int)category;
@end

@interface SBBBSectionInfo : NSObject
- (id)identifier;
@end

@interface SBBulletinListSection
@property(readonly, assign, nonatomic) NSArray *bulletins;
@property(copy, nonatomic) NSString *displayName;
@property(retain, nonatomic) UIImage *iconImage;
@property(retain, nonatomic) UIImage *largeIconImage;
@property(copy, nonatomic) NSString *sectionID;
@property(retain, nonatomic) id widget;
- (BOOL)isBulletinSection;
- (BOOL)isWidgetSection;
@end

@interface SBBBWidgetBulletinInfo /*: SBBBBulletinInfo */ {
	NSString *_identifier;
	CGSize _preferredViewSize;
	BOOL _visible;
	struct {
		unsigned _didFetchDisplayName : 1;
	} _widgetBulletinInfoFlags;
}
@property(assign, nonatomic) CGSize preferredViewSize;
// @property(readonly, assign, nonatomic) SBWidgetViewControllerHost *representedWidget;
- (void)dealloc;
- (float)heightForReusableViewInTableView:(id)tableView;
- (id)identifier;
- (id)originalSectionIdentifier;
- (void)populateReusableView:(id)view;
- (id)representedBulletin;
- (Class)reusableViewClass;
- (id)widgetIdentifier;
@end

@interface SBWidgetBulletinCell : UITableViewCell {
	SBBBWidgetBulletinInfo *_representedWidgetBulletinInfo;
}
@property(retain, nonatomic) SBBBWidgetBulletinInfo *representedWidgetBulletinInfo;
- (id)initWithStyle:(int)style reuseIdentifier:(id)identifier;
- (void)dealloc;
@end

@interface Alarm : NSObject

- (id)alarmId;
- (id)alarmIdUrl;
- (void)applySettings:(id)arg1;
- (void)cancelNotifications;
- (id)delegate;
- (void)dropNotifications;
- (unsigned int)hour;
- (id)init;
- (id)initWithDefaultValues;
- (id)initWithNotification:(id)arg1;
- (id)initWithSettings:(id)arg1;
- (BOOL)isActive;
- (BOOL)isSnoozed;
- (unsigned int)minute;
- (id)nextFireDate;
- (id)nextFireDateAfterDate:(id)arg1 notification:(id)arg2 day:(int)arg3;
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
- (id)uiTitle;
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

- (void)addAlarm:(id)arg1 active:(BOOL)arg2;
- (id)alarmWithId:(id)arg1;
- (id)alarmWithIdUrl:(id)arg1;
- (NSArray *)alarms;
- (BOOL)checkIfAlarmsModified;
- (void)countAlarmsInAggregateDictionary;
- (void)dealloc;
- (NSString *)defaultSound;
- (int)defaultSoundType;
- (void)handleAlarm:(id)arg1 startedUsingSong:(id)arg2;
- (void)handleAlarm:(id)arg1 stoppedUsingSong:(id)arg2;
- (void)handleAnyNotificationChanges;
- (void)handleExpiredOrSnoozedNotificationsOnly:(id)arg1;
- (void)handleNotificationFired:(id)arg1;
- (void)handleNotificationSnoozed:(id)arg1;
- (id)init;
- (BOOL)invalidAlarmsDetected;
- (NSDate *)lastModified;
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
- (void)setDefaultSound:(NSString *)arg1 ofType:(int)arg2;
- (void)setInvalidAlarmsDetected:(BOOL)arg1;
- (void)setLastModified:(NSDate *)arg1;
- (void)setLogMessageList:(NSMutableArray *)arg1;
- (void)unloadAlarms;
- (void)updateAlarm:(id)arg1 active:(BOOL)arg2;
@end

@interface UIDateLabel : UILabel {
    BOOL _boldForAllLocales;
    NSCalendar *_calendar;
    NSDate *_date;
    BOOL _forceTimeOnly;
    NSDate *_noon;
    float _paddingFromTimeToDesignator;
    NSDate *_previousWeek;
    BOOL _shouldRecomputeText;
    UIFont *_timeDesignatorFont;
    NSDate *_today;
    NSDate *_tomorrow;
    NSDate *_yesterday;
}

@property BOOL boldForAllLocales;
@property(retain) NSDate * date;
@property(getter=_dateString,readonly) NSString * dateString;
@property BOOL forceTimeOnly;
@property float paddingFromTimeToDesignator;
@property BOOL shouldRecomputeText;
@property(readonly) NSString * timeDesignator;
@property(readonly) BOOL timeDesignatorAppearsBeforeTime;
@property(readonly) UIFont * timeDesignatorFont;
@property(readonly) struct CGSize { float x1; float x2; } timeDesignatorSize;
@property double timeInterval;
@property(readonly) BOOL use24HourTime;

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
- (struct CGSize { float x1; float x2; })_intrinsicSizeWithinSize:(struct CGSize { float x1; float x2; })arg1;
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
- (void)setDate:(id)arg1;
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

@interface ShrinkableDateLabel : UIDateLabel {
    UIFont *_timeDesignatorFont;
}

@property(retain) UIFont *timeDesignatorFont;
- (void)dealloc;
- (void)setTimeDesignatorFont:(id)arg1;
- (void)shrinkFontsToFitWidth:(float)arg1;
- (id)timeDesignatorFont;
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

- (void)dealloc;
- (UILabel *)detailLabel;
- (UISwitch *)enabledSwitch;
- (id)initWithFrame:(CGRect)arg1;
- (void)layoutSubviews;
- (NSString *)name;
- (NSString *)repeatText;
- (void)setDetailLabel:(UILabel *)arg1;
- (void)setName:(NSString *)arg1 andRepeatText:(NSString *)arg2 textColor:(UIColor *)arg3;
- (void)setName:(NSString *)arg1;
- (void)setRepeatText:(NSString *)arg1;
- (void)setStyle:(int)arg1;
- (int)style;
- (DigitalClockLabel *)timeLabel;
@end