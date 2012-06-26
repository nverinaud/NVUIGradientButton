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

@synthesize button			= _button;
@synthesize disabledButton	= _disabledButton;
@synthesize redButton		= _redButton;
@synthesize darkBlueButton	= _darkBlueButton;
@synthesize dynamicButton	= _dynamicButton;
@synthesize redSlider		= _redSlider;
@synthesize redValueLabel	= _redValueLabel;
@synthesize greenSlider		= _greenSlider;
@synthesize greenValueLabel	= _greenValueLabel;
@synthesize blueSlider		= _blueSlider;
@synthesize blueValueLabel	= _blueValueLabel;

- (void)dealloc
{
	[_button release];
	[_disabledButton release];
	[_redButton release];
	[_darkBlueButton release];
	[_dynamicButton release];
	[_redSlider release];
	[_redValueLabel release];
	[_greenSlider release];
	[_greenValueLabel release];
	[_blueSlider release];
	[_blueValueLabel release];
	[super dealloc];
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.button.text = @"Default";
	
	self.disabledButton.text = @"Disabled";
	self.disabledButton.enabled = NO;
	
	self.redButton.text = @"Red";
	self.redButton.textColor = [UIColor whiteColor];
	self.redButton.textShadowColor = [UIColor darkGrayColor];
	self.redButton.tintColor = [UIColor colorWithRed:(CGFloat)120/255 green:0 blue:0 alpha:1];
	self.redButton.highlightedTintColor = [UIColor colorWithRed:(CGFloat)190/255 green:0 blue:0 alpha:1];
	
	self.darkBlueButton.text = @"Dark Blue";
	self.darkBlueButton.textColor = [UIColor whiteColor];
	self.darkBlueButton.textShadowColor = [UIColor darkGrayColor];
	self.darkBlueButton.tintColor = [UIColor colorWithRed:0 green:(CGFloat)78/255 blue:(CGFloat)120/255 alpha:1];
	self.darkBlueButton.highlightedTintColor = [UIColor colorWithRed:(CGFloat)36/255 green:(CGFloat)76/255 blue:(CGFloat)97/255 alpha:1];
	
	self.dynamicButton.text = @"Dynamic";
	self.dynamicButton.textColor = [UIColor whiteColor];
	self.dynamicButton.textShadowColor = [UIColor darkGrayColor];
	[self sliderValueChanged];
}


- (IBAction)sliderValueChanged
{
	CGFloat red = self.redSlider.value;
	CGFloat green = self.greenSlider.value;
	CGFloat blue = self.blueSlider.value;
	
	self.dynamicButton.tintColor = [UIColor colorWithRed:red green:green blue:blue alpha:1];
	
	self.redValueLabel.text = [NSString stringWithFormat:@"%3.0f", 255*red];
	self.greenValueLabel.text = [NSString stringWithFormat:@"%3.0f", 255*green];
	self.blueValueLabel.text = [NSString stringWithFormat:@"%3.0f", 255*blue];
}


- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender
{
	static NSUInteger kWhiteSelectedIndex = 0;
	
	if (sender.selectedSegmentIndex == kWhiteSelectedIndex) 
	{
		self.dynamicButton.textColor = [UIColor whiteColor];
		self.dynamicButton.textShadowColor = [UIColor darkGrayColor];
	}
	else 
	{
		self.dynamicButton.textColor = [UIColor blackColor];
		self.dynamicButton.textShadowColor = [UIColor clearColor];
	}
}


- (void)viewDidUnload
{
    [super viewDidUnload];
	
	self.button = nil;
	self.disabledButton = nil;
	self.redButton = nil;
	self.darkBlueButton = nil;
	self.dynamicButton = nil;
	self.redSlider = nil;
	self.redValueLabel = nil;
	self.greenSlider = nil;
	self.greenValueLabel = nil;
	self.blueSlider = nil;
	self.blueValueLabel = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
	    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
	else
	    return YES;
}

@end
