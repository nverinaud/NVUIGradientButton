//
//  NVViewController.m
//  NVUIGradientButtonSample
//
//  Created by Nicolas Verinaud on 20/06/12.
//  Copyright (c) 2012 nverinaud.com. All rights reserved.
//

#import "NVViewController.h"

@interface NVViewController ()
@end


@implementation NVViewController

@synthesize button	= _button;

- (void)dealloc
{
	[_button release];
	
	[super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.button.text = @"Normal";
	self.button.highlightedText = @"Highlighted or Selected";
	self.button.disabledText = @"Disabled";
	self.button.highlightedBorderColor = [UIColor blueColor];
	self.button.highlightedTextColor = [UIColor blueColor];
}


- (void)viewDidUnload
{
    [super viewDidUnload];
	
	self.button = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	else
	    return YES;
}

@end
