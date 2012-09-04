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

- (void)dealloc
{
	[_button release];
	[_disabledButton release];
	[_redButton release];
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
	self.redButton.rightAccessoryImage = [UIImage imageNamed:@"arrow"];
	
	self.dynamicButton.text = @"Dynamic";
	self.dynamicButton.textColor = [UIColor whiteColor];
	self.dynamicButton.textShadowColor = [UIColor darkGrayColor];
	[self sliderValueChanged];
	
	/// Black Translucent Style
	CGRect blackTranslucentButtonFrame = CGRectZero;
	blackTranslucentButtonFrame.origin = CGPointMake(47, 179);
	blackTranslucentButtonFrame.size = CGSizeMake(227, 45);
	
	NVUIGradientButton *blackButton = [[NVUIGradientButton alloc] initWithFrame:blackTranslucentButtonFrame style:NVUIGradientButtonStyleBlackTranslucent];
	blackButton.text = @"Black Translucent";
	[self.view addSubview:blackButton];
	[blackButton release];
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
