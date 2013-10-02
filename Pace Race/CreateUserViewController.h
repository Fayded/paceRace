//
//  CreateUserViewController.h
//  Pace Race
//
//  Created by Craig Hewitt on 9/12/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CreateUserViewController : UIViewController<UITextFieldDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (weak, nonatomic) IBOutlet UITextField *usernameField;

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
- (IBAction)dismissModal:(id)sender;

- (IBAction)createUser:(id)sender;
@end
