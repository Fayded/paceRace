//
//  NextRunViewController.m
//  Pace Race
//
//  Created by Craig Hewitt on 8/24/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import "NextRunViewController.h"
#import "SWRevealViewController.h"

@interface NextRunViewController ()

@end

@implementation NextRunViewController

@synthesize dateSelection, runDistance, runDistanceLabel;
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
    
    // Change button color
    _sidebarButton.tintColor = [UIColor greenColor];
    
    // Set the side bar button action. When it's tapped, it'll show up the sidebar.
    _sidebarButton.target = self.revealViewController;
    _sidebarButton.action = @selector(revealToggle:);
    
    // Set the gesture
    [self.view addGestureRecognizer:self.revealViewController.panGestureRecognizer];
    
    //to dismiss keyboard
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
    
    //Set date
    NSDate *selected = [_datepicker date];
    
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateStyle:NSDateFormatterLongStyle];
    
    NSString *selectionString = [[NSString alloc] initWithFormat:@"%@", [dateFormat stringFromDate:selected] ];
    dateSelection.text = selectionString;
    
    [_datepicker setDate:selected animated:YES];
    
    [self.datepicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
    
    //update label with uitext input
    [runDistance addTarget:self action:@selector(textViewDidChange:) forControlEvents:UIControlEventEditingChanged];


}
- (IBAction)datePickerDateChanged:(id)sender {
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"MM-dd-yy hh:mm a"];
    
    NSString *entryDateInString = [outputFormatter stringFromDate:self.datepicker.date];
    
    [[self dateSelection] setText: entryDateInString];
}

- (void)textViewDidChange:(UITextView *)runDistance {
    runDistanceLabel.text = runDistance.text;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//dimiss keyboard when tapping outside of area
-(void)dismissKeyboard {
    [runDistance resignFirstResponder];
}


@end
