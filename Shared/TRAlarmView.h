//
//  TRAlarmView.h
//  Tranquil
//
//  Created by Julian Weiss on 6/21/14.
//  Copyright (c) 2014 insanj. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "TRAlarm.h"
#import "TRSwitch.h"

@interface TRAlarmView : UIView

@property(nonatomic, retain) TRAlarm *alarm;

// UIKit properties sorted in order of appearance in the standard alarm view (equivalent to Alarm app).
@property(nonatomic, retain) UILabel *timeLabel, *repeatingDaysLabel;
@property(nonatomic, retain) UILabel *nameLabel;
@property(nonatomic, retain) TRSwitch *activeSwitch;

@end
