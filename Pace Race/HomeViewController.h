//
//  HomeViewController.h
//  Pace Race
//
//  Created by Craig Hewitt on 9/16/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SWRevealViewController.h"
@interface HomeViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIBarButtonItem *sidebarButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *gotoRunScreen;
@property(nonatomic, retain) UIColor *barTintColor;

@end
