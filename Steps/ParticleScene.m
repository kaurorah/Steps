//
//  ParticleScene.m
//  Steps
//
//  Created by Katherine Habeck on 12/2/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import "ParticleScene.h"
@interface ParticleScene()
    @property (nonatomic, strong) NSArray *sprites;
@end

@implementation ParticleScene
-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        
    }
    return self;

}

- (void)showStepsTaken: (NSInteger) stepsTaken
{
    self.backgroundColor = [SKColor blackColor];
    
    SKTexture *ledTexture = [SKTexture textureWithImageNamed:@"pusheen"];
    
    for (int i = 0; i < stepsTaken; i++) {
        SKSpriteNode *sprite = [SKSpriteNode spriteNodeWithTexture:ledTexture];
        
        [sprite setScale:0.05];
        sprite.position = CGPointMake(arc4random_uniform(320), arc4random_uniform(568));
        sprite.colorBlendFactor = 1.;
        sprite.color = [UIColor whiteColor];
        [self addChild:sprite];
    }
    
    self.sprites = [NSArray arrayWithArray:self.children];
}
-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
