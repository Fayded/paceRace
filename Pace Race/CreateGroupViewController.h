//
//  CreateGroupViewController.h
//  Pace Race
//
//  Created by Craig Hewitt on 10/1/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateGroupViewController : UIViewController <UITextFieldDelegate>
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
- (IBAction)createGroupButton:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *groupName;
- (IBAction)dismissModal:(id)sender;

@end
