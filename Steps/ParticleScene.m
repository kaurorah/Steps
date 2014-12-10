//
//  ParticleScene.m
//  Steps
//
//  Created by Katherine Habeck on 12/2/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import "ParticleScene.h"
@interface ParticleScene()
@property (nonatomic, strong) NSMutableArray * stepsTakenSprites;
@property (nonatomic, strong) NSMutableArray * stepsNotTakenSprites;

@end

@implementation ParticleScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
    }
    return self;

}

- (SKAction*) setStationaryAction{
    SKAction *scaleUp=[SKAction scaleTo:0.2 duration: 3];
    SKAction *scaleDown=[SKAction scaleTo:0.05  duration: 3];
    SKAction *pulse = [SKAction sequence:@[scaleUp, scaleDown]];
    SKAction *repeatPulse = [SKAction repeatActionForever:pulse];
    return repeatPulse;
}

- (SKAction*) setWalkingAction{
    SKAction *scaleUp=[SKAction scaleTo:0.2 duration: 1];
    SKAction *scaleDown=[SKAction scaleTo:0.05  duration: 2];
    SKAction *pulse = [SKAction sequence:@[scaleUp, scaleDown]];
    SKAction *repeatPulse = [SKAction repeatActionForever:pulse];
    return repeatPulse;
}

- (SKAction*) setRunningAction{
    SKAction *scaleUp=[SKAction scaleTo:0.2 duration: 1];
    SKAction *scaleDown=[SKAction scaleTo:0.05  duration: 2];
    SKAction *pulse = [SKAction sequence:@[scaleUp, scaleDown]];
    SKAction *repeatPulse = [SKAction repeatActionForever:pulse];
    return repeatPulse;
}

- (void) updateDataWith:(NSString *)activity andSteps:(NSInteger)stepsTaken andStepsNotTaken:(NSInteger)stepNotTaken{
    NSInteger pastNumberOfSteps = self.stepsTaken;
    self.currentActivity = activity;
    self.stepsNotTaken = stepNotTaken;
    self.stepsTaken = stepsTaken;
    if (self.stepsTaken > pastNumberOfSteps){
        self.updateParticles;
    }

    if([self.currentActivity isEqualToString:@"stationary"]){
        for (int i =0 ; i<self.stepsNotTakenSprites.count; i++) {
            SKSpriteNode* sprite = [self.stepsNotTakenSprites objectAtIndex:i];
            [sprite runAction:[self setStationaryAction]];
        }
    }
    if([self.currentActivity isEqualToString:@"walking"]){
        for (int i =0 ; i<self.stepsNotTakenSprites.count; i++) {
            SKSpriteNode* sprite = [self.stepsNotTakenSprites objectAtIndex:i];
            [sprite runAction:[self setWalkingAction]];
        }
    }
    if([self.currentActivity isEqualToString:@"running"]){
        for (int i =0 ; i<self.stepsNotTakenSprites.count; i++) {
            SKSpriteNode* sprite = [self.stepsNotTakenSprites objectAtIndex:i];
            [sprite runAction:[self setRunningAction]];
        }
    }
}


- (void)updateParticles{
    SKTexture *ledTexture = [SKTexture textureWithImageNamed:@"stepDot"];
    
    for (int i = 0; i < self.stepsTaken; i++) {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:ledTexture];
        
        [sprite setScale:0.05];
        
        sprite.position = CGPointMake(arc4random_uniform(320), arc4random_uniform(568));
        sprite.colorBlendFactor = 1.;
        sprite.color = [UIColor colorWithRed:30.0/255.0 green:192.0/255.0 blue:164.0/255.0 alpha:1 ];

        
        if ([self.currentActivity  isEqual:@"stationary"]) {
            [sprite runAction:[self setStationaryAction]];
        }
        else if ([self.currentActivity  isEqual:@"walking"]) {
            [sprite runAction:[self setWalkingAction]];
        }
        else if ([self.currentActivity  isEqual:@"running"]) {
            [sprite runAction:[self setRunningAction]];
        }
        [self addChild:sprite];
    }
    
    self.stepsTakenSprites = [NSMutableArray arrayWithArray:self.children];
    
    for (int i = 0; i<self.stepsNotTaken; i++) {
        [self.stepsNotTakenSprites removeLastObject];
    }

}
- (void)showStepsTaken: (NSInteger) stepsTaken
{
    self.stepsTaken = stepsTaken;
    self.backgroundColor = [SKColor whiteColor];

    
    SKTexture *ledTexture = [SKTexture textureWithImageNamed:@"stepDot"];
    
    for (int i = 0; i < stepsTaken; i++) {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:ledTexture];
        
        [sprite setScale:0.05];
        
        sprite.position = CGPointMake(arc4random_uniform(320), arc4random_uniform(568));
        sprite.colorBlendFactor = 1.;
        sprite.color = [UIColor colorWithRed:30.0/255.0 green:192.0/255.0 blue:164.0/255.0 alpha:1 ];
        SKAction* stationary = [self setStationaryAction];
        SKAction* walking = [self setWalkingAction];
        SKAction* running = [self setRunningAction];
        
        if ([self.currentActivity  isEqual:@"stationary"]) {
            [sprite runAction:[self setStationaryAction]];
        }
        else if ([self.currentActivity  isEqual:@"walking"]) {
            [sprite runAction:[self setWalkingAction]];
        }
        else if ([self.currentActivity  isEqual:@"running"]) {
            [sprite runAction:[self setRunningAction]];
        }        [self addChild:sprite];
    }
    
    self.stepsTakenSprites = [NSMutableArray arrayWithArray:self.children];
}

- (void)showStepsNotTaken: (NSInteger) stepsNotTaken
{
    self.stepsNotTaken = stepsNotTaken;
    self.backgroundColor = [SKColor whiteColor];
    
    
    SKTexture *ledTexture = [SKTexture textureWithImageNamed:@"emptyDot"];
    
    for (int i = 0; i < stepsNotTaken; i++) {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:ledTexture];
        
        [sprite setScale:0.05];
        
        sprite.position = CGPointMake(arc4random_uniform(320), arc4random_uniform(568));
        sprite.colorBlendFactor = 1.;
        sprite.color = [UIColor colorWithRed:30.0/255.0 green:22.0/255.0 blue:164.0/255.0 alpha:1 ];
        SKAction* stationary = [self setStationaryAction];
        
        if ([self.currentActivity  isEqual:@"stationary"]) {
            [sprite runAction:[self setStationaryAction]];
        }
        else if ([self.currentActivity  isEqual:@"walking"]) {
            [sprite runAction:[self setWalkingAction]];
        }
        else if ([self.currentActivity  isEqual:@"running"]) {
            [sprite runAction:[self setRunningAction]];
        }        [self addChild:sprite];
    }
    
    self.stepsNotTakenSprites = [NSMutableArray arrayWithArray:self.children];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
}

-(void)update:(CFTimeInterval)currentTime {

  

    /* Called before each frame is rendered */
}

@end
