//
//  CreateGroupViewController.m
//  Pace Race
//
//  Created by Craig Hewitt on 10/1/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import "CreateGroupViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"
#import "Groups.h"
@interface CreateGroupViewController ()

@end

@implementation CreateGroupViewController
- (AppDelegate *)appDelegate {
    return (AppDelegate *)[[UIApplication sharedApplication] delegate];
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
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    self.groupName.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}
- (IBAction)createGroupButton:(id)sender {
   
    NSManagedObject *newGroup = [NSEntityDescription insertNewObjectForEntityForName:@"Groups" inManagedObjectContext:self.managedObjectContext];
    
    [newGroup setValue:self.groupName.text forKey:@"groups_id"];
    [newGroup setValue:self.]
    //[newGroup setValue:[newGroup assignObjectId] forKey:[newGroup primaryKeyField]];
    
    [self.managedObjectContext saveOnSuccess:^{
        NSLog(@"You created a new object!");
    } onFailure:^(NSError *error) {
        NSLog(@"There was an error! %@", error);
    }];
    }
- (IBAction)dismissModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
