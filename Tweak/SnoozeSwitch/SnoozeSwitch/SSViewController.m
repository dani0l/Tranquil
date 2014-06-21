//
//  SSViewController.m
//  SnoozeSwitch
//
//  Created by Julian Weiss on 4/27/14.
//  Copyright (c) 2014 Julian Weiss. All rights reserved.
//

#import "SSViewController.h"

@implementation SSViewController

- (instancetype)init {
	self = [super init];
	return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	
	self.view.backgroundColor = [UIColor clearColor];
	
	UISwitch *snoozeSwitch = [[SSSwitch	alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
	snoozeSwitch.center = self.view.center;
	[self.view addSubview:snoozeSwitch];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end