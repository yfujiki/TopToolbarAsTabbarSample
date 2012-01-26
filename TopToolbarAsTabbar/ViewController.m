//
//  ViewController.m
//  TopToolbarAsTabbar
//
//  Created by Yuichi Fujiki on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "ViewController.h"
#import "AppleViewController.h"
#import "WindowsViewController.h"

@implementation ViewController
@synthesize toolBar;
@synthesize appleNavigationController, windowsNavigationController;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    AppleViewController * appleVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"appleVC"];
    self.appleNavigationController = [[UINavigationController alloc] initWithRootViewController:appleVC];
    [self addChildViewController:self.appleNavigationController];
    // [self.appleNavigationController setNavigationBarHidden:YES];
    [self.appleNavigationController didMoveToParentViewController:self];
    
    WindowsViewController * windowsVC = [[UIStoryboard storyboardWithName:@"MainStoryboard" bundle:nil] instantiateViewControllerWithIdentifier:@"windowsVC"];
    self.windowsNavigationController = [[UINavigationController alloc] initWithRootViewController:windowsVC];
    [self addChildViewController:self.windowsNavigationController];
    // [self.windowsNavigationController setNavigationBarHidden:YES];
    [self.windowsNavigationController didMoveToParentViewController:self];
    
    UIBarButtonItem * sideSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    [sideSpace setWidth:325];
    
    UIButton * appleButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [appleButton setBackgroundImage:[UIImage imageNamed:@"apple-icon.png"] forState:UIControlStateNormal];
    [appleButton setTag:0];
    [appleButton addTarget:self action:@selector(toggleTab:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem * appleBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:appleButton];
    
    UIButton * windowsButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 32, 32)];
    [windowsButton setBackgroundImage:[UIImage imageNamed:@"windows-icon.png"] forState:UIControlStateNormal];
    [windowsButton setTag:1];
    [windowsButton addTarget:self action:@selector(toggleTab:) forControlEvents:UIControlEventTouchUpInside];    
    UIBarButtonItem * windowsBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:windowsButton];
    
    [self.toolBar setItems:[NSArray arrayWithObjects:sideSpace, appleBarButtonItem, windowsBarButtonItem, sideSpace, nil] animated:NO];
}

- (void)viewDidUnload
{
    [self setToolBar:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self toggleTab:nil];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return YES;
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    CGFloat sideSpaceWidth = 325;
    if(UIInterfaceOrientationIsLandscape(toInterfaceOrientation))
        sideSpaceWidth = 453;
        
    UIBarButtonItem * sideSpace = [[self.toolBar items] objectAtIndex:0];
    [sideSpace setWidth:sideSpaceWidth];
}

- (void) toggleTab:(id) sender {
    int selectedTab = 0;
    if(sender)
    {
    
        UIBarButtonItem * barButtonItem = (UIBarButtonItem *)sender;
        selectedTab = barButtonItem.tag;
    
        NSLog(@"Selected tab : %d", selectedTab);    
    }


    [self.appleNavigationController.view removeFromSuperview];
    [self.windowsNavigationController.view removeFromSuperview];
    
    switch (selectedTab) {
        case 0:
            [self.view insertSubview:self.appleNavigationController.view atIndex:0];
//            [self.view addSubview:self.appleNavigationController.view];
            break;            
        case 1:            
            [self.view insertSubview:self.windowsNavigationController.view atIndex:0];            
//            [self.view addSubview:self.windowsNavigationController.view];
            break;
        default:
            break;
    }
}
@end
