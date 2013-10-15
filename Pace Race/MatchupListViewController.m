//
//  MatchupListViewController.m
//  Pace Race
//
//  Created by Craig Hewitt on 9/13/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import "MatchupListViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"
#import "MatchupCell.h"
@interface MatchupListViewController ()

@end

@implementation MatchupListViewController
{
    NSArray *searchResults;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
  

    // Change button color
    _sidebarButton.tintColor = [UIColor greenColor];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc]
                                        init];
    [refreshControl addTarget:self action:@selector(refreshTable) forControlEvents:UIControlEventValueChanged];
    
    self.refreshControl  = refreshControl;
    
    [refreshControl beginRefreshing];
    
    [self refreshTable];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [searchResults count];
        
    }
    else {
        return [self.objects count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{

    static NSString *simpleTableIdentifier = @"MatchupCell";
    
    MatchupCell *cell = (MatchupCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MatchupCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    NSManagedObject *object = [self.objects objectAtIndex:indexPath.row];
    //NSManagedObject *runObject = [self.avgDistValues objectAtIndex:indexPath.row];
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        cell.nameLabel.text = [searchResults objectAtIndex:indexPath.row];
    } else {
    cell.nameLabel.text = [object valueForKey:@"username"];
    }
    //cell.thumbnailImageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    //cell.averageDistanceLabel.text = [runObject valueForKey:@"avgDistance"];
    //cell.averagePaceLabel.text = [runObject valueForKey:@"avgPace"];
    //cell.nextRunLabel.text = @"next run placeholder";
    return cell;
    
    
    return cell;
}

- (void) refreshTable {
    
 
        NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
        
        NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
        [fetchRequest setEntity:entity];
        // Edit the sort key as appropriate.
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"username" ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
        
        [fetchRequest setSortDescriptors:sortDescriptors];
        [self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
            [self.refreshControl endRefreshing];
            self.objects = results;
            [self.tableView reloadData];
            
        } onFailure:^(NSError *error) {
            
            [self.refreshControl endRefreshing];
            NSLog(@"An error %@, %@", error, [error userInfo]);
        }];
  /*
    NSFetchRequest *fetchRunDataRequest = [[NSFetchRequest alloc] init];
    
    NSEntityDescription *runDataEntity = [NSEntityDescription entityForName:@"RunData" inManagedObjectContext:self.managedObjectContext];
    [fetchRunDataRequest setEntity:runDataEntity];
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortRunDataDescriptor = [[NSSortDescriptor alloc] initWithKey:@"avgDistance" ascending:YES];
    NSArray *sortRunDataDescriptors = [NSArray arrayWithObjects:sortRunDataDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortRunDataDescriptors];
    [self.managedObjectContext executeFetchRequest:fetchRunDataRequest onSuccess:^(NSArray *runDataResults) {
        [self.refreshControl endRefreshing];
        self.avgDistValues = runDataResults;
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error) {
        
        [self.refreshControl endRefreshing];
        NSLog(@"An error %@, %@", error, [error userInfo]);
    }];
    */
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
    NSPredicate *resultPredicate = [NSPredicate
                                    predicateWithFormat:@"SELF contains[cd] %@",
                                    searchText];
    
    searchResults = [self.objects filteredArrayUsingPredicate:resultPredicate];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller
shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString
                               scope:[[self.searchDisplayController.searchBar scopeButtonTitles]
                                      objectAtIndex:[self.searchDisplayController.searchBar
                                                     selectedScopeButtonIndex]]];
    
    return YES;
}
@end

