//
//  ViewController.h
//  TopToolbarAsTabbar
//
//  Created by Yuichi Fujiki on 1/24/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIToolbar *toolBar;
@property (strong, nonatomic) UINavigationController * appleNavigationController;
@property (strong, nonatomic) UINavigationController * windowsNavigationController;

- (void) toggleTab:(id) sender;

@end
