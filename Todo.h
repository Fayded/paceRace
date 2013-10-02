//
//  Todo.h
//  Pace Race
//
//  Created by Craig Hewitt on 9/16/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Todo : NSManagedObject

@property (nonatomic, retain) id location;
@property (nonatomic, retain) NSString * todoId;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDate * createddate;
@property (nonatomic, retain) NSDate * lastmoddate;
@end
