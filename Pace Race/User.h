//
//  User.h
//  Pace Race
//
//  Created by Craig Hewitt on 9/12/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "StackMob.h"


@interface User : SMUserManagedObject
@property (nonatomic, retain) NSString * username;
@property (nonatomic, retain) NSDate * createddate;
@property (nonatomic, retain) NSDate * lastmoddate;
- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context;

@end
