//
//  GameScene.m
//  PickleFist
//
//  Created by Ryan Doughty on 4/5/14.
//  Copyright (c) 2014 Ryan Doughty. All rights reserved.
//

#import "GameScene.h"
#import "Constants.h"
#import "Player.h"
#import "Bullet.h"

static const float BG_STARS_VELOCITY = 400.0;
static const float BG_DUST_VELOCITY = 30.0;

static inline CGPoint CGPointAdd(const CGPoint a, const CGPoint b)
{
    return CGPointMake(a.x + b.x, a.y + b.y);
}

static inline CGPoint CGPointMultiplyScalar(const CGPoint a, const CGFloat b)
{
    return CGPointMake(a.x * b, a.y * b);
}


@interface GameScene () <SKPhysicsContactDelegate>{
    Player *player;
    SKNode *bgLayer;
    BOOL hasTouch;
    NSTimeInterval _lastUpdateTime;
    NSTimeInterval _dt;
    NSMutableArray *_playerShots;
    int _shots;
}
@end

@implementation GameScene

-(id)initWithSize:(CGSize)size {
    if (self = [super initWithSize:size]) {
        [self setupScene];
    }
    return self;
}

-(void)setupScene {
    self.anchorPoint = CGPointMake(0.0, 0.0);
    
    bgLayer = [SKNode node];
    [self addChild:bgLayer];
    [self initBackgrounds];
    
    player = [Player node];
    player.position = CGPointMake(self.size.width/2, player.size.height*2);
    [self addChild:player];
    
    [self runAction:[SKAction repeatActionForever:
        [SKAction sequence:@[
            [SKAction performSelector:@selector(spawnPlayerShot) onTarget:self],
                [SKAction waitForDuration:0.1]]]]];
}

-(void)update:(CFTimeInterval)currentTime {
    if (_lastUpdateTime)
    {
        _dt = currentTime - _lastUpdateTime;
    }
    else
    {
        _dt = 0;
    }
    _lastUpdateTime = currentTime;
    
    [self moveBg];
}

-(void)spawnPlayerShot {
    Bullet *bullet = [[Bullet node] initWithBulletType:BulletTypePlayer];
    [bullet configureCollisionBody];
    bullet.position = CGPointMake(player.position.x, player.position.y - 4);
    bullet.alpha = 0;
    [self addChild:bullet];
    
    [bullet runAction:[SKAction fadeAlphaTo:1.0 duration:0.1]];
    SKAction *actionMove = [SKAction moveToY:self.size.height + bullet.size.height duration:0.50];
    SKAction *actionRemove = [SKAction runBlock:^{
        [bullet cleanup];
    }];
    [bullet runAction:
     [SKAction sequence:@[actionMove, actionRemove]]];
    
    _shots++;

}

-(void)initBackgrounds {
    SKSpriteNode *staticbg = [SKSpriteNode spriteNodeWithImageNamed:@"static2"];
    staticbg.anchorPoint = CGPointZero;
    staticbg.position = CGPointMake(0, 0);
    staticbg.name = @"bgStatic";
    staticbg.zPosition = 1;
    [bgLayer addChild:staticbg];
    
    for (int i = 0; i < 2; i++) {
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"starfield"];
        bg.anchorPoint = CGPointZero;
        bg.position = CGPointMake(0, i * bg.size.height);
        bg.zPosition = 2;
        bg.name = @"bg";
        
        [bgLayer addChild:bg];
    }
    for (int i = 0; i < 2; i++) {
        SKSpriteNode *bg = [SKSpriteNode spriteNodeWithImageNamed:@"starfield"];
        bg.anchorPoint = CGPointZero;
        bg.position = CGPointMake(0, i * bg.size.height);
        bg.zPosition = 3;
        bg.name = @"bgdust";
        
        [bgLayer addChild:bg];
    }
}

-(void)moveBg {
    [bgLayer enumerateChildNodesWithName:@"bg" usingBlock: ^(SKNode *node, BOOL *stop)
     {
         SKSpriteNode * bg = (SKSpriteNode *) node;
         CGPoint bgVelocity = CGPointMake(0, -BG_STARS_VELOCITY);
         CGPoint amtToMove = CGPointMultiplyScalar(bgVelocity,_dt);
         bg.position = CGPointAdd(bg.position, amtToMove);
         
         //Checks if bg node is completely scrolled of the screen, if yes then put it at the end of the other node
         if (bg.position.y <= -bg.size.height)
         {
             bg.position = CGPointMake(bg.position.x, bg.position.y + bg.size.height*2);
         }
     }];
    
    [bgLayer enumerateChildNodesWithName:@"bgdust" usingBlock: ^(SKNode *node, BOOL *stop)
     {
         SKSpriteNode * bg = (SKSpriteNode *) node;
         CGPoint bgVelocity = CGPointMake(0, -BG_DUST_VELOCITY);
         CGPoint amtToMove = CGPointMultiplyScalar(bgVelocity,_dt);
         bg.position = CGPointAdd(bg.position, amtToMove);
         
         //Checks if bg node is completely scrolled of the screen, if yes then put it at the end of the other node
         if (bg.position.y <= -bg.size.height)
         {
             bg.position = CGPointMake(bg.position.x, bg.position.y + bg.size.height*2);
         }
     }];
}

-(void)touchesBegan:(NSSet*)touches withEvent:(UIEvent*)event {
    //UITouch* touch = [touches anyObject];

    hasTouch = YES;
}

-(void)touchesMoved:(NSSet*)touches withEvent:(UIEvent*)event {
    if (hasTouch) {
        UITouch* touch = [touches anyObject];
        CGPoint touchLocation = [touch locationInNode:self];
        CGPoint previousLocation = [touch previousLocationInNode:self];

        float newX = player.position.x + (touchLocation.x - previousLocation.x);
        float newY = player.position.y + (touchLocation.y - previousLocation.y);
//        paddleX = MAX(paddleX, player.size.width/2);
//        paddleX = MIN(paddleX, self.size.width - player.size.height/2);
//        paddleY = MAX(paddleY, player.size.height/2);
//        paddleY = MIN(paddleY, self.size.height - player.size.height/2);

        player.position = CGPointMake(newX, newY);
    }
}

-(void)touchesEnded:(NSSet*)touches withEvent:(UIEvent*)event {
    hasTouch = NO;
}


@end
