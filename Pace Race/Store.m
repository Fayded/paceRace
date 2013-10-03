//
//  Store.m
//  Pace Race
//
//  Created by Craig Hewitt on 10/2/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import "Store.h"

@implementation Store
@synthesize loggedInUsername;

static Store *sharedStore = nil;

//Store* myStore = [Store sharedStore];
+ (Store *) sharedStore {
    @synchronized(self){
        if (sharedStore == nil){
            sharedStore = [[self alloc] init];
        }
    }
    
    return sharedStore;
}
@end
