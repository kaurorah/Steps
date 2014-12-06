//
//  ViewController.m
//  Steps
//
//  Created by Katherine Habeck on 12/2/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign) NSNumber* stepsToday;
@property (nonatomic, strong) CMPedometer *pedometer;
@property (nonatomic,strong) CMMotionActivityManager *motionDetector;
@property (nonatomic,strong) NSDate * now;

@end

@implementation ViewController

CLLocationManager *locationManager;
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.now = [NSDate date];
    self.motionDetector = [[CMMotionActivityManager alloc] init];
    [self getActivitySinceMidnight];
   // [self beginLivePedometerUpdates];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.distanceFilter = kCLDistanceFilterNone;
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
    [locationManager startUpdatingLocation];

    float latitude = locationManager.location.coordinate.latitude;
    float longitude = locationManager.location.coordinate.longitude;
    
    NSTimeZone *localTime = [NSTimeZone systemTimeZone];
    EDSunriseSet *sun = [EDSunriseSet sunrisesetWithTimezone:localTime latitude:latitude longitude:longitude];
    [sun calculate:[NSDate date]];
    
    NSDate *currentDate = [NSDate date];
    NSDate *sunset = sun.sunset;
    NSDate *sunrise = sun.sunrise;
    
    [sun calculateSunriseSunset:[NSDate date]];
    [sun calculate:[NSDate date]];
    NSLog(@"%@",sunrise);
    
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

- (void) getActivitySinceMidnight {
    
    NSCalendar *calendar = [NSCalendar autoupdatingCurrentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitYear
                                    | NSCalendarUnitMonth
                                    | NSCalendarUnitDay
                                               fromDate:self.now];
    
    NSDate *beginOfDay = [calendar dateFromComponents:components];
   
    if ([CMPedometer isStepCountingAvailable]) {
        self.pedometer = [[CMPedometer alloc] init];
    }
    else {
        NSLog(@"pedometer not available!");
    }
//
//    [self.pedometer queryPedometerDataFromDate:beginOfDay toDate:self.now withHandler:^(CMPedometerData *pedometerData, NSError *error) {
//                self.stepsToday = pedometerData.numberOfSteps;
//                self.stepsTodayLabel.text=[self stringWithObject:pedometerData.numberOfSteps];
//
//    }];
    [self.pedometer startPedometerUpdatesFromDate:beginOfDay
                                      withHandler:^(CMPedometerData *pedometerData, NSError *error) {
                                          dispatch_async(dispatch_get_main_queue(), ^{
                                              
                                              NSLog(@"data:%@, error:%@", pedometerData, error);
                                              self.stepsTodayLabel.text = [self stringWithObject:pedometerData.numberOfSteps];
                                            NSInteger steps = [pedometerData.numberOfSteps integerValue];
                                              
                                              NSInteger difference = self.selectedStepGoal - steps;
                                              
                                              self.stepsAwayFromGoal.text = [NSString stringWithFormat: @"%ld", (long)difference];
                                    

                                          });
                                      }];

    [self getCurrentActivity];
   
    
}

- (void) beginLivePedometerUpdates{
    NSTimer * timer = [ NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(getActivitySinceMidnight) userInfo:nil repeats:YES];
}

- (void) getCurrentActivity {
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

@end
