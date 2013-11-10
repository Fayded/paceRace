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
#import "LoginViewController.h"
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
-(void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
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
    
    cell.nameLabel.text = [object valueForKey:@"username"];
    
    //cell.thumbnailImageView.image = [UIImage imageNamed:[thumbnails objectAtIndex:indexPath.row]];
    cell.averageDistanceLabel.text = [object valueForKey:@"avgDistance"];
    cell.averagePaceLabel.text = [object valueForKey:@"avgPace"];
    //cell.nextRunLabel.text = [[object valueForKey:@"nextRunDate"] stringValue];
    cell.raceCountLabel.text = [[object valueForKey:@"raceCount"] stringValue];
    cell.raceWinningPercentage.text = [[object valueForKey:@"raceWinningPercentage"] stringValue];
    return cell;
    
    
}

//need to populate fetrequest with dictionary of all User attributes

- (void) refreshTable {
    
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"User" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    [fetchRequest setResultType:NSDictionaryResultType];
    [fetchRequest setReturnsDistinctResults:YES];
    [fetchRequest setPropertiesToFetch:[NSArray arrayWithObjects:@"username", @"avgPace", @"avgDistance", @"nextRunDate", @"raceCount", @"raceWinningPercentage", nil]];
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"username" ascending:YES];
    NSArray *sortDescriptors = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    [self.managedObjectContext executeFetchRequest:fetchRequest onSuccess:^(NSArray *results) {
        [self.refreshControl endRefreshing];
        NSLog(@"results are: %@", results);
        self.objects = results;
        [self.tableView reloadData];
        
    } onFailure:^(NSError *error) {
        
        [self.refreshControl endRefreshing];
        NSLog(@"An error %@, %@", error, [error userInfo]);
    }];
    
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
    [self refreshTable];
    [self.tableView reloadData];
}
@end
