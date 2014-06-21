//
//  TRAlarmManager.h
//  Tranquil
//
//  Created by Julian Weiss on 6/21/14.
//  Copyright (c) 2014 insanj. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "TRAlarm.h"

@interface TRAlarmManager : NSObject

/**
 *  Full set of all current alarms (active or inactive). Sorted chronologically.
 */
@property(nonatomic, retain) NSArray *alarms;

/**
 *  Full set of all current alarms, unsorted and assigned to their respective identifiers.
 */
@property(nonatomic, retain) NSMutableDictionary *identifiedAlarms;

/**
 *  Shared instance of the alarm manager. If there are more than one of these existing at any point in time, they will still be synchronized through the use of notifications.
 *
 *  @return Non-nil alarm manager instance (new if there is none present).
 */
+ (instancetype)sharedManager;

/**
 *  Retrieves all saved alarms from storage (either locally or online, depending on currently employed method). Only used in initialization of a new alarm manager.
 *
 *  @return Set of all alarms saved on disk (active and inactive). Far more costly to retrieve than property accessing.
 */
+ (NSArray *)savedAlarms;

+ (void)saveAlarms:(NSArray *)alarms;

/**
 *  Initializes and extracts all required properties from storage.
 *
 *  @return Alarm manager instance, should only be created once per app lifecycle (due to +sharedManager).
 */
- (instancetype)init;

/**
 *  Adds alarm to all alarm manager instances, and saves to file.
 *
 *  @param notification Notification with a valid, unique, new alarm in userInfo under the "alarm" key.
 */
- (void)addAlarm:(NSNotification *)notification;

/**
 *  Removes alarm in all alarm manager instances, and saves new alarm file.
 *
 *  @param notification Notification with a valid, unique, existing alarm in userInfo under the "alarm" key.
 */
- (void)removeAlarm:(NSNotification *)notification;

/**
 *  Synchronizes alarm in all alarm manager instances, and updates in file.
 *
 *  @param notification Notification with a valid, unique, existing alarm (with changes) in userInfo under the "alarm" key.
 */
- (void)syncAlarm:(NSNotification *)notification;

@end
