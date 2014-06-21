//
//  TRAlarm.h
//  Tranquil
//
//  Created by Julian Weiss on 6/21/14.
//  Copyright (c) 2014 insanj. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "TRAlarmManager.h"

@interface TRAlarm : NSObject

/**
 *  Unique alarm identifier, unshared by any other object.
 */
@property(nonatomic, retain) NSString *identifier;

@property(nonatomic, retain) NSString *name;

@property(nonatomic, retain) NSArray *repeatingDays;

@property(nonatomic, retain) NSDate *nextFireDate;

@property(nonatomic, readwrite) BOOL active;

/**
 *  Generates a unique identifier using in-house algorithm, and checking current usage via alarm manager.
 *
 *  @return Unique alarm identifier.
 */
+ (NSString *)generateIdentifier;

- (instancetype)initWithFireDate:(NSDate *)date name:(NSString *)name;

@end
