//
//  Store.h
//  Pace Race
//
//  Created by Craig Hewitt on 10/2/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Store : NSObject
{
    NSString *loggedInUsername;

}
@property (nonatomic, strong) NSString* loggedInUsername;

+ (Store *) sharedStore;
@end
