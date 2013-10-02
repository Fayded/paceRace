//
//  CreateUserViewController.m
//  Pace Race
//
//  Created by Craig Hewitt on 9/12/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import "CreateUserViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"
#import "User.h"

@interface CreateUserViewController ()

@end

@implementation CreateUserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
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
    
    self.managedObjectContext = [[self.appDelegate coreDataStore] contextForCurrentThread];
    
    /*
     Set this controller file to be the delegate for the text fields.
     */
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)viewDidUnload
{
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

/*
 The textFieldShouldReturn: method will get called and dismiss the soft keyboard when the user presses the return button.
 */
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)dismissModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)createUser:(id)sender {
    /*
     We instantiate an instance of User using our custom init method.
     */
    User *newUser = [[User alloc] initIntoManagedObjectContext:self.managedObjectContext];
    
    /*
     We set the value of the primary key field to what the user has typed in the usernameField text field.
     [newUser sm_primaryKeyField] will return the userPrimaryKeyField value from the referenced SMClient instance.
     */
    [newUser setValue:self.usernameField.text forKey:[newUser primaryKeyField]];
    
    /*
     SMUserManagedObject provides the setPassword: method and should be the only method used
     to set a password for a user object.
     */
    [newUser setPassword:self.passwordField.text];
    
    [self.managedObjectContext saveOnSuccess:^{
        
        NSLog(@"You created a new user object!");
        [self dismissViewControllerAnimated:YES completion:nil];

    } onFailure:^(NSError *error) {
        
        /*
         One optional way to handle an unsuccessful save of a managed object is to delete the object altogether
         from the managed object context.  For example, you probably won't try to keep saving a user object that
         returns a duplicate key error. If you delete a user managed object that hasn't been saved yet, you must
         remove the password you originally set using the removePassword: method.
         */
        
        [self.managedObjectContext deleteObject:newUser];
        [newUser removePassword];
        NSLog(@"There was an error! %@", error);
        
    }];
    
}

@end