//
//  TwitterLoginViewController.m
//  Pace Race
//
//  Created by Craig Hewitt on 9/11/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import "TwitterLoginViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"
#import "SMTwitterCredentials.h"
#import "SWRevealViewController.h"


@interface TwitterLoginViewController ()
@property (nonatomic, strong) SMTwitterCredentials *twitterCredentials;

@end

@implementation TwitterLoginViewController

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
    // Do any additional setup after loading the view, typically from a nib.
    
    self.managedObjectContext = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
    
    self.twitterCredentials = [[SMTwitterCredentials alloc] initWithTwitterConsumerKey:@"RsHYYeerMMl3pTlncszg" secret:@"naqtTymDfddKpK3axqaHStKKmI9yeiT8EyOsEDcvD0"];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)TwitterDismissModal:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (IBAction)loginUser:(id)sender {
    
    // This will usually return true if you are using the simulator, even if there are no accounts
    if (self.twitterCredentials.twitterAccountsAvailable) {
        
        /*
         SMTwitterCredentials method for Twitter auth workflow.
         Pass nil for username to show a pop-up to the user and allow them to select from the available accounts.
         Pass an account username to search and use that account without any user interaction. Great technique for a "stay logged in" feature
         */
        [self.twitterCredentials retrieveTwitterCredentialsForAccount:nil onSuccess:^(NSString *token, NSString *secret, NSDictionary *fullResponse) {
            
            /*
             StackMob method to login with Twitter token and secret.  A StackMob user will be created with the username provided if one doesn't already exist attached to the provided credentials.
             */
            [[SMClient defaultClient] loginWithTwitterToken:token twitterSecret:secret createUserIfNeeded:YES usernameForCreate:fullResponse[@"screen_name"] onSuccess:^(NSDictionary *result) {
                NSLog(@"Successful Login with Twitter: %@", result);
                [self dismissViewControllerAnimated:YES completion:nil];

            } onFailure:^(NSError *error) {
                NSLog(@"Login failed: %@", error);
            }];
            
        } onFailure:^(NSError *error) {
            NSLog(@"Twitter Auth Error: %@", error);
            
        }];
        
    } else {
        // Handle no Twitter accounts available on device
        NSLog(@"No Tiwtter accounts found on device.");
    }
    
}

- (IBAction)checkStatus:(id)sender {
    
    NSLog(@"%@",[[SMClient defaultClient] isLoggedIn] ? @"Logged In" : @"Logged Out");
    
    /*
     StackMob method to grab the currently logged in user's Twitter information.
     This assumes the user was logged in user Twitter credentials.
     */
    [[SMClient defaultClient] getLoggedInUserTwitterInfoOnSuccess:^(NSDictionary *result) {
        NSLog(@"Logged In User Twitter Info, %@", result);
    } onFailure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
}

- (IBAction)logoutUser:(id)sender {
    
    /*
     StackMob method to logout the currently logged in user.
     */
    [[SMClient defaultClient] logoutOnSuccess:^(NSDictionary *result) {
        NSLog(@"Logged out.");
    } onFailure:^(NSError *error) {
        NSLog(@"error %@", error);
    }];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
