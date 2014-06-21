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
    self.view = [[TranquilView alloc] initWithFrame:(CGRect){CGPointZero, [self preferredViewSize]}];
}

- (CGSize)preferredViewSize {
	return CGSizeMake(320.0, 90.5);
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

// Notification Center was closed
- (void)hostDidDismiss {
    [super hostDidDismiss];
}

// Notification Center was opened
- (void)hostDidPresent {
    [selfView loadFullView];
	[super hostDidPresent];

/*    if (![%c(TranquilView) nextAlarmNotification]) {
        NSLog(@"[Tranquil] Detected no impending alarm, shrinking TranquilView...");
        [UIView animateWithDuration:0.5 animations:^(void) {
            self.view.superview.superview.frame = CGRectZero;
        }];
    }*/
}

@end
