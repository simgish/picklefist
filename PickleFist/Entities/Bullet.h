//
//  Bullet.h
//  PickleFist
//
//  Created by Ryan Doughty on 4/10/14.
//  Copyright (c) 2014 Ryan Doughty. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "Entity.h"

typedef NS_ENUM(int32_t, BulletType)
{
    BulletTypePlayer = 0,
    BulletTypeEnemy
};

@interface Bullet : Entity

@property (assign) BulletType bulletType;

-(instancetype)initWithBulletType:(BulletType)bulletType;
- (void)configureCollisionBody;

@end
