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
- (UIColor *)borderColorAccordingToCurrentState;
- (UIColor *)textColorAccordingToCurrentState;
- (UIColor *)textShadowColorAccordingToCurrentState;
- (NSString *)textAccordingToCurrentState;
@end


@implementation NVUIGradientButton

@synthesize cornerRadius				= _cornerRadius;
@synthesize borderWidth					= _borderWidth;
@synthesize borderColor					= _borderColor;
@synthesize highlightedBorderColor		= _highlightedBorderColor;
@synthesize disabledBorderColor			= _disabledBorderColor;
@synthesize textColor					= _textColor;
@synthesize highlightedTextColor		= _highlightedTextColor;
@synthesize disabledTextColor			= _disabledTextColor;
@synthesize textShadowColor				= _textShadowColor;
@synthesize highlightedTextShadowColor	= _highlightedTextShadowColor;
@synthesize disabledTextShadowColor		= _disabledTextShadowColor;
@synthesize text						= _text;
@synthesize highlightedText				= _highlightedText;
@synthesize disabledText				= _disabledText;

#pragma mark - Memory Management

- (void)dealloc
{
	[_borderColor release];
	[_highlightedBorderColor release];
	[_disabledBorderColor release];
	[_textColor release];
	[_highlightedTextColor release];
	[_disabledTextColor release];
	[_textShadowColor release];
	[_highlightedTextShadowColor release];
	[_disabledTextShadowColor release];
	[_text release];
	[_highlightedText release];
	[_disabledText release];
	
	[super dealloc];
}


#pragma mark - Creation

#define NVUIGradientButtonDefaultCorderRadius	10.0
#define NVUIGradientButtonDefaultBorderWidth	2.0

- (void)performDefaultInit
{
	// Defaults
	_highlightedText = [_text retain];
	_disabledText = [_text retain];
	_borderColor = [[UIColor darkGrayColor] retain];
	_highlightedBorderColor = [_borderColor retain];
	_disabledBorderColor = [_borderColor retain];
	_textColor = [[UIColor blackColor] retain];
	_highlightedTextColor = [_textColor retain];
	_disabledTextColor = [_textColor retain];
	_textShadowColor = [[UIColor darkGrayColor] retain];
	_highlightedTextShadowColor = [_textShadowColor retain];
	_disabledTextShadowColor = [_textShadowColor retain];
	
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

- (void)setBorderColor:(UIColor *)borderColor
{
	if (borderColor != _borderColor) 
	{
		[_borderColor release];
		_borderColor = [borderColor retain];
		
		if (self.state & UIControlStateNormal)
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


- (void)setDisabledBorderColor:(UIColor *)disabledBorderColor
{
	if (disabledBorderColor != _disabledBorderColor) 
	{
		[_disabledBorderColor release];
		_disabledBorderColor = [disabledBorderColor retain];
		
		if (self.state & UIControlStateDisabled)
			[self setNeedsDisplay];
	}
}


- (void)setTextColor:(UIColor *)textColor
{
	if (textColor != _textColor) 
	{
		[_textColor release];
		_textColor = [textColor retain];
		
		if (self.state & UIControlStateNormal)
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


- (void)setDisabledTextColor:(UIColor *)disabledTextColor
{
	if (disabledTextColor != _disabledTextColor) 
	{
		[_disabledTextColor release];
		_disabledTextColor = [disabledTextColor retain];
		
		if (self.state & UIControlStateDisabled)
			[self setNeedsDisplay];
	}
}


- (void)setTextShadowColor:(UIColor *)textShadowColor
{
	if (textShadowColor != _textShadowColor) 
	{
		[_textShadowColor release];
		_textShadowColor = [textShadowColor retain];
		
		if (self.state & UIControlStateNormal)
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


- (void)setDisabledTextShadowColor:(UIColor *)disabledTextShadowColor
{
	if (disabledTextShadowColor != _disabledTextShadowColor) 
	{
		[_disabledTextShadowColor release];
		_disabledTextShadowColor = [disabledTextShadowColor retain];
		
		if (self.state & UIControlStateDisabled)
			[self setNeedsDisplay];
	}
}


- (void)setText:(NSString *)text
{
	if (![text isEqualToString:_text])
	{
		[_text release];
		_text = [text copy];
		
		if (self.state & UIControlStateNormal)
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


- (void)setBorderColor:(UIColor *)borderColor forState:(UIControlState)state
{
	if (state & UIControlStateNormal) 
		self.borderColor = borderColor;
	
	if (state & UIControlStateDisabled) 
		self.disabledBorderColor = borderColor;
	
	if (state & UIControlStateHighlighted || state & UIControlStateSelected) 
		self.highlightedBorderColor = borderColor;
}


- (void)setTextColor:(UIColor *)textColor forState:(UIControlState)state
{
	if (state & UIControlStateNormal) 
		self.textColor = textColor;
	
	if (state & UIControlStateDisabled) 
		self.disabledTextColor = textColor;
	
	if (state & UIControlStateHighlighted || state & UIControlStateSelected) 
		self.highlightedTextColor = textColor;
}


- (void)setTextShadowColor:(UIColor *)textShadowColor forState:(UIControlState)state
{
	if (state & UIControlStateNormal) 
		self.textShadowColor = textShadowColor;
	
	if (state & UIControlStateDisabled) 
		self.disabledTextShadowColor = textShadowColor;
	
	if (state & UIControlStateHighlighted || state & UIControlStateSelected) 
		self.highlightedTextShadowColor = textShadowColor;
}


- (void)setText:(NSString *)text forState:(UIControlState)state
{
	if (state & UIControlStateNormal) 
		self.text = text;
	
	if (state & UIControlStateDisabled) 
		self.disabledText = text;
	
	if (state & UIControlStateHighlighted || state & UIControlStateSelected) 
		self.highlightedText = text;
}


- (UIColor *)borderColorAccordingToCurrentState
{	
	UIColor *borderColor = _borderColor;
	
	if (!self.enabled && _disabledBorderColor)
		borderColor = _disabledBorderColor;
	else if ([self isHighlightedOrSelected] && _highlightedBorderColor)
		borderColor = _highlightedBorderColor;
		
	return borderColor;
}


- (UIColor *)textColorAccordingToCurrentState
{
	UIColor *textColor = _textColor;
	
	if (!self.enabled && _disabledTextColor)
		textColor = _disabledTextColor;
	else if ([self isHighlightedOrSelected] && _highlightedTextColor)
		textColor = _highlightedTextColor;
	
	return textColor;
}


- (UIColor *)textShadowColorAccordingToCurrentState
{
	UIColor *textShadowColor = _textShadowColor;
	
	if (!self.enabled && _disabledTextShadowColor)
		textShadowColor = _disabledTextShadowColor;
	else if ([self isHighlightedOrSelected] && _highlightedTextShadowColor)
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


#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
	if ([self isHighlightedOrSelected]) 
		NSLog(@"I'm selected / highlighted !");
	
    CGContextRef ctx = UIGraphicsGetCurrentContext();
		
	UIBezierPath *path = [UIBezierPath bezierPathWithRect:self.bounds];
	
	path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius];
	
	[path addClip];
	
	UIColor *borderColor = [self borderColorAccordingToCurrentState];
	UIColor *textColor = [self textColorAccordingToCurrentState];
	UIColor *textShadowColor = [self textShadowColorAccordingToCurrentState];
	NSString *text = [self textAccordingToCurrentState];
	
	// Draw background
	UIColor *nonGradient = [UIColor whiteColor];
	[nonGradient set];
	[path fill];
	
	// Draw text
	
	
	// Draw border
	[borderColor set];
	[path stroke];
}


@end

















