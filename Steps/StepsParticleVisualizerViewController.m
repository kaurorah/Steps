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
- (IBAction)pageInfo:(id)sender {
        UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Particle Information" message:@"\nThese particles show you how many steps you have taken and how many you need to complete your goal.\n \n Each particle represents 10 steps. The solid particles are steps you have taken today. The hollow particles are steps you need to complete your daily goal!\n \nThe speed of the particles reflect your current activity state." preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *cancel = [UIAlertAction actionWithTitle:@"Okay" style:UIAlertActionStyleCancel handler:nil];
        [alert addAction:cancel];
        [self presentViewController:alert animated:YES completion:nil];
    
}

-(BOOL) prefersStatusBarHidden{
    return YES;
}

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
    
    self.scene.stepsTaken= self.stepsTakenTransferred/10;
    self.scene.stepsNotTaken = self.stepsNotTakenTransferred/10;
    self.scene.currentActivity = self.activityTransferred;
    self.activityLabel.text = self.activityTransferred;
    [self.scene showStepsTaken:(NSInteger) self.stepsTakenTransferred/10];
    [self.scene showStepsNotTaken:(NSInteger) self.stepsNotTakenTransferred/10];
}

- (void) viewDidAppear:(BOOL)animated{
    self.activityLabel.text = self.activityTransferred;
    if(self.scene !=nil){
        [self.scene updateDataWith:self.activityTransferred andSteps:self.stepsTakenTransferred/10 andStepsNotTaken:self.stepsNotTakenTransferred/10];
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
