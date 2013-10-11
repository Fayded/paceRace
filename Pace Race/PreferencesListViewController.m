//
//  PreferencesListViewController.m
//  Pace Race
//
//  Created by Craig Hewitt on 10/3/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import "PreferencesListViewController.h"
#import "SWRevealViewController.h"

@interface PreferencesListViewController ()

@end

@implementation PreferencesListViewController
{
    NSArray *preferencesList;

}
- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    preferencesList = [NSArray arrayWithObjects:@"Username", @"Location", @"Height", @"Weight", @"Age", @"Gender", nil];
    
    // Change button color
    _sidebarButton.tintColor = [UIColor greenColor];
    
    
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

                                      
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
    {
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
 
        NSString *CellIdentifier = [preferencesList objectAtIndex:indexPath.row];
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
        
        /*
        NSString * PRUserAgeText = [defaults objectForKey:@"PRUserAge"];
        NSString * PRUserGenderText = [defaults objectForKey:@"PRUserGender"];
        NSString * PRUserHeightText = [defaults objectForKey:@"PRUserHeight"];
        NSString * PRUserWeightText = [defaults objectForKey:@"PRUserWeight"];
        NSString * PRUserLoctionText = [defaults objectForKey:@"PRUserLocation"];

        NSMutableArray *detailList = [NSMutableArray arrayWithObjects: PRUserAgeText, PRUserGenderText, PRUserHeightText, PRUserWeightText, PRUserLoctionText, nil];
        //NSString *detailIdentifier = [detailList objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [detailList objectAtIndex:indexPath.row];
        */
        return cell;
    }
                                      
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
    {
        return [preferencesList count];
        
    }
  /*
- (void) prepareForSegue: (UIStoryboardSegue *) segue sender: (id) sender
    {
        // Set the title of navigation bar by using the menu items
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        UINavigationController *destViewController = (UINavigationController*)segue.destinationViewController;
        destViewController.title = [[preferencesList objectAtIndex:indexPath.row] capitalizedString];
        
        
        if ( [segue.identifier isEqualToString:@"Profile"])
            NSIndexPath *indexPath = [self.tableView indexPathForCell:sender];
        
            
        }
        
    }
   */
/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/



@end
