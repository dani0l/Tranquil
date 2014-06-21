//
//  TRAlarm.h
//  Tranquil
//
//  Created by Julian Weiss on 6/21/14.
//  Copyright (c) 2014 insanj. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TRAlarm : NSObject

/**
 *  Unique alarm identifier, unshared by any other object.
 */
@property(nonatomic, retain) NSString *identifier;

@property(nonatomic, retain) NSDate *nextFireDate;

@end
