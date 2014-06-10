//
//  Entity.h
//  PickleFist
//
//  Created by Ryan Doughty on 4/12/14.
//  Copyright (c) 2014 Ryan Doughty. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef NS_OPTIONS(uint32_t, EntityCategory)
{
    EntityCategoryPlayer       = 1 << 0,
    EntityCategoryAsteroid     = 1 << 1,
    EntityCategoryEnemy        = 1 << 2,
    EntityCategoryPlayerBullet = 1 << 3,
    EntityCategoryEnemyBullet  = 1 << 4
};

@interface Entity : SKSpriteNode

-(void)cleanup;

@end
