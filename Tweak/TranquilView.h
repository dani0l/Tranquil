//
//  TranquilView.h
//  Tranquil
//
//  Created by Julian Weiss <insanjmail@gmail.com> on 27.03.2014.
//  Copyright (c) 2014 Julian Weiss <insanjmail@gmail.com>. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TranquilHeaders.h"

@interface TranquilView : UIView

+ (UILocalNotification *)nextAlarmNotification;

- (void)setBackgroundImage:(UIImage *)backgroundImage;
- (void)loadFullView;

@end
