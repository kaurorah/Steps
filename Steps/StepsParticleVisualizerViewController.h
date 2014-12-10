//
//  StepsParticleVisualizerViewController.h
//  Steps
//
//  Created by Katherine Habeck on 12/2/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <SpriteKit/SpriteKit.h>

@interface StepsParticleVisualizerViewController : UIViewController
@property (nonatomic) NSInteger stepsTakenTransferred;
@property (nonatomic) NSInteger stepsNotTakenTransferred;
@property (nonatomic) NSString* activityTransferred;
@end
