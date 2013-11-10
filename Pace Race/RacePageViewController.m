//
//  RacePageViewController.m
//  Pace Race
//
//  Created by Craig Hewitt on 11/1/13.
//  Copyright (c) 2013 Craig Hewitt. All rights reserved.
//

#import "RacePageViewController.h"
#import "MainViewController.h"
#import "SoloRunViewController.h"

@interface RacePageViewController ()
{
    int page;
}

@end

@implementation RacePageViewController
@synthesize scrollView, pageControl;
- (BOOL)automaticallyForwardAppearanceAndRotationMethodsToChildViewControllers {
	return NO;
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
    self. dataSource = self;

}

- (void)viewWillDisappear:(BOOL)animated {
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewWillDisappear:animated];
	}
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewDidDisappear:animated];
	}
	[super viewDidDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewDidAppear:animated];
	}
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
    
	for (NSUInteger i =0; i < [self.childViewControllers count]; i++) {
		[self loadScrollViewWithPage:i];
	}
    
	self.pageControl.currentPage = 0;
	page = 0;
	[self.pageControl setNumberOfPages:[self.childViewControllers count]];
    
	UIViewController *viewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
	if (viewController.view.superview != nil) {
		[viewController viewWillAppear:animated];
	}
    
	self.scrollView.contentSize = CGSizeMake(scrollView.frame.size.width * [self.childViewControllers count], scrollView.frame.size.height);
}

- (void)loadScrollViewWithPage:(int)page {
    if (page < 0)
        return;
    if (page >= [self.childViewControllers count])
        return;
    
	// replace the placeholder if necessary
    UIViewController *controller = [self.childViewControllers objectAtIndex:page];
    if (controller == nil) {
		return;
    }
    
	// add the controller's view to the scroll view
    if (controller.view.superview == nil) {
        CGRect frame = self.scrollView.frame;
        frame.origin.x = frame.size.width * page;
        frame.origin.y = 0;
        controller.view.frame = frame;
        [self.scrollView addSubview:controller.view];
    }
}
// At the begin of scroll dragging, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

// At the end of scroll animation, reset the boolean used when scrolls originate from the UIPageControl
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    pageControlUsed = NO;
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    UIViewController *oldViewController = [self.childViewControllers objectAtIndex:page];
    UIViewController *newViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
    [oldViewController viewDidDisappear:YES];
    [newViewController viewDidAppear:YES];
    
    page = self.pageControl.currentPage;
}

- (IBAction)changePage:(id)sender {
    int page = ((UIPageControl *)sender).currentPage;
    
    // update the scroll view to the appropriate page
    CGRect frame = self.scrollView.frame;
    frame.origin.x = frame.size.width * page;
    frame.origin.y = 0;
    
    UIViewController *oldViewController = [self.childViewControllers objectAtIndex:page];
    UIViewController *newViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
    [oldViewController viewWillDisappear:YES];
    [newViewController viewWillAppear:YES];
    
    [self.scrollView scrollRectToVisible:frame animated:YES];
    
    // Set the boolean used when scrolls originate from the UIPageControl. See scrollViewDidScroll: above.
    pageControlUsed = YES;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    // We don't want a "feedback loop" between the UIPageControl and the scroll delegate in
    // which a scroll event generated from the user hitting the page control triggers updates from
    // the delegate method. We use a boolean to disable the delegate logic when the page control is used.
    if (pageControlUsed || rotating) {
        // do nothing - the scroll was initiated from the page control, not the user dragging
        return;
    }
    
    // Switch the indicator when more than 50% of the previous/next page is visible
    CGFloat pageWidth = self.scrollView.frame.size.width;
    int page = floor((self.scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
    if (self.pageControl.currentPage != page) {
        UIViewController *oldViewController = [self.childViewControllers objectAtIndex:self.pageControl.currentPage];
        UIViewController *newViewController = [self.childViewControllers objectAtIndex:page];
        [oldViewController viewWillDisappear:YES];
        [newViewController viewWillAppear:YES];
        self.pageControl.currentPage = page;
        [oldViewController viewDidDisappear:YES];
        [newViewController viewDidAppear:YES];
        page = page;
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-    (UIViewController    *) PageViewController: (UIPageViewController    *) PageViewController viewControllerAfterViewController: (UIViewController    *) ViewController    {
    
    UIViewController    * NextViewController    =    nil;
    
    if    (ViewController    ==    self. MainViewController)    {
        NextViewController    =    self. SoloRunViewController;
    }
    
    return    NextViewController;
}

-    (UIViewController    *) PageViewController: (UIPageViewController    *) PageViewController viewControllerBeforeViewController: (UIViewController    *) ViewController    {
    UIViewController    * prevViewController    =    nil;
    
    if    (ViewController    ==    self. SoloRunViewController)    {
        prevViewController    =    self. MainViewController;
    }
    
    return    prevViewController;
}
@end
