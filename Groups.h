//
//  Groups.h
//  Pace Race
//
//  Created by Craig Hewitt on 10/1/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Groups : NSManagedObject

@property (nonatomic, retain) NSString * groups_id;
@property (nonatomic, retain) NSString * members;
@property (nonatomic, retain) NSString * runner;

@property (nonatomic, retain) NSDate *nextRun;
- (id)initIntoManagedObjectContext:(NSManagedObjectContext *)context;

@end
