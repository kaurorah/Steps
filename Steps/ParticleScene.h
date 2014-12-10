//
//  ParticleScene.h
//  Steps
//
//  Created by Katherine Habeck on 12/2/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <SpriteKit/SpriteKit.h>

@interface ParticleScene : SKScene
- (void)showStepsTaken: (NSInteger) stepsTaken;
- (void)showStepsNotTaken: (NSInteger) stepsNotTaken;
- (void)updateDataWith: (NSString*)activity andSteps:(NSInteger)stepsTaken andStepsNotTaken:(NSInteger)stepNotTaken;
-(void)updateParticles;
@property (nonatomic) NSString*  currentActivity;
@property (nonatomic) NSInteger stepsNotTaken;
@property (nonatomic) NSInteger stepsTaken;

@end
