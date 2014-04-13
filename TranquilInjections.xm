#import "TranquilHeaders.h"

%hook SBClockDataProvider

- (id)_alarmMessageForNotification:(id)notification withSingleAlarmFormat:(BOOL)singleAlarmFormat {
	return [NSString stringWithFormat:@"Your fucking alarm set for %@ fucking sucks", [[%orig componentsSeparatedByString:@" "] lastObject]];
}

%end
