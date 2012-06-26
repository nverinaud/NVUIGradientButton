//
//  NVUIGradientButton.m
//
//  Created by Nicolas Verinaud on 20/06/12.
//  Copyright (c) 2012 nverinaud.com. All rights reserved.
//

#import "NVUIGradientButton.h"

@interface NVUIGradientButton ()
- (void)performDefaultInit;
- (BOOL)isHighlightedOrSelected;
- (UIColor *)tintColorAccordingToCurrentState;
- (UIColor *)borderColorAccordingToCurrentState;
- (UIColor *)textColorAccordingToCurrentState;
- (UIColor *)textShadowColorAccordingToCurrentState;
- (NSString *)textAccordingToCurrentState;
- (CGGradientRef)newGradientAccordingToCurrentState;
@property (strong, nonatomic, readwrite) UILabel *titleLabel;
@end


@implementation NVUIGradientButton

@synthesize cornerRadius				= _cornerRadius;
@synthesize borderWidth					= _borderWidth;
@synthesize tintColor					= _tintColor;
@synthesize highlightedTintColor		= _highlightedTintColor;
@synthesize borderColor					= _borderColor;
@synthesize highlightedBorderColor		= _highlightedBorderColor;
@synthesize textColor					= _textColor;
@synthesize highlightedTextColor		= _highlightedTextColor;
@synthesize textShadowColor				= _textShadowColor;
@synthesize highlightedTextShadowColor	= _highlightedTextShadowColor;
@synthesize text						= _text;
@synthesize highlightedText				= _highlightedText;
@synthesize disabledText				= _disabledText;
@synthesize titleLabel					= _titleLabel;

#pragma mark - Memory Management

- (void)dealloc
{
	[_tintColor release];
	[_highlightedTintColor release];
	[_borderColor release];
	[_highlightedBorderColor release];
	[_textColor release];
	[_highlightedTextColor release];
	[_textShadowColor release];
	[_highlightedTextShadowColor release];
	[_text release];
	[_highlightedText release];
	[_disabledText release];
	[_titleLabel release];
	
	[super dealloc];
}


#pragma mark - Creation

#define NVUIGradientButtonDefaultCorderRadius	10.0
#define NVUIGradientButtonDefaultBorderWidth	2.0

- (void)performDefaultInit
{
	// Defaults
	CGFloat gray = 220.0/255.0;
	_tintColor = [[UIColor alloc] initWithRed:gray green:gray blue:gray alpha:1];
	_highlightedTintColor = [[UIColor alloc] initWithRed:0 green:(CGFloat)157/255 blue:1 alpha:1];
	_highlightedText = [_text retain];
	_disabledText = [_text retain];
	_borderColor = [[UIColor darkGrayColor] retain];
	_highlightedBorderColor = [[UIColor whiteColor] retain];
	_textColor = [[UIColor blackColor] retain];
	_highlightedTextColor = [[UIColor whiteColor] retain];
	_textShadowColor = [[UIColor clearColor] retain];
	_highlightedTextShadowColor = [[UIColor darkGrayColor] retain];
	
	// Label
	_titleLabel = [[UILabel alloc] init];
	_titleLabel.textAlignment = UITextAlignmentCenter;
	_titleLabel.lineBreakMode = UILineBreakModeMiddleTruncation;
	_titleLabel.numberOfLines = 1;
	_titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
	_titleLabel.minimumFontSize = 12.0;
	_titleLabel.shadowOffset = CGSizeMake(0, -1);
	
	self.opaque = NO;
	self.backgroundColor = [UIColor clearColor];
}

#pragma mark Designated Initializer

- (id)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth andText:(NSString *)text
{
	self = [super initWithFrame:frame];
    if (self) 
	{
		_cornerRadius = cornerRadius;
		_borderWidth = borderWidth;
		_text = [text copy];
		
		[self performDefaultInit];
    }
    return self;
}

#pragma mark Overriden Initializers

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame cornerRadius:NVUIGradientButtonDefaultCorderRadius borderWidth:NVUIGradientButtonDefaultBorderWidth andText:nil];
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self) 
	{
		_cornerRadius = NVUIGradientButtonDefaultCorderRadius;
		_borderWidth = NVUIGradientButtonDefaultBorderWidth;
		
		[self performDefaultInit];
	}
	return self;
}


#pragma mark - Setters

- (void)setTintColor:(UIColor *)tintColor
{
	if (tintColor != _tintColor) 
	{
		[_tintColor release];
		_tintColor = [tintColor retain];
		
		[self setNeedsDisplay];
	}
}


- (void)setBorderColor:(UIColor *)borderColor
{
	if (borderColor != _borderColor) 
	{
		[_borderColor release];
		_borderColor = [borderColor retain];
		
		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setHighlightedBorderColor:(UIColor *)highlightedBorderColor
{
	if (highlightedBorderColor != _highlightedBorderColor) 
	{
		[_highlightedBorderColor release];
		_highlightedBorderColor = [highlightedBorderColor retain];
		
		if ([self isHighlightedOrSelected])
			[self setNeedsDisplay];
	}
}


- (void)setTextColor:(UIColor *)textColor
{
	if (textColor != _textColor) 
	{
		[_textColor release];
		_textColor = [textColor retain];
		
		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setHighlightedTextColor:(UIColor *)highlightedTextColor
{
	if (highlightedTextColor != _highlightedTextColor) 
	{
		[_highlightedTextColor release];
		_highlightedTextColor = [highlightedTextColor retain];
		
		if ([self isHighlightedOrSelected])
			[self setNeedsDisplay];
	}
}


- (void)setTextShadowColor:(UIColor *)textShadowColor
{
	if (textShadowColor != _textShadowColor) 
	{
		[_textShadowColor release];
		_textShadowColor = [textShadowColor retain];
		
		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setHighlightedTextShadowColor:(UIColor *)highlightedTextShadowColor
{
	if (highlightedTextShadowColor != _highlightedTextShadowColor) 
	{
		[_highlightedTextShadowColor release];
		_highlightedTextShadowColor = [highlightedTextShadowColor retain];
		
		if ([self isHighlightedOrSelected])
			[self setNeedsDisplay];
	}
}


- (void)setText:(NSString *)text
{
	if (![text isEqualToString:_text])
	{
		[_text release];
		_text = [text copy];
		
		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setHighlightedText:(NSString *)highlightedText
{
	if (![highlightedText isEqualToString:_highlightedText]) 
	{
		[_highlightedText release];
		_highlightedText = [highlightedText copy];
		
		if ([self isHighlightedOrSelected])
			[self setNeedsDisplay];
	}
}


- (void)setDisabledText:(NSString *)disabledText
{
	if (![disabledText isEqualToString:_disabledText]) 
	{
		[_disabledText release];
		_disabledText = [disabledText copy];
		
		if (self.state & UIControlStateDisabled)
			[self setNeedsDisplay];
	}
}


#pragma mark - Convenience configuration for states

- (BOOL)isHighlightedOrSelected
{
	return (self.state & UIControlStateHighlighted || self.state & UIControlStateSelected);
}


- (void)setTintColor:(UIColor *)tintColor forState:(UIControlState)state
{
	if (state == UIControlStateNormal) 
		self.tintColor = tintColor;
	
	if (state & UIControlStateHighlighted || state & UIControlStateSelected) 
		self.highlightedTintColor = tintColor;
}


- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state
{
	if (state == UIControlStateNormal) 
		self.borderColor = borderColor;
	
	if (state & UIControlStateHighlighted || state & UIControlStateSelected) 
		self.highlightedBorderColor = borderColor;
}


- (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state
{
	if (state == UIControlStateNormal) 
		self.textColor = textColor;
	
	if (state & UIControlStateHighlighted || state & UIControlStateSelected) 
		self.highlightedTextColor = textColor;
}


- (void)setTextShadowColor:(UIColor *)textShadowColor forState:(UIControlState)state
{
	if (state == UIControlStateNormal) 
		self.textShadowColor = textShadowColor;
	
	if (state & UIControlStateHighlighted || state & UIControlStateSelected) 
		self.highlightedTextShadowColor = textShadowColor;
}


- (void)setText:(NSString *)text forState:(UIControlState)state
{
	if (state == UIControlStateNormal) 
		self.text = text;
	
	if (state & UIControlStateDisabled) 
		self.disabledText = text;
	
	if (state & UIControlStateHighlighted || state & UIControlStateSelected) 
		self.highlightedText = text;
}


- (UIColor *)tintColorAccordingToCurrentState
{
	UIColor *tintColor = _tintColor;
	
	if([self isHighlightedOrSelected])
		tintColor = _highlightedTintColor;
	
	return tintColor;
}


- (UIColor *)borderColorAccordingToCurrentState
{	
	UIColor *borderColor = _borderColor;
	
	if ([self isHighlightedOrSelected] && _highlightedBorderColor)
		borderColor = _highlightedBorderColor;
		
	return borderColor;
}


- (UIColor *)textColorAccordingToCurrentState
{
	UIColor *textColor = _textColor;
	
	if ([self isHighlightedOrSelected] && _highlightedTextColor)
		textColor = _highlightedTextColor;
	
	if (!self.enabled) 
		textColor = [textColor colorWithAlphaComponent:0.5];
	
	return textColor;
}


- (UIColor *)textShadowColorAccordingToCurrentState
{
	UIColor *textShadowColor = _textShadowColor;
	
	if ([self isHighlightedOrSelected] && _highlightedTextShadowColor)
		textShadowColor = _highlightedTextShadowColor;
	
	return textShadowColor;
}


- (NSString *)textAccordingToCurrentState
{
	NSString *text = _text;
	
	if (!self.enabled && _disabledText)
		text = _disabledText;
	else if ([self isHighlightedOrSelected] && _highlightedText)
		text = _highlightedText;
	
	return text;
}


#pragma mark - Gradient

- (CGGradientRef)newGradientAccordingToCurrentState
{
	CGGradientRef gradient = NULL;
	
	// Compute the colors of the gradient
	UIColor *middleColor = [self tintColorAccordingToCurrentState];
	
	CGFloat red = 0, green = 0, blue = 0, alpha = 0;
	if ([middleColor respondsToSelector:@selector(getRed:green:blue:alpha:)]) // iOS 5+
	{
		[middleColor getRed:&red green:&green blue:&blue alpha:&alpha];
	}
	else 
	{
		CGColorRef color = [middleColor CGColor];
		const CGFloat *components = CGColorGetComponents(color);
		red = components[0];
		green = components[1];
		blue = components[2];
		alpha = components[3];
	}
	
	CGFloat offsetColor = 50.0f/255.0f;
	UIColor *topColor = [UIColor colorWithRed:fminf(1, red+offsetColor) green:fminf(1, green+offsetColor) blue:fminf(1, blue+offsetColor) alpha:alpha];
	UIColor *bottomColor = [UIColor colorWithRed:fminf(1, red-offsetColor) green:fminf(1, green-offsetColor) blue:fminf(1, blue-offsetColor) alpha:alpha];
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	
	// Create an array of colors
	CFMutableArrayRef colors = CFArrayCreateMutable(NULL, 3, NULL);
	CFArrayAppendValue(colors, [topColor CGColor]);
	CFArrayAppendValue(colors, [middleColor CGColor]);
	CFArrayAppendValue(colors, [bottomColor CGColor]);
	
	// Create the gradient
	gradient = CGGradientCreateWithColors(colorSpace, colors, NULL);
	
	// Memory free
	CFRelease(colors);
	CGColorSpaceRelease(colorSpace);
	
	return gradient;
}


#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{		
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
	
	path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius];
	
	[path addClip];
	
	UIColor *borderColor = [self borderColorAccordingToCurrentState];
	UIColor *textColor = [self textColorAccordingToCurrentState];
	UIColor *textShadowColor = [self textShadowColorAccordingToCurrentState];
	NSString *text = [self textAccordingToCurrentState];
	
	// Draw background
	CGGradientRef gradient = [self newGradientAccordingToCurrentState];
	CGFloat midX = CGRectGetMidX(self.bounds);
	CGFloat botY = CGRectGetMaxY(self.bounds);
	CGPoint startPoint = CGPointMake(midX, 0);
	CGPoint endPoint = CGPointMake(midX, botY);
	CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
	CGGradientRelease(gradient);
	
	// Draw text
	_titleLabel.textColor = textColor;
	_titleLabel.shadowColor = textShadowColor;
	_titleLabel.text = text;
	
	[textColor set];
	[_titleLabel drawTextInRect:self.bounds];
	
	// Draw border
	[borderColor set];
	[path stroke];
}


#pragma mark - Touch Handling

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	self.highlighted = YES;
	[self setNeedsDisplay];
	return [super beginTrackingWithTouch:touch withEvent:event];
}


- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	self.highlighted = [self isTouchInside];
	[self setNeedsDisplay];
	return [super continueTrackingWithTouch:touch withEvent:event];
}


- (void)endTrackingWithTouch:(UITouch *)touch withEvent:(UIEvent *)event
{
	[super endTrackingWithTouch:touch withEvent:event];
	self.highlighted = NO;
	[self setNeedsDisplay];
}


- (void)cancelTrackingWithEvent:(UIEvent *)event
{
	[super cancelTrackingWithEvent:event];
	self.highlighted = NO;
	[self setNeedsDisplay];
}


#pragma mark - Accessibility

- (BOOL)isAccessibilityElement 
{
    return YES;
}    


- (NSString *)accessibilityLabel 
{
    return [self textAccordingToCurrentState];
}


- (UIAccessibilityTraits)accessibilityTraits 
{
	UIAccessibilityTraits traits = UIAccessibilityTraitButton;
	
	if ([self isHighlightedOrSelected])
		traits = traits >> UIAccessibilityTraitSelected;
	
	if (!self.enabled)
		traits = traits >> UIAccessibilityTraitNotEnabled;

    return traits;
}


- (NSString *)accessibilityHint 
{
	return [self textAccordingToCurrentState];
}


@end

















