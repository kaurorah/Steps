//
//  ParticleScene.m
//  Steps
//
//  Created by Katherine Habeck on 12/2/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import "ParticleScene.h"
@interface ParticleScene()
@property (nonatomic, strong) NSArray * stepsTakenSprites;
@property (nonatomic, strong) NSArray * stepsNotTakenSprites;

@end

@implementation ParticleScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
    }
    return self;

}

- (void)showStepsTaken: (NSInteger) stepsTaken
{
    self.stepsTaken = stepsTaken;
    self.backgroundColor = [SKColor whiteColor];
    SKAction *scaleUp=[SKAction scaleTo:1 duration: 4];
    SKAction *scaleDown=[SKAction scaleTo: -1 duration: 4];
    SKAction *pulse = [SKAction sequence:@[scaleUp, scaleDown]];
    SKAction *repeatPulse = [SKAction repeatActionForever:pulse];

    
    SKTexture *ledTexture = [SKTexture textureWithImageNamed:@"stepDot"];
    
    for (int i = 0; i < stepsTaken; i++) {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:ledTexture];
        
        [sprite setScale:0.05];
        
        sprite.position = CGPointMake(arc4random_uniform(320), arc4random_uniform(568));
        sprite.colorBlendFactor = 1.;
        sprite.color = [UIColor greenColor];
        [sprite runAction:repeatPulse];
        [self addChild:sprite];
    }
    
    self.stepsTakenSprites = [NSArray arrayWithArray:self.children];
}

- (void)showStepsNotTaken: (NSInteger) stepsNotTaken
{
    self.stepsNotTaken = stepsNotTaken;
    self.backgroundColor = [SKColor whiteColor];
    SKAction *scaleUp=[SKAction scaleTo:0.5 duration: 4];
    SKAction *scaleDown=[SKAction scaleTo: -0.5 duration: 4];
    SKAction *pulse = [SKAction sequence:@[scaleUp, scaleDown]];
    SKAction *repeatPulse = [SKAction repeatActionForever:pulse];
    
    
    SKTexture *ledTexture = [SKTexture textureWithImageNamed:@"stepDot"];
    
    for (int i = 0; i < stepsNotTaken; i++) {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:ledTexture];
        
        [sprite setScale:0.05];
        
        sprite.position = CGPointMake(arc4random_uniform(320), arc4random_uniform(568));
        sprite.colorBlendFactor = 1.;
        sprite.color = [UIColor redColor];
        [sprite runAction:repeatPulse];
        [self addChild:sprite];
    }
    
    self.stepsNotTakenSprites = [NSArray arrayWithArray:self.children];
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
}

-(void)update:(CFTimeInterval)currentTime {

  

    /* Called before each frame is rendered */
}

@end
