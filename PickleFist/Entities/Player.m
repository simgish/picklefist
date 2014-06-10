//
//  Player.m
//  PickleFist
//
//  Created by Ryan Doughty on 4/2/14.
//  Copyright (c) 2014 Ryan Doughty. All rights reserved.
//

#import "Player.h"

@interface Player()

@end


@implementation Player

-(instancetype)init {
    if (self = [super initWithImageNamed:@"orange_ship"]) {
        self.zPosition = 9999;
        [self configureCollisionBody];
    }
    
    return self;
}

-(void)configureCollisionBody {
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = EntityCategoryPlayer;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = EntityCategoryAsteroid;
}

@end
