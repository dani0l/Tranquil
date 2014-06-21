//
//  TRAlarmViewController.h
//  Tranquil
//
//  Created by Julian Weiss on 6/20/14.
//  Copyright (c) 2014 insanj. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TREditAlarmViewController, TRAlarmView, TRAlarmManager, TRAlarm;

@interface TRAlarmViewController : UITableViewController

/**
 *  A static reference to the current alarm manager. Should hear and refresh to updates maybe anywhere (through notification), although the table view itself will need to be manually refreshed afterwards to update visually.
 */
@property(nonatomic, retain) TRAlarmManager *alarmManager;

@end

