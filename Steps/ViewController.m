//
//  ViewController.m
//  Steps
//
//  Created by Katherine Habeck on 12/2/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import "ViewController.h"
#import "StepsParticleVisualizerViewController.h"

@interface ViewController ()

@property (assign) NSNumber* stepsToday;
@property (nonatomic, strong) CMPedometer *pedometer;
@property (nonatomic,strong) CMMotionActivityManager *motionDetector;
@property (nonatomic,strong) NSDate * now;
@property (weak, nonatomic) IBOutlet UISwitch *dataToggle;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel1;
@property (weak, nonatomic) IBOutlet UILabel *stepsLabel2;
@property (weak, nonatomic) IBOutlet UILabel *toggleInstructionLabel;

@end

@implementation ViewController

CLLocationManager *locationManager;
- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:YES];
   
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.delegate = self;

    self.now = [NSDate date];
    self.motionDetector = [[CMMotionActivityManager alloc] init];
    [self getActivitySinceMidnight];
   // [self beginLivePedometerUpdates];
    
    
}
-(BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController{
    if ([viewController isKindOfClass:[StepsParticleVisualizerViewController class]]){
        StepsParticleVisualizerViewController *svc = (StepsParticleVisualizerViewController *) viewController;
        svc.stepsTakenTransferred = self.stepsTaken;
        svc.stepsNotTakenTransferred = self.stepsNotTaken;
    }
    return TRUE;
}

//calorie estimates from this article: http://www.livestrong.com/article/320124-how-many-calories-does-the-average-person-use-per-step/
//1 calorie for every 20 steps on average
- (IBAction)switchPressed:(id)sender {
    NSLog(@"switched");
    if (self.dataToggle.isOn) {
        self.stepsLabel1.text=@"You have taken";
        NSInteger steps = [self.stepsToday integerValue];
        self.stepsTodayLabel.text=[NSString stringWithFormat: @"%ld", (long)steps];
        self.stepsLabel2.text= @"steps today.";
        self.toggleInstructionLabel.text=@"Toggle for calories.";

    }
    else{
        NSLog(@"%@", self.stepsToday);
        NSInteger steps = [self.stepsToday integerValue];
        NSInteger caloriesBurned=steps/20;
        NSLog(@"%ld", (long)caloriesBurned);

        self.stepsLabel1.text=@"You have burned";
        self.stepsTodayLabel.text=[NSString stringWithFormat: @"%ld", (long)caloriesBurned];
        self.stepsLabel2.text= @"calories today.";
        self.toggleInstructionLabel.text=@"Toggle for steps.";
        


    }
    
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
                                              self.stepsToday=pedometerData.numberOfSteps;
                                              NSLog(@"%@", self.stepsToday);
                                              NSInteger difference = self.selectedStepGoal - steps;
                                              
                                              self.stepsAwayFromGoal.text = [NSString stringWithFormat: @"%ld", (long)difference];
                                    
                                              self.stepsTaken = steps;
                                              self.stepsNotTaken = difference;
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
