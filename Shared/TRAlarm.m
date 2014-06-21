//
//  TRAlarm.m
//  Tranquil
//
//  Created by Julian Weiss on 6/21/14.
//  Copyright (c) 2014 insanj. All rights reserved.
//

#import "TRAlarm.h"

@implementation TRAlarm

+ (NSString *)generateIdentifier {
	return @"hello-world";
}

- (instancetype)initWithFireDate:(NSDate *)date name:(NSString *)name {
	self = [super init];
	
	if (self) {
		_nextFireDate = date;
		_name = name;
		
		_repeatingDays = @[];
		_identifier = [self.class generateIdentifier];
		_active = YES;
	}
	
	return self;
}

@end
