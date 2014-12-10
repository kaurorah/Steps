//
//  StepsParticleVisualizerViewController.m
//  Steps
//
//  Created by Katherine Habeck on 12/2/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import "StepsParticleVisualizerViewController.h"
#import "ParticleScene.h"

@interface StepsParticleVisualizerViewController ()
@property (weak, nonatomic) IBOutlet UILabel *activityLabel;
@property (nonatomic) ParticleScene * scene;
@end

@implementation StepsParticleVisualizerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"%ld", self.stepsNotTakenTransferred);

    // Configure the view.
    SKView * skView = (SKView *)self.view;
    skView.showsFPS = YES;
    skView.showsNodeCount = YES;
    
    // Create and configure the scene.
    self.scene = [ParticleScene sceneWithSize:skView.bounds.size];
    self.scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:self.scene];
    
    self.scene.stepsTaken= self.stepsTakenTransferred;
    self.scene.stepsNotTaken = self.stepsNotTakenTransferred;
    self.scene.currentActivity = self.activityTransferred;
    self.activityLabel.text = self.activityTransferred;
    [self.scene showStepsTaken:(NSInteger) self.stepsTakenTransferred];
    [self.scene showStepsNotTaken:(NSInteger) self.stepsNotTakenTransferred];
}

- (void) viewDidAppear:(BOOL)animated{
    self.activityLabel.text = self.activityTransferred;
    if(self.scene !=nil){
        [self.scene updateDataWith:self.activityTransferred andSteps:self.stepsTakenTransferred andStepsNotTaken:self.stepsNotTakenTransferred];
    }
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
