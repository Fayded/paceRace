//
//  MatchupListViewController.h
//  Pace Race
//
//  Created by Craig Hewitt on 9/13/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
#import <CoreData/CoreData.h>
@interface MatchupListViewController : UITableViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSMutableArray *searchResults;


@property (nonatomic, copy) NSString *savedSearchTerm;
@property (nonatomic) NSInteger savedScopeButtonIndex;
@property (nonatomic) BOOL searchWasActive;

@property (strong, nonatomic) NSArray *objects;
@property (strong, nonatomic) NSArray *avgDistanceObjects;
@property (strong, nonatomic) NSArray *avgPaceObjects;
@property (strong, nonatomic) NSArray *nextRunObjects;
@property (strong, nonatomic) NSArray *avgDistValues;
@property (strong, nonatomic) NSArray *avgPaceValues;

@property (strong, nonatomic) NSArray *groups;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;

- (IBAction)refreshTableData:(id)sender;
@end
