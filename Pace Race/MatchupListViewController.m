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
#import "Groups.h"
#import "User.h"
#import "LoginViewController.h"

@interface MatchupListViewController ()

@property (nonatomic, strong) NSDateFormatter *dateFormatter;

@end

@implementation MatchupListViewController

@synthesize fetchedResultsController, searchResults;
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
    
    // Change button color
    _sidebarButton.tintColor = [UIColor greenColor];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
    [self setupFetchedResultsController];
    
    self.searchResults = [NSMutableArray arrayWithCapacity:[[self.fetchedResultsController fetchedObjects] count]];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    NSIndexPath *selectedIndexPath = [self.tableView indexPathForSelectedRow];
    [self.tableView deselectRowAtIndexPath:selectedIndexPath animated:YES];
    [self.tableView reloadData];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
	self.searchResults = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
- (NSDateFormatter *)dateFormatter {
    if (!_dateFormatter) {
        _dateFormatter = [[NSDateFormatter alloc] init];
        [_dateFormatter setDateStyle:NSDateFormatterShortStyle];
    }
    
    return _dateFormatter;
}
- (void)configureCell:(MatchupCell *)cell forEntry:(User *)entry {
    
    cell.nameLabel.text = entry.username;
    cell.averageDistanceLabel.text = [entry valueForKey:@"avgDistance"];
    cell.averagePaceLabel.text = [entry valueForKey:@"avgPace"];
    cell.nextRunLabel.text = [self.dateFormatter stringFromDate:entry.nextRunDate];
    cell.raceCountLabel.text = [[entry valueForKey:@"raceCount"] stringValue];
    cell.raceWinningPercentage.text = [[entry valueForKey:@"raceWinningPercentage"] stringValue];
}

- (NSFetchRequest *)fetchRequest {
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"User"];
    NSSortDescriptor *sortByUsername = [NSSortDescriptor sortDescriptorWithKey:@"username" ascending:YES];
    [fetchRequest setSortDescriptors:@[sortByUsername]];
    return fetchRequest;
}

- (void)setupFetchedResultsController {
    self.fetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:[self fetchRequest]
                                                                        managedObjectContext:self.managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:@"UserSearch"];
    self.fetchedResultsController.delegate = self;
    
    NSError *error = nil;
    if (![self.fetchedResultsController performFetch:&error]) {
        NSLog(@"ERROR: %@", error);
        [[[UIAlertView alloc] initWithTitle:@"Error"
                                    message:@"Couldn't fetch entries :("
                                   delegate:nil
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        return [self.searchResults count];
    }
	else
	{
        return [[[self.fetchedResultsController sections] objectAtIndex:section] numberOfObjects];
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"MatchupCell";
    
    MatchupCell *cell = (MatchupCell *)[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MatchupCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    User *item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [self configureCell:cell forEntry:item];
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
	{
        item = [self.searchResults objectAtIndex:indexPath.row];
    }
	else
	{
        item = [self.fetchedResultsController objectAtIndexPath:indexPath];
    }

    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    __block NSString * loggedInUsername;
    //get user info and ensure they're logged in
    [[SMClient defaultClient] getLoggedInUserOnSuccess:^(NSDictionary *userInfo){
        // Result contains a dictionary representation of the user object
        NSLog(@"logged in user info: %@", userInfo);
        loggedInUsername = [userInfo objectForKey:@"username"];
    } onFailure:^(NSError *notLoggedIn){
        // Error
        
    }];
    
    //access nameLable from custom MatchupCell class
    MatchupCell *customCell = (MatchupListViewController*)[tableView cellForRowAtIndexPath:indexPath];
    NSString *labelText = [[customCell nameLabel] text];
    
    //create new object in Entity "Groups"
    NSManagedObject *newMatchup = [NSEntityDescription insertNewObjectForEntityForName:@"Groups" inManagedObjectContext:self.managedObjectContext];
    
    //populate object with names of runners (logged in user and selected row username)
    [newMatchup setValue:labelText forKey:@"members"];
    [newMatchup setValue:loggedInUsername forKey:@"runner"];
    [newMatchup setValue:[newMatchup assignObjectId] forKey:[newMatchup primaryKeyField]];
    [self.managedObjectContext saveOnSuccess:^{
    } onFailure:^(NSError *error) {
    }];
    
    //set time for next run from nextRun in User entity from selected user
    if ([[SMClient defaultClient] isLoggedIn ])
    {
        UIAlertView *messageAlert = [[UIAlertView alloc]
                                     initWithTitle:@"Matchup Set" message:@"You're set to race.  Good Luck." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        
        // Display Alert Message
        [messageAlert show];
    }
    else{
        UIAlertView *notLoggedInMesage = [[UIAlertView alloc] initWithTitle:@"Not Logged In" message:@"Please Log In To Set Matchup" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles: nil];
        [notLoggedInMesage show];
    }
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)refreshTableData:(id)sender {
    [self.tableView reloadData];
}


#pragma mark Content Filtering

- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope
{
	NSLog(@"Previous Search Results were removed.");
	[self.searchResults removeAllObjects];
    
	NSPredicate *pre = [NSPredicate predicateWithFormat:@"username CONTAINS [cd] %@", searchText];
    self.searchResults = [[self.fetchedResultsController fetchedObjects] filteredArrayUsingPredicate:pre];
}



#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end
