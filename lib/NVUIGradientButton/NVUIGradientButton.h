//
//  NVUIGradientButton.h
//
//  Created by Nicolas Verinaud on 20/06/12.
//  Copyright (c) 2012 nverinaud.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NVUIGradientButtonStyle)
{
	NVUIGradientButtonStyleDefault = 1,
	NVUIGradientButtonStyleBlackOpaque,
	NVUIGradientButtonStyleBlackTranslucent
};


@interface NVUIGradientButton : UIControl

@property (nonatomic, assign) NVUIGradientButtonStyle style;
@property (nonatomic) CGFloat cornerRadius; // Default to 10.0
@property (nonatomic) CGFloat borderWidth; // Default to 2.0
@property (strong, nonatomic) UIColor *tintColor; // Default to gray
@property (strong, nonatomic) UIColor *highlightedTintColor; // Default to nice blue
@property (strong, nonatomic) UIColor *borderColor; // Default to darkGray
@property (strong, nonatomic) UIColor *highlightedBorderColor; // Default to white
@property (strong, nonatomic) UIColor *textColor; // Default to black
@property (strong, nonatomic) UIColor *highlightedTextColor; // Default to white
@property (strong, nonatomic) UIColor *textShadowColor; // Default to clear
@property (strong, nonatomic) UIColor *highlightedTextShadowColor; // Default to darkGrey
@property (copy, nonatomic) NSString *text;
@property (copy, nonatomic) NSString *highlightedText; // Default to text
@property (copy, nonatomic) NSString *disabledText; // Default to text
@property (copy, nonatomic) NSAttributedString *attributedText;
@property (copy, nonatomic) NSAttributedString *highlightedAttributedText; // Default to attributedText
@property (copy, nonatomic) NSAttributedString *disabledAttributedText; // Default to attributedText
@property (strong, nonatomic, readonly) UILabel *titleLabel;
@property (nonatomic, getter = isGradientEnabled) BOOL gradientEnabled; // Default to YES, set to NO to draw flat color
@property (nonatomic, strong) UIImage *rightAccessoryImage;
@property (nonatomic, strong) UIImage *rightHighlightedAccessoryImage;
@property (nonatomic, strong) UIImage *leftAccessoryImage;
@property (nonatomic, strong) UIImage *leftHighlightedAccessoryImage;

// Designated initializer
- (id)initWithFrame:(CGRect)frame style:(NVUIGradientButtonStyle)style cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth andText:(NSString *)text;
// Convenient initializers
- (id)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth andText:(NSString *)text;
- (id)initWithFrame:(CGRect)frame style:(NVUIGradientButtonStyle)style;

// Convenience for configuration depending on states
- (void)setTintColor:(UIColor *)tintColor forState:(UIControlState)state;
- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state;
- (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state;
- (void)setTextShadowColor:(UIColor *)textShadowColor forState:(UIControlState)state;
- (void)setText:(NSString *)text forState:(UIControlState)state;
- (void)setAttributedText:(NSAttributedString *)attributedText forState:(UIControlState)state;
- (void)setRightAccessoryImage:(UIImage *)rightAccessoryImage forState:(UIControlState)state;
- (void)setLeftAccessoryImage:(UIImage *)leftAccessoryImage forState:(UIControlState)state;

@end
