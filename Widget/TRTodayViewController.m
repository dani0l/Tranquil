//
//  TRTodayViewController.m
//  Widget
//
//  Created by Julian Weiss on 6/20/14.
//  Copyright (c) 2014 insanj. All rights reserved.
//

#import "TRTodayViewController.h"

@implementation TRTodayViewController

- (instancetype)init {
	self = [super init];
	if (self) {
		self.view = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, [UIScreen mainScreen].bounds.size.width, 180.0)];
		self.view.backgroundColor = [UIColor redColor];
	}
	
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	TRAlarmView *exampleAlarmView = [[TRAlarmView alloc] initWithFrame:self.view.frame];
	exampleAlarmView.alarm = [[TRAlarm alloc] initWithFireDate:[NSDate date] name:@"Example"];
	[self.view addSubview:exampleAlarmView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	
    // Dispose of any resources that can be recreated.
}

- (void)widgetPerformUpdateWithCompletionHandler:(void (^)(NCUpdateResult))completionHandler {
    // Perform any setup necessary in order to update the view.
    
    // If an error is encoutered, use NCUpdateResultFailed
    // If there's no update required, use NCUpdateResultNoData
    // If there's an update, use NCUpdateResultNewData

    completionHandler(NCUpdateResultNewData);
}

@end
