//
//  ViewController.h
//  Steps
//
//  Created by Katherine Habeck on 12/2/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EDSunriseSet.h"
#import <CoreLocation/CoreLocation.h>
@import CoreMotion;
@interface ViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepsTodayLabel;
@property(nonatomic) NSInteger selectedStepGoal;

@property (weak, nonatomic) IBOutlet UILabel *stepsAwayFromGoal;

@end

