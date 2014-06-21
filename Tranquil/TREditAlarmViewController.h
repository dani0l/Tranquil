//
//  TREditAlarmViewController.h
//  Tranquil
//
//  Created by Julian Weiss on 6/20/14.
//  Copyright (c) 2014 insanj. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TREditAlarmViewController : UIViewController // <UISplitViewControllerDelegate>

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;

@property (strong, nonatomic) UIPopoverController *masterPopoverController;

@end

