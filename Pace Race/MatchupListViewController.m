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
@interface MatchupListViewController ()

@end

@implementation MatchupListViewController
@synthesize segmentControl;
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
    if(segmentControl.selectedSegmentIndex == 0){
        return [self.objects count];
        }
        else if(segmentControl.selectedSegmentIndex == 1){
            return [self.groups count];
        }else{
            return 5;
        }
    
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (segmentControl.selectedSegmentIndex == 0) {
        NSManagedObject *object = [self.objects objectAtIndex:indexPath.row];
        cell.textLabel.text = [object valueForKey:@"username"];
        cell.detailTextLabel.text = [object valueForKey:@"location"];
    }
    else if(segmentControl.selectedSegmentIndex == 1) {
        NSManagedObject *groups = [self.groups objectAtIndex:indexPath.row];
        cell.textLabel.text = [groups valueForKey:@"groups_id"];
    }
    
    
    
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
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)segmenter:(id)sender {

    
    [self.tableView reloadData];
    [self refreshTable];
}
@end

