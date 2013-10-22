//
//  RaceFinishedViewController.m
//  Pace Race
//
//  Created by Craig Hewitt on 9/28/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//
#import <Social/Social.h>

#import "RaceFinishedViewController.h"
#import "SWRevealViewController.h"
#import "AppDelegate.h"
#import "StackMob.h"
@interface RaceFinishedViewController ()

@end

@implementation RaceFinishedViewController
{
    NSString *wrapupTime;
    NSString *wrapupDistance;
    NSString *wrapupPace;
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
        self.managedObjectContext = [[[SMClient defaultClient] coreDataStore] contextForCurrentThread];
    
    //store final times into database
    NSManagedObject *saveRunData = [NSEntityDescription insertNewObjectForEntityForName:@"RunData" inManagedObjectContext:self.managedObjectContext];
    
    [saveRunData setValue:wrapupDistance forKey:@"runDistance"];
    [saveRunData setValue:wrapupPace forKey:@"runPace"];
    [saveRunData setValue:wrapupTime forKey:@"runTime"];


    
    //calculate calories
    
    //aggregate weekly, monthly, annual milage
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//receive prepareForSegue from preceeding VC for final times



- (IBAction)postToFacebook:(id)sender {
    NSString *wrapupStats = [NSString stringWithFormat:@"Training Games with Pace Race! I ran %@ in %@!", wrapupDistance, wrapupTime, nil];
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook]) {
        SLComposeViewController *controller = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [controller setInitialText: wrapupStats];
        [self presentViewController:controller animated:YES completion:Nil];
    }
}

- (IBAction)postToTwitter:(id)sender {
        NSString *wrapupStats = [NSString stringWithFormat:@"Training Games with Pace Race! I ran %@ in %@!", wrapupDistance, wrapupTime, nil];
    if ([SLComposeViewController isAvailableForServiceType:SLServiceTypeTwitter])
    {
        SLComposeViewController *tweetSheet = [SLComposeViewController
                                               composeViewControllerForServiceType:SLServiceTypeTwitter];
        [tweetSheet setInitialText:wrapupStats];
        [self presentViewController:tweetSheet animated:YES completion:nil];
    }
}


@end
