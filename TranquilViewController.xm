//
//  TranquilViewController.m
//  Tranquil
//
//  Created by Julian Weiss <insanjmail@gmail.com> on 27.03.2014.
//  Copyright (c) 2014 Julian Weiss <insanjmail@gmail.com>. All rights reserved.
//

#ifndef __LP64__

#import "TranquilViewController.h"
#import "TranquilView.h"

#import "headers/TouchFix/TouchFix.h"

@interface TranquilViewController ()

@property (nonatomic, strong) TranquilView *view;
@property (nonatomic, strong) NSBundle *bundle;

@end


@implementation TranquilViewController

- (instancetype)init {
    self = [super init];

	if (self) {
		self.bundle = [NSBundle bundleForClass:[self class]];
	}

    return self;
}

- (void)loadFullView {
    // add views here
    [self.view loadFullView];
}

- (TranquilView *)view {
    if (!_view) {
        [self loadView];
    }

    return _view;
}

- (void)loadView {
    self.view = [[TranquilView alloc] initWithFrame:(CGRect){CGPointZero, {0.0f, self.viewHeight}}];
	self.view.autoresizingMask = UIViewAutoresizingFlexibleWidth;
}

- (void)loadPlaceholderView {
	UIImage *backgroundImage = [UIImage imageWithContentsOfFile:[self.bundle pathForResource:@"Background" ofType:@"png"]];

	UIImage *stretchableBackgroundImage = [backgroundImage stretchableImageWithLeftCapWidth:(NSInteger)backgroundImage.size.width/2.0f topCapHeight:(NSInteger)backgroundImage.size.height/2.0f];

    [self.view setBackgroundImage:stretchableBackgroundImage];
}


- (void)unloadView {
    [self.view removeFromSuperview];
	self.view = nil;
	// Destroy any additional subviews you added here!
}

- (float)viewHeight {
	return 90.5; // Default AlarmView height
}

- (void)viewWillAppear {

}

- (void)viewDidAppear {

}

- (void)viewWillDisappear {

}

- (void)viewDidDisappear {

}

#pragma mark - TouchFix

// Not sure how to use this, returning a valid URL doesn't do much...
- (NSURL *)launchURLForTapLocation:(CGPoint)point {
    UITouch *touch = [[UITouch alloc] initWithPoint:[self.view convertPoint:point toView:self.view.window] andView:self.view];

    UIEvent *eventDown = [[UIEvent alloc] initWithTouch:touch];
    [touch.view touchesBegan:[eventDown allTouches] withEvent:eventDown];
    [touch setPhase:UITouchPhaseEnded];

    UIEvent *eventUp = [[UIEvent alloc] initWithTouch:touch];
    [touch.view touchesEnded:[eventUp allTouches] withEvent:eventUp];

    return nil;
}

@end


#endif
