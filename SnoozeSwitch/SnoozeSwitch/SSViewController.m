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
	
	UISwitch *snoozeSwitch = [[UISwitch alloc] initWithFrame:CGRectMake(0.0, 0.0, 50.0, 50.0)];
	[snoozeSwitch addTarget:self action:@selector(switchValueChanged:) forControlEvents:UIControlEventValueChanged];
	snoozeSwitch.center = self.view.center;

	UILongPressGestureRecognizer *longRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(detectedLongHold:)];
	longRecognizer.delegate = self;
	longRecognizer.minimumPressDuration = 1.0;
	[snoozeSwitch addGestureRecognizer:longRecognizer];
	
	[self.view addSubview:snoozeSwitch];
}

- (void)switchValueChanged:(UISwitch *)sender {
	NSLog(@"Detected switch value changed: %@", sender);
	sender.offImage = nil;
}

- (void)detectedLongHold:(UILongPressGestureRecognizer *)sender {
	NSLog(@"Detected long hold from %@", sender);
	UISwitch *snoozeSwitch = (UISwitch *)sender.view;
	snoozeSwitch.offImage = [self imageWithColor:[UIColor darkGrayColor] forSize:snoozeSwitch.frame.size];
	snoozeSwitch.on = NO;
}

// Derived from Matt Stevens' popular UIImage category
- (UIImage *)imageWithColor:(UIColor *)color forSize:(CGSize)size{
	CGRect drawRect = (CGRect){CGPointZero, size};
	
	UIGraphicsBeginImageContextWithOptions(size, NO, 0.0);
	CGContextRef context = UIGraphicsGetCurrentContext();
	CGContextSetFillColorWithColor(context, color.CGColor);
	CGContextFillRect(context, drawRect);
	UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	
	return image;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end