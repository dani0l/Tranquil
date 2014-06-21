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
	}
	
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];

	self.navigationItem.leftBarButtonItem = self.editButtonItem;

	UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addAlarm:)];
	self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - actions

- (void)insertNewObject:(id)sender {
	if (!self.objects) {
	    self.objects = [[NSMutableArray alloc] init];
	}
	[self.objects insertObject:[NSDate date] atIndex:0];
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[self.tableView insertRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark - table view
#pragma mark datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	return self.objects.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

	NSDate *object = self.objects[indexPath.row];
	cell.textLabel.text = [object description];
	return cell;
}

#pragma mark delegate

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
	// Return NO if you do not want the specified item to be editable.
	return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	if (editingStyle == UITableViewCellEditingStyleDelete) {
	    [self.objects removeObjectAtIndex:indexPath.row];
	    [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
	} else if (editingStyle == UITableViewCellEditingStyleInsert) {
	    // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
	}
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
	    NSDate *object = self.objects[indexPath.row];
	    self.detailViewController.detailItem = object;
	}
}

@end
