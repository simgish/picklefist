//
//  Bullet.m
//  PickleFist
//
//  Created by Ryan Doughty on 4/10/14.
//  Copyright (c) 2014 Ryan Doughty. All rights reserved.
//

#import "Bullet.h"

@implementation Bullet

-(instancetype)initWithBulletType:(BulletType)bulletType {
    NSString *imageName;
    
    switch(bulletType) {
        case BulletTypePlayer:
            imageName = @"laserBlue";
            break;
        case BulletTypeEnemy:
            imageName = @"redShot";
            break;
        default:
            return nil;
    }
    
    if (self = [super initWithImageNamed:imageName]) {
        self.zPosition = 8888;
        
        _bulletType = bulletType;
    }
    
    return self;
}

-(void)configureCollisionBody {
    self.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:self.size.width/2];
    self.physicsBody.affectedByGravity = NO;
    self.physicsBody.categoryBitMask = _bulletType == BulletTypePlayer ? EntityCategoryPlayerBullet : EntityCategoryEnemyBullet;
    self.physicsBody.collisionBitMask = 0;
    self.physicsBody.contactTestBitMask = _bulletType == BulletTypePlayer ? EntityCategoryAsteroid | EntityCategoryEnemy : EntityCategoryPlayer;
}

-(void)cleanup {
    [self removeFromParent];
}

@end
