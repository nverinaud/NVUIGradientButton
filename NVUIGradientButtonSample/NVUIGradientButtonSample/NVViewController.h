//
//  NVViewController.h
//  NVUIGradientButtonSample
//
//  Created by Nicolas Verinaud on 20/06/12.
//  Copyright (c) 2012 nverinaud.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "NVUIGradientButton.h"

@interface NVViewController : UIViewController

@property (strong, nonatomic) IBOutlet NVUIGradientButton *button;
@property (strong, nonatomic) IBOutlet NVUIGradientButton *redButton;
@property (strong, nonatomic) IBOutlet NVUIGradientButton *styledButton;
@property (strong, nonatomic) IBOutlet NVUIGradientButton *dynamicButton;

@property (strong, nonatomic) IBOutlet UISlider *redSlider;
@property (strong, nonatomic) IBOutlet UILabel *redValueLabel;
@property (strong, nonatomic) IBOutlet UISlider *blueSlider;
@property (strong, nonatomic) IBOutlet UILabel *blueValueLabel;
@property (strong, nonatomic) IBOutlet UISlider *greenSlider;
@property (strong, nonatomic) IBOutlet UILabel *greenValueLabel;

- (IBAction)sliderValueChanged;
- (IBAction)segmentedControlValueChanged:(UISegmentedControl *)sender;
- (IBAction)switchValueChanged:(UISwitch *)sender;

@end
