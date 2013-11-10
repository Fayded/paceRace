//
//  RacePageViewController.h
//  Pace Race
//
//  Created by Craig Hewitt on 11/1/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SoloRunViewController.h"
#import "MainViewController.h"
@interface RacePageViewController : UIPageViewController <UIPageViewControllerDataSource>
{
    bool pageControlUsed;
    bool rotating;
}
@property (nonatomic, strong) IBOutlet UIScrollView *scrollView;
@property (nonatomic, strong) IBOutlet UIPageControl *pageControl;

- (IBAction)changePage:(id)sender;
@property (nonatomic, retain) SoloRunViewController *SoloRunViewController;
@property (nonatomic, retain) MainViewController *MainViewController;
@end
