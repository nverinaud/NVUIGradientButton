//
//  NVUIGradientButton.h
//
//  Created by Nicolas Verinaud on 20/06/12.
//  Copyright (c) 2012 nverinaud.com. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NVUIGradientButtonStyle)
{
	NVUIGradientButtonStyleDefault = 1, // use the appearance proxy if available
	NVUIGradientButtonStyleBlackOpaque,
	NVUIGradientButtonStyleBlackTranslucent
};


@interface NVUIGradientButton : UIControl

@property (nonatomic, assign) NVUIGradientButtonStyle style;
@property (nonatomic, assign) CGFloat cornerRadius UI_APPEARANCE_SELECTOR; // default is 10.0
@property (nonatomic, assign) CGFloat borderWidth UI_APPEARANCE_SELECTOR; // default is 2.0
@property (nonatomic, strong) UIColor *tintColor UI_APPEARANCE_SELECTOR; // default is gray
@property (nonatomic, strong) UIColor *highlightedTintColor UI_APPEARANCE_SELECTOR; // default is nice blue
@property (nonatomic, strong) UIColor *borderColor UI_APPEARANCE_SELECTOR; // default is darkGray
@property (nonatomic, strong) UIColor *highlightedBorderColor UI_APPEARANCE_SELECTOR; // default is white
@property (nonatomic, strong) UIColor *textColor UI_APPEARANCE_SELECTOR; // default is black
@property (nonatomic, strong) UIColor *highlightedTextColor UI_APPEARANCE_SELECTOR; // default is white
@property (nonatomic, strong) UIColor *textShadowColor UI_APPEARANCE_SELECTOR; // default is clear
@property (nonatomic, strong) UIColor *highlightedTextShadowColor UI_APPEARANCE_SELECTOR; // default is darkGrey
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *highlightedText; // default is text
@property (nonatomic, copy) NSString *disabledText; // default is text
@property (nonatomic, copy) NSAttributedString *attributedText;
@property (nonatomic, copy) NSAttributedString *highlightedAttributedText; // default is attributedText
@property (nonatomic, copy) NSAttributedString *disabledAttributedText; // default is attributedText
@property (nonatomic, strong, readonly) UILabel *titleLabel;
@property (nonatomic, assign, getter = isGradientEnabled) NSInteger gradientEnabled UI_APPEARANCE_SELECTOR; // default is YES, set to NO to draw flat color, UIAppearance does not support BOOL :-(
@property (nonatomic, assign, getter = isGlossy) NSInteger glossy UI_APPEARANCE_SELECTOR; // default is NO, UIAppearance does not support BOOL :-(
@property (nonatomic, strong) UIImage *rightAccessoryImage UI_APPEARANCE_SELECTOR; // default is nil
@property (nonatomic, strong) UIImage *rightHighlightedAccessoryImage UI_APPEARANCE_SELECTOR; // default is nil
@property (nonatomic, strong) UIImage *leftAccessoryImage UI_APPEARANCE_SELECTOR; // default is nil
@property (nonatomic, strong) UIImage *leftHighlightedAccessoryImage UI_APPEARANCE_SELECTOR; // default is nil

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
