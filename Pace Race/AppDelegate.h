//
//  AppDelegate.h
//  Pace Race
//
//  Created by Craig Hewitt on 8/8/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FacebookSDK/FacebookSDK.h>
#import "StackMob.h"
@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
// Assuming your variable is declared SMClient *client;
@property (strong, nonatomic) SMClient *client;
@property (strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (strong, nonatomic) SMCoreDataStore *coreDataStore;
@property (strong, nonatomic) ViewController *viewController;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@end
