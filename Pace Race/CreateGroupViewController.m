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
    /*
     We instantiate an instance of User using our custom init method.
     */
    Groups *newGroup = [[Groups alloc] initIntoManagedObjectContext:self.managedObjectContext];
    
    /*
     We set the value of the primary key field to what the user has typed in the usernameField text field.
     [newUser sm_primaryKeyField] will return the userPrimaryKeyField value from the referenced SMClient instance.
     */
    [newGroup setValue:self.groupName.text forKey:[newGroup primaryKeyField]];
    
   
    
    [self.managedObjectContext saveOnSuccess:^{
        
        NSLog(@"You created a new Group!");
        [self dismissViewControllerAnimated:YES completion:nil];
        
    } onFailure:^(NSError *error) {
        
        /*
         One optional way to handle an unsuccessful save of a managed object is to delete the object altogether
         from the managed object context.  For example, you probably won't try to keep saving a user object that
         returns a duplicate key error. If you delete a user managed object that hasn't been saved yet, you must
         remove the password you originally set using the removePassword: method.
         */
        
        [self.managedObjectContext deleteObject:newGroup];
        NSLog(@"There was an error! %@", error);
        
    }];
}
- (IBAction)dismissModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}
@end
