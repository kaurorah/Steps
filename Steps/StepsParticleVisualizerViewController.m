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
    ParticleScene * scene = [ParticleScene sceneWithSize:skView.bounds.size];
    scene.scaleMode = SKSceneScaleModeAspectFill;
    
    // Present the scene.
    [skView presentScene:scene];
    
    [scene showStepsTaken:(NSInteger) self.stepsTakenTransferred];
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
