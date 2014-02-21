//
//  Tranquil.xm
//  Tranquil
//
//  Created by Julian Weiss on 2/14/14.
//  Copyright (c) 2014 insanj. All rights reserved.
//

/*
 -[<SBTodayViewController: 0x13e69b360> commitInsertionOfSection:<SBBBSectionInfo: 0x1706212c0; representedObject: <SBBulletinListSection: 0x17811e8d0; type = Bulletin; sectionID = com.apple.mobiletimer>> beforeSection:(null)]
 -[<SBTodayViewController: 0x13e69b360> commitInsertionOfBulletin:<SBSnippetBulletinInfo: 0x178485500; representedObject: <BBBulletin: 0x13f829e10>{
		com.apple.mobiletimer / 0 / 8BDBD482-490A-4282-ABDE-09743E93EE87
		Match ID: DA3F90D3-BBBA-499C-8697-A4BA2EBCD35C
		Content: <redacted>
		Date: (null)
		Sound: (null)
	
	}> beforeBulletin:(null) inSection:<SBBBSectionInfo: 0x1706212c0; representedObject: <SBBulletinListSection: 0x17811e8d0; type = Bulletin; sectionID = com.apple.mobiletimer>> forFeed:32]

*/

#import "Tranquil.h"
#define kTranquilHeightValue 100.0


/*
%hook UIView

CGFloat timey;
- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
	if(%orig != nil && event.timestamp - timey > 2){
		timey = event.timestamp;
		NSLog(@"---=-=-=-=- detected hit on %@ wth sub %@ sna subp %@", %orig, %orig.subviews, %orig.superview);
	}
	return %orig();
}

%end*/

SBTodayViewController - > SBBulletinObserverViewController - > self.SBBulletinViewController - > - (BOOL)_insertBulletin:(id)bulletin atIndex:(unsigned)index inSection:(id)section;.... tableView!

%hook SBWidgetBulletinCell
//static char * kTranquilMobileTimerKey;

//-[<SBWidgetBulletinCell: 0x140029450> initWithStyle:0 reuseIdentifier:SBBBWidgetBulletinInfo]
- (id)initWithStyle:(int)style reuseIdentifier:(id)identifier {
	SBTodayBulletinCell *cell = %orig();

	NSLog(@"[Tranquil] Detected creation of MobileTimer widget (%@) with info: %@, adding Alarm subview...", cell, [cell labelText]);
	for(UIView *v in cell.subviews)
		NSLog(@"------ foundee %@ with %@", v, v.subviews);

	/*if([[info identifier] isEqualToString:@"com.apple.mobiletimer"]){
		objc_setAssociatedObject(self, &kTranquilMobileTimerKey, @(YES), OBJC_ASSOCIATION_RETAIN_NONATOMIC);

		Alarm *nextAlarm = [[%c(AlarmManager) sharedManager] nextAlarmForDate:[NSDate date] activeOnly:YES allowRepeating:YES];
		NSLog(@"[Tranquil / DEBUG] All alarms: %@, next alarm: %@", [[%c(AlarmManager) sharedManager] alarms], nextAlarm);

		AlarmView *nextAlarmView = [[%c(AlarmView) alloc] initWithFrame:CGRectMake(CGRectGetMinX(cell.frame), CGRectGetHeight(cell.frame), CGRectGetWidth(cell.frame), kTranquilHeightValue)];
		info.preferredViewSize = CGSizeMake(info.preferredViewSize.width, info.preferredViewSize.height + kTranquilHeightValue);

		NSString *days = [nextAlarm repeats] ? @"" : nil;
		if(days){
			NSArray *repeatDays = [nextAlarm repeatDays];
			for(int i = 0; i < repeatDays.count; i++){
				if(i < repeatDays.count - 1)
					days = [days stringByAppendingString:[NSString stringWithFormat:@"%@, ", repeatDays[i]]];

				else
					days = [days stringByAppendingString:repeatDays[i]];
			}
		}

		[nextAlarmView setName:MSHookIvar<NSString *>(nextAlarm, "_title") andRepeatText:days textColor:[UIColor colorWithWhite:0.9 alpha:0.9]];
		[[nextAlarmView timeLabel] setDate:[nextAlarm nextFireDate]];
		[[nextAlarmView enabledSwitch] setOn:YES];
		nextAlarmView.tag = 5451;

		CGRect expanded = cell.frame;
		expanded.size.height = CGRectGetHeight(expanded) + CGRectGetHeight(nextAlarmView.frame);
		[cell setFrame:expanded];
		[cell addSubview:nextAlarmView];
	}

	else{
		if([cell viewWithTag:5451])
			[[cell viewWithTag:5451] removeFromSuperview];

		objc_setAssociatedObject(self, &kTranquilMobileTimerKey, @(NO), OBJC_ASSOCIATION_RETAIN_NONATOMIC);
	}
*/
	return cell;
}


%end

/*
%hook SBTodayViewController

// TODO: look for insertion of widget, then, after %orig, find that widget's associated view properties (must exist somewhere down there), and add the nextAlarmView to it. Set tap properties and all that to the MobileTimer framework's options.

- (void)

- (void)commitInsertionOfBulletin:(id)bulletin beforeBulletin:(id)bulletin2 inSection:(id)section forFeed:(unsigned)feed{
	%orig();

	if([[section identifier] isEqualToString:@"com.apple.mobiletimer"]){
		NSLog(@"[Tranquil] Detected insertion of Alarm widget, adding alarm subview...");

		Alarm *nextAlarm = [[%c(AlarmManager) sharedManager] nextAlarmForDate:[NSDate date] activeOnly:YES allowRepeating:YES];
		NSLog(@"[Tranquil / DEBUG] All alarms: %@, identifiter: %@, next alarm: %@", [[%c(AlarmManager sharedManager)] alarms], [bulletin identifier], nextAlarm);

		AlarmView *nextAlarmView = [[%c(AlarmView) alloc] initWithFrame:CGRectMake(0.0, 0.0, CGRectGetWidth(self.view.frame), 100.0)];

		NSString *days = [nextAlarm repeats] ? @"" : nil;
		if(days){
			NSArray *repeatDays = [nextAlarm repeatDays];
			for(int i = 0; i < repeatDays.count; i++){
				if(i < repeatDays.count - 1)
					days = [days stringByAppendingString:@"%@, ", repeatDays[i]];

				else
					days = [days stringByAppendingString:repeatDays[i]];
			}
		}

		[nextAlarmView setName:MSHookIvar<NSString *>(nextAlarm, "_title") andRepeatText:days textColor:[UIColor colorWithWhite:0.9 alpha:0.9]];
		[[nextAlarmView timeLabel] setHour:[nextAlarm hour] minute:[nextAlarm minute]];
		[[nextAlarmView enabledSwitch] setOn:YES];

		[self.view addSubview:nextAlarmView];
		//[[NSDistributedNotificationCenter defaultCenter] postNotificationName:@"TQAddClock" object:nil userInfo:@{@"bulletin" : bulletin}];
	}
}

%end*/