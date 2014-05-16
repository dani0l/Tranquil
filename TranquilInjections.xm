#import "TranquilHeaders.h"

%hook SBClockDataProvider

- (id)_alarmMessageForNotification:(id)notification withSingleAlarmFormat:(BOOL)singleAlarmFormat {
	return [NSString stringWithFormat:@"alarm set for %@", [[%orig componentsSeparatedByString:@" "] lastObject]];
}

%end
