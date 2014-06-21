//
//  TRAlarmViewController.m
//  Tranquil
//
//  Created by Julian Weiss on 6/20/14.
//  Copyright (c) 2014 insanj. All rights reserved.
//

#import "TRAlarmViewController.h"

@implementation TRAlarmViewController

#pragma mark - lifecycle

- (instancetype)init {
	self = [super init];
	
	if (self) {
		_alarmManager = [TRAlarmManager sharedManager];
		_alarmsDataSource = [[NSMutableArray alloc] initWithArray:_alarmManager.alarms];
	}
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	self.navigationItem.leftBarButtonItem = self.editButtonItem;

	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)];
	self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (void)insertNewObject:(id)sender {
	[_alarmsDataSource insertObject:[[TRAlarm alloc] init] atIndex:0];
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - table view
#pragma mark datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return _alarmsDataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TranquilCell" forIndexPath:indexPath];

	TRAlarmView *alarmView = (TRAlarmView *)[cell viewWithTag:1];
	if (!alarmView) {
		alarmView = [[TRAlarmView alloc] initWithFrame:cell.frame];
		alarmView.tag = 1;
		
		[cell addSubview:alarmView];
	}
	
	alarmView.alarm = _alarmsDataSource[indexPath.row];
	
	return cell;
}

#pragma mark delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	
	if (editingStyle == UITableViewCellEditingStyleDelete) {
		TRAlarm *alarmToBeRemoved = [_alarmsDataSource objectAtIndex:indexPath.row];
		[[NSNotificationCenter defaultCenter] postNotificationName:@"Tranquil.Remove" object:nil userInfo:@{@"alarm" : alarmToBeRemoved}];
		
		[_alarmsDataSource removeObject:alarmToBeRemoved];
	    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	}
	
	else if (editingStyle == UITableViewCellEditingStyleInsert) {
	    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	[tableView deselectRowAtIndexPath:indexPath animated:YES];
	
	/*if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
	    NSDate *object = self.objects[indexPath.row];
	    self.detailViewController.detailItem = object;
	}*/
}

@end
