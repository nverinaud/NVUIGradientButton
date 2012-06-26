//
//  NVUIGradientButton.h
//
//  Created by Nicolas Verinaud on 20/06/12.
//  Copyright (c) 2012 nverinaud.com. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NVUIGradientButton : UIControl

@property (nonatomic) CGFloat cornerRadius; // Default to 10.0
@property (nonatomic) CGFloat borderWidth; // Default to 2.0
@property (strong, nonatomic) UIColor *tintColor; // Default to gray
@property (strong, nonatomic) UIColor *highlightedTintColor; // Default to nice blue
@property (strong, nonatomic) UIColor *borderColor; // Default to darkGray
@property (strong, nonatomic) UIColor *highlightedBorderColor; // Default to white
@property (strong, nonatomic) UIColor *disabledBorderColor; // Default to borderColor
@property (strong, nonatomic) UIColor *textColor; // Default to black
@property (strong, nonatomic) UIColor *highlightedTextColor; // Default to white
@property (strong, nonatomic) UIColor *disabledTextColor; // Default to dark grey
@property (strong, nonatomic) UIColor *textShadowColor; // Default to clear
@property (strong, nonatomic) UIColor *highlightedTextShadowColor; // Default to darkGrey
@property (strong, nonatomic) UIColor *disabledTextShadowColor; // Default to textShadowColor
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *highlightedText; // Default to text
@property (copy, nonatomic) NSString *disabledText; // Default to text
@property (strong, nonatomic, readonly) UILabel *titleLabel;

// Designated initializer
- (id)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth andText:(NSString *)text;

// Convenience for configuration depending on states
- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state;
- (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state;
- (void)setTextShadowColor:(UIColor *)textShadowColor forState:(UIControlState)state;
- (void)setText:(NSString *)text forState:(UIControlState)state;

@end
