//
//  NVViewController.m
//  NVUIGradientButtonSample
//
//  Created by Nicolas Verinaud on 20/06/12.
//  Copyright (c) 2012 nverinaud.com. All rights reserved.
//

#import "NVViewController.h"

@interface NVViewController ()

@property (strong, nonatomic) NVUIGradientButton *attributedStringButton; // created programmatically
@property (strong, nonatomic) IBOutlet UIView *container;

@end


@implementation NVViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.button.text = @"Default";
	
	// Create a button programmatically
	self.attributedStringButton = [[NVUIGradientButton alloc] initWithFrame:self.button.frame style:NVUIGradientButtonStyleDefault];
	self.attributedStringButton.autoresizingMask = self.button.autoresizingMask;
	
	if ([UILabel instancesRespondToSelector:@selector(attributedText)]) // iOS 6+
	{
		// Normal
		NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"Attributed"];
		NSRange total = NSMakeRange(0, str.length);
		NSMutableDictionary *attributes = [@{
			NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle),
			NSFontAttributeName : [UIFont systemFontOfSize:17.f],
			NSForegroundColorAttributeName : UIColor.blackColor
		} mutableCopy];
		
		[str setAttributes:attributes range:total];
		[str setAttributes:@{ NSFontAttributeName : [UIFont boldSystemFontOfSize:17.f] } range:NSMakeRange(0, 1)];
		self.attributedStringButton.attributedText = str;
		
		// Highlighted
		NSShadow *shadow = [[NSShadow alloc] init];
		shadow.shadowOffset = CGSizeMake(0, -1);
		shadow.shadowColor = [UIColor blackColor];
		[attributes setObject:UIColor.whiteColor forKey:NSForegroundColorAttributeName];
		[attributes setObject:shadow forKey:NSShadowAttributeName];
		[str setAttributes:attributes range:total];
		
		[attributes setObject:[UIFont boldSystemFontOfSize:17.f] forKey:NSFontAttributeName];
		[attributes removeObjectForKey:NSUnderlineStyleAttributeName];
		[str setAttributes:attributes range:NSMakeRange(0, 1)];
		
		self.attributedStringButton.highlightedAttributedText = str;
	}
	else
	{
		self.attributedStringButton.text = @"Disabled";
		self.attributedStringButton.enabled = NO;
	}
	
	CGRect frame = self.attributedStringButton.frame;
	frame.origin.y = CGRectGetMaxY(self.button.frame) + 8;
	self.attributedStringButton.frame = frame;
	
	[self.view addSubview:self.attributedStringButton];
	
	// Customize a button with accessory images
	self.redButton.text = @"Red";
	self.redButton.textColor = [UIColor whiteColor];
	self.redButton.textShadowColor = [UIColor darkGrayColor];
	self.redButton.tintColor = [UIColor colorWithRed:(CGFloat)120/255 green:0 blue:0 alpha:1];
	self.redButton.highlightedTintColor = [UIColor colorWithRed:(CGFloat)190/255 green:0 blue:0 alpha:1];
	self.redButton.rightAccessoryImage = [UIImage imageNamed:@"arrow"];
	self.redButton.leftAccessoryImage = [UIImage imageNamed:@"arrow_reversed"];
	
	// Change the style of a button
	self.styledButton.text = @"Black Translucent";
	self.styledButton.style = NVUIGradientButtonStyleBlackTranslucent;
	
	// The dynamic button
	self.dynamicButton.text = @"Dynamic";
	self.dynamicButton.textColor = [UIColor whiteColor];
	self.dynamicButton.textShadowColor = [UIColor darkGrayColor];
	
	[self sliderValueChanged];
}


- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
		[UIView animateWithDuration:duration animations:^{
			self.container.alpha = UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
		}];
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


- (IBAction)switchValueChanged:(UISwitch *)sender
{
	self.dynamicButton.glossy = sender.on;
}


- (void)viewDidUnload
{
    [super viewDidUnload];
	
	self.button = nil;
	self.attributedStringButton = nil;
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
