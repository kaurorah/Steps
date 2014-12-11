//
//  SetupViewController.m
//  Steps
//
//  Created by Katherine Habeck on 12/5/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import "SetupViewController.h"

@interface SetupViewController (){
    NSArray *stepPickerData;
    NSInteger selectedGoal;
}
@end

@implementation SetupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Initialize Data
    stepPickerData = @[@"1500", @"2000", @"2500",@"3000", @"3500", @"4000", @"4500",
                       @"5000", @"5500", @"6000",@"6500",@"7000",@"7500",@"8000",@"9500",@"10000",@"10500"];
    
    self.stepGoalPicker.dataSource = self;
    self.stepGoalPicker.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// The number of columns of data
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// The number of rows of data
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return stepPickerData.count;
}

// The data to return for the row and component (column) that's being passed in
- (NSString*)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return stepPickerData[row];
}

// Catpure the picker view selection
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    selectedGoal=(NSInteger)[[stepPickerData objectAtIndex:row] integerValue];//(NSInteger)stepPickerData[row];
    

}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if([segue.identifier isEqualToString:@"showNumericalScene"]){
        UITabBarController *tabBarController = (UITabBarController *)segue.destinationViewController;
        ViewController *controller = (ViewController *)[tabBarController.viewControllers objectAtIndex:0];
        controller.selectedStepGoal = selectedGoal;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
