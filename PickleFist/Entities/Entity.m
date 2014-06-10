//
//  Entity.m
//  PickleFist
//
//  Created by Ryan Doughty on 4/12/14.
//  Copyright (c) 2014 Ryan Doughty. All rights reserved.
//

#import "Entity.h"

@implementation Entity

- (void)cleanup {
    [self removeFromParent];
}

@end
