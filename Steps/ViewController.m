//
//  ViewController.m
//  Steps
//
//  Created by Katherine Habeck on 12/2/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign) NSInteger stepsToday;
@property (nonatomic, strong) CMPedometer *pedometer;
@property (nonatomic,strong) CMMotionActivityManager *motionDetector;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //TODO: investigate nscalendar for better date tracking
    NSDate *today = [NSDate date];
    NSDate *past24Hours = [today dateByAddingTimeInterval:-(24. * 3600.)];

    if ([CMPedometer isStepCountingAvailable]) {
        self.pedometer = [[CMPedometer alloc] init];
    }
    else {
        NSLog(@"pedometer not available!");
    }
    //live updates of pedometer data
    [self.pedometer startPedometerUpdatesFromDate:past24Hours
                                      withHandler:^(CMPedometerData *pedometerData, NSError *error) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              
                                              NSLog(@"data:%@, error:%@", pedometerData, error);
                                                  self.stepsTodayLabel.text=[self stringWithObject:pedometerData.numberOfSteps];
                                          });
                              }];
//    [self.pedometer queryPedometerDataFromDate:past24Hours toDate:today withHandler:^(CMPedometerData *pedometerData, NSError *error) {
//        self.stepsTodayLabel.text=[self stringWithObject:pedometerData.numberOfSteps];
//        
//    }];
    self.motionDetector = [[CMMotionActivityManager alloc] init];
    [self.motionDetector startActivityUpdatesToQueue:[[NSOperationQueue alloc] init] withHandler:^(CMMotionActivity *activity) {
        if ([activity walking]) {
            self.activityLabel.text=@"walking";
        }
        if ([activity running]) {
            self.activityLabel.text=@"running";
        }
        if ([activity cycling]) {
            self.activityLabel.text=@"cycling";
        }
        if ([activity automotive]) {
            self.activityLabel.text=@"automotive";
        }
        if ([activity stationary]) {
            self.activityLabel.text=@"stationary";
        }
        if ([activity unknown]) {
            self.activityLabel.text=@"unknown";
        }
    }];


}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (NSString *)stringWithObject:(id)obj {
    
    return [NSString stringWithFormat:@"%@", obj];
}

- (void)viewWillDisappear:(BOOL)animated {
    
    [super viewWillDisappear:animated];
    
    [self.pedometer stopPedometerUpdates];
    
}




@end
