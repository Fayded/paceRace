//
//  LoginViewController.m
//  Pace Race
//
//  Created by Craig Hewitt on 8/24/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import "LoginViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"
#import "User.h"
#import "SWRevealViewController.h"


@interface LoginViewController ()

@end

@implementation LoginViewController

@synthesize managedObjectContext = _managedObjectContext;
@synthesize usernameField = _usernameField;
@synthesize passwordField = _passwordField;
@synthesize client = _client;
@synthesize statusLabel = _statusLabel;


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //sidebar setup
    // Change button color
    _sidebarButton.tintColor = [UIColor colorWithWhite:0.96f alpha:0.2f];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    //coredata setup
    self.managedObjectContext = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
    
    self.client = [SMClient defaultClient];
    
    self.usernameField.delegate = self;
    self.passwordField.delegate = self;
}

- (void)viewDidUnload
{
    [self setUsernameField:nil];
    [self setPasswordField:nil];
    [self setStatusLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)createUser:(id)sender {
    
    User *newUser = [[User alloc] initIntoManagedObjectContext:self.managedObjectContext];
    
    [newUser setValue:self.usernameField.text forKey:[newUser primaryKeyField]];
    [newUser setPassword:self.passwordField.text];
    
    [self.managedObjectContext saveOnSuccess:^{
        
        NSLog(@"You created a new user object!");
        
    } onFailure:^(NSError *error) {
        
        [self.managedObjectContext deleteObject:newUser];
        [newUser removePassword];
        NSLog(@"There was an error! %@", error);
        
    }];
}

- (IBAction)login:(id)sender {
    
    [self.client loginWithUsername:self.usernameField.text password:self.passwordField.text onSuccess:^(NSDictionary *results) {
        
        NSLog(@"Login Success %@",results);
        
        /* Uncomment the following if you are using Core Data integration and want to retrieve a managed object representation of the user object.  Store the resulting object or object ID for future use.
         
         Be sure to declare variables you are referencing in this block with the __block storage type modifier, including the managedObjectContext property.
         */
        /*
         // Edit entity name and predicate if you are not using the default user schema with username primary key field.
         NSFetchRequest *userFetch = [[NSFetchRequest alloc] initWithEntityName:@"User"];
         [userFetch setPredicate:[NSPredicate predicateWithFormat:@"username == %@", [results objectForKey:@"username"]]];
         [self.managedObjectContext executeFetchRequest:userFetch onSuccess:^(NSArray *results) {
         NSManagedObject *userObject = [results lastObject];
         // Store userObject somewhere for later use
         NSLog(@"Fetched user object: %@", userObject);
         } onFailure:^(NSError *error) {
         NSLog(@"Error fetching user object: %@", error);
         }];
         */
        
        
    } onFailure:^(NSError *error) {
        
        NSLog(@"Login Fail: %@",error);
        
    }];
}

- (IBAction)checkStatus:(id)sender {
    
    if([self.client isLoggedIn]) {
        
        [self.client getLoggedInUserOnSuccess:^(NSDictionary *result) {
            self.statusLabel.text = [NSString stringWithFormat:@"Hello, %@", [result objectForKey:@"username"]];
        } onFailure:^(NSError *error) {
            NSLog(@"No user found");
        }];
        
    } else {
        self.statusLabel.text = @"Nope, not Logged In";
    }
    
}

- (IBAction)logout:(id)sender {
    
    [self.client logoutOnSuccess:^(NSDictionary *result) {
        NSLog(@"Success, you are logged out");
    } onFailure:^(NSError *error) {
        NSLog(@"Logout Fail: %@",error);
    }];
}
@end
