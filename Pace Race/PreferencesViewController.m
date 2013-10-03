//
//  PreferencesViewController.m
//  Pace Race
//
//  Created by Craig Hewitt on 10/3/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import "PreferencesViewController.h"
#import "SWRevealViewController.h"

@interface PreferencesViewController ()
@end

@implementation PreferencesViewController
{
    NSArray *preferencesList;
}
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    preferencesList = [NSArray arrayWithObjects:@"Profile", @"Sharing", @"Reminders", @"Gear", @"Goals", @"Races", nil];
    
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [preferencesList objectAtIndex:indexPath.row];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [preferencesList count];
}

@end
