//
//  TRAlarmManager.m
//  Tranquil
//
//  Created by Julian Weiss on 6/21/14.
//  Copyright (c) 2014 insanj. All rights reserved.
//

#import "TRAlarmManager.h"

@implementation TRAlarmManager

#pragma mark - class methods

+ (instancetype)sharedManager {
	static TRAlarmManager *sharedManager;
	
	static dispatch_once_t provider_token = 0;
	dispatch_once(&provider_token, ^{
		sharedManager = [[self alloc] init];
	});
	
	return sharedManager;
}

+ (NSArray *)savedAlarms {
	NSArray *alarmsFromFile = [[NSUserDefaults standardUserDefaults] arrayForKey:@"TRAlarms"];
	if (!alarmsFromFile) {
		alarmsFromFile = @[];
	}
	
	return alarmsFromFile;
}

+ (void)saveAlarms:(NSArray *)alarms {
	[[NSUserDefaults standardUserDefaults] setObject:alarms forKey:@"TRAlarms"];
}

#pragma mark - life cycle

- (instancetype)init {
	self = [super init];
	
	if (self) {
		_alarms = [self.class savedAlarms];
		// _identifiedAlarms = [
		
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(addAlarm:) name:@"Tranquil.Add" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(removeAlarm:) name:@"Tranquil.Remove" object:nil];
		[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(syncAlarm:) name:@"Tranquil.Sync" object:nil];
	}
	
	return self;
}

#pragma mark - alarm management

- (NSArray *)sortAlarms:(NSArray *)unsortedAlarms {
	return [unsortedAlarms sortedArrayUsingComparator:^NSComparisonResult(TRAlarm *firstAlarm, TRAlarm *secondAlarm) {
		NSDate *firstAlarmFireDate = firstAlarm.nextFireDate, *secondAlarmFireDate = secondAlarm.nextFireDate;
		NSTimeInterval timeIntervalDifference = [firstAlarmFireDate timeIntervalSince1970] - [secondAlarmFireDate timeIntervalSince1970];
		
		if (timeIntervalDifference < 0.5) {
			return NSOrderedAscending;
		}
		
		else if (timeIntervalDifference > 0.5) {
			return NSOrderedDescending;
		}
		
		else {
			return NSOrderedSame;
		}
	}];
}

- (void)addAlarm:(NSNotification *)notification {
	TRAlarm *alarm = [notification userInfo][@"alarm"];
	
	_alarms = [self sortAlarms:[_alarms arrayByAddingObject:alarm]];
//	_identifiedAlarms =
}

- (void)removeAlarm:(NSNotification *)notification {
	TRAlarm *alarm = [notification userInfo][@"alarm"];
	
	NSMutableArray *replacedAlarms = [[NSMutableArray alloc] initWithArray:_alarms];
	[replacedAlarms removeObject:alarm];
	
	_alarms = [NSArray arrayWithArray:replacedAlarms];
}

- (void)syncAlarm:(NSNotification *)notification {
	// TRAlarm *alarm = [notification userInfo][@"alarm"];
	
	// NSMutableArray *syncedAlarms = [[NSMutableArray alloc] initWithArray:_alarms];
}

@end
