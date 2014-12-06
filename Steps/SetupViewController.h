//
//  SetupViewController.h
//  Steps
//
//  Created by Katherine Habeck on 12/5/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"
@interface SetupViewController : UIViewController<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UIPickerView *stepGoalPicker;

@end
