//
//  NVAppDelegate.m
//  NVUIGradientButtonSample
//
//  Created by Nicolas Verinaud on 20/06/12.
//  Copyright (c) 2012 nverinaud.com. All rights reserved.
//

#import "NVAppDelegate.h"

#import "NVViewController.h"

@implementation NVAppDelegate

@synthesize window			= _window;
@synthesize viewController	= _viewController;

- (void)dealloc
{
	[_window release];
	[_viewController release];
    [super dealloc];
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
	
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone) 
	    self.viewController = [[[NVViewController alloc] initWithNibName:@"NVViewController_iPhone" bundle:nil] autorelease];
	else
	    self.viewController = [[[NVViewController alloc] initWithNibName:@"NVViewController_iPad" bundle:nil] autorelease];
	
	self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
    return YES;
}

@end
