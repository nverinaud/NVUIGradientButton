//
//  NVUIGradientButton.m
//
//  Created by Nicolas Verinaud on 20/06/12.
//  Copyright (c) 2012 nverinaud.com. All rights reserved.
//

#import "NVUIGradientButton.h"

@interface NVUIGradientButton ()
- (void)performDefaultInit;
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

#define NVUIGradientButtonDefaultCorderRadius	5.0
#define NVUIGradientButtonDefaultBorderWidth	1.0

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


#pragma mark - Colors

- (void)setBorderColor:(UIColor *)borderColor
{
	if (borderColor != _borderColor) 
	{
		[_borderColor release];
		_borderColor = [borderColor retain];
		
		if (!_highlightedBorderColor)
			_highlightedBorderColor = [_borderColor retain];
		
		if (!_disabledBorderColor)
			_disabledBorderColor = [_borderColor retain];
	}
}


- (void)setTextColor:(UIColor *)textColor
{
	if (textColor != _textColor) 
	{
		[_textColor release];
		_textColor = [textColor retain];
		
		if (!_highlightedTextColor)
			_highlightedTextColor = [_textColor retain];
		
		if (!_disabledTextColor)
			_disabledTextColor = [_textColor retain];
	}
}


- (void)setTextShadowColor:(UIColor *)textShadowColor
{
	if (textShadowColor != _textShadowColor) 
	{
		[_textShadowColor release];
		_textShadowColor = [textShadowColor retain];
		
		if (!_highlightedTextShadowColor)
			_highlightedTextShadowColor = [_textShadowColor retain];
		
		if (!_disabledTextShadowColor)
			_disabledTextShadowColor = [_textShadowColor retain];
	}
}


- (void)setText:(NSString *)text
{
	if (text != _text) 
	{
		[_text release];
		_text = [text copy];
		
		if (!_highlightedText) 
			_highlightedText = [_text retain];
		
		if (!_disabledText)
			_disabledText = [_text retain];
	}
}


#pragma mark - Convenience configuration for states

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


#pragma mark - Drawing

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
	
	UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius];
	
	[path addClip];
	
	UIColor *borderColor = _borderColor;
	UIColor *textColor = _textColor;
	
	[path stroke];
}


@end

















