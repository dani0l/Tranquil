//
//  TranquilViewControllerNew.m
//  Tranquil
//
//  Created by Julian Weiss <insanjmail@gmail.com> on 27.03.2014.
//  Copyright (c) 2014 Julian Weiss <insanjmail@gmail.com>. All rights reserved.
//

#import "TranquilViewControllerNew.h"
#import "TranquilView.h"

#define selfView ((TranquilView *)self.view)

@interface TranquilViewControllerNew ()

@property (nonatomic, strong) NSBundle *bundle;

@end


@implementation TranquilViewControllerNew

- (instancetype)init {
    self = [super init];
    
	if (self) {
        self.bundle = [NSBundle bundleForClass:[self class]];
	}
	return self;
}

- (void)loadView {
    self.view = [[TranquilView alloc] initWithFrame:(CGRect){CGPointZero, self.preferredViewSize}];
}

- (CGSize)preferredViewSize {
	return CGSizeMake(320.0f, 70.0f);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blueColor];
}


- (void)hostDidDismiss {
    [super hostDidDismiss];
	//Notification Center was closed
}

- (void)hostDidPresent {
	[super hostDidPresent];
	//Notification Center was opened
}

@end
