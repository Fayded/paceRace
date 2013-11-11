//
//  User.m
//  Pace Race
//
//  Created by Craig Hewitt on 9/12/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import "User.h"


@implementation User

@dynamic username;
@dynamic createddate;
@dynamic lastmoddate;
@dynamic avgDistance, avgPace, visibleUsername, nextRunDate, nextRunDistance, raceCount, raceWinningPercentage;

/*
- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context {
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:context];
    self = [super initWithEntity:entity insertIntoManagedObjectContext:context];
    
    if (self) {
        // assign local variables and do other init stuff here
    }
    
    return self;
}
*/
@end
