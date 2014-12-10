//
//  ViewController.h
//  Steps
//
//  Created by Katherine Habeck on 12/2/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@import CoreMotion;
@interface ViewController : UIViewController  <UITabBarControllerDelegate>
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (weak, nonatomic) IBOutlet UILabel *stepsTodayLabel;
@property(nonatomic) NSInteger selectedStepGoal;
@property (weak, nonatomic) IBOutlet UILabel *stepsAwayFromGoal;

//Passed on to other controllers
@property (nonatomic) NSInteger stepsTaken;
@property (nonatomic) NSInteger stepsNotTaken;
@property (nonatomic) NSString *activity;


@end

