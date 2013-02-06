//
//  NVUIGradientButton.m
//
//  Created by Nicolas Verinaud on 20/06/12.
//  Copyright (c) 2012 nverinaud.com. All rights reserved.
//

#import "NVUIGradientButton.h"

@interface NVUIGradientButton ()
- (void)performDefaultInit;
- (void)updateAccordingToStyle;
- (BOOL)isHighlightedOrSelected;
- (UIColor *)tintColorAccordingToCurrentState;
- (UIColor *)borderColorAccordingToCurrentState;
- (UIColor *)textColorAccordingToCurrentState;
- (UIColor *)textShadowColorAccordingToCurrentState;
- (NSString *)textAccordingToCurrentState;
- (UIImage *)rightAccessoryImageAccordingToCurrentState;
- (CGGradientRef)newGradientAccordingToCurrentState;
@property (strong, nonatomic, readwrite) UILabel *titleLabel;
@end


@implementation NVUIGradientButton

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
	[_rightAccessoryImage release];
	[_rightHighlightedAccessoryImage release];
	
	[super dealloc];
}


#pragma mark - Creation

#define NVUIGradientButtonDefaultCorderRadius	10.0
#define NVUIGradientButtonDefaultBorderWidth	2.0

- (void)performDefaultInit
{
	// Defaults
	_highlightedText = [_text copy];
	_disabledText = [_text copy];
	
	// Label
	_titleLabel = [[UILabel alloc] init];
	_titleLabel.textAlignment = UITextAlignmentCenter;
	_titleLabel.lineBreakMode = UILineBreakModeMiddleTruncation;
	_titleLabel.numberOfLines = 0;
	_titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
	_titleLabel.minimumFontSize = 12.0;
	_titleLabel.shadowOffset = CGSizeMake(0, -1);
	
	_gradientEnabled = YES;
	
	self.opaque = NO;
	self.backgroundColor = [UIColor clearColor];
}


- (void)updateAccordingToStyle
{
	switch (_style)
	{
		case NVUIGradientButtonStyleBlackOpaque:
		{
			self.tintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:1];
			self.highlightedTintColor = [UIColor colorWithRed:(CGFloat)3/255 green:(CGFloat)112/255 blue:(CGFloat)236/255 alpha:1];
			self.borderColor = [UIColor whiteColor];
			self.highlightedBorderColor = [UIColor whiteColor];
			self.textColor = [UIColor whiteColor];
			self.highlightedTextColor = [UIColor whiteColor];
			self.textShadowColor = [UIColor clearColor];
			self.highlightedTextShadowColor = [UIColor clearColor];
			break;
		}
			
		case NVUIGradientButtonStyleBlackTranslucent:
		{
			self.tintColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.7];
			self.highlightedTintColor = [UIColor colorWithRed:(CGFloat)3/255 green:(CGFloat)112/255 blue:(CGFloat)236/255 alpha:0.7];
			self.borderColor = [UIColor whiteColor];
			self.highlightedBorderColor = [UIColor whiteColor];
			self.textColor = [UIColor whiteColor];
			self.highlightedTextColor = [UIColor whiteColor];
			self.textShadowColor = [UIColor clearColor];
			self.highlightedTextShadowColor = [UIColor clearColor];
			break;
		}
			
		case NVUIGradientButtonStyleDefault:
		{
			CGFloat gray = 220.0/255.0;
			self.tintColor = [UIColor colorWithRed:gray green:gray blue:gray alpha:1];
			self.highlightedTintColor = [UIColor colorWithRed:0 green:(CGFloat)157/255 blue:1 alpha:1];
			self.borderColor = [UIColor darkGrayColor];
			self.highlightedBorderColor = [UIColor whiteColor];
			self.textColor = [UIColor blackColor];
			self.highlightedTextColor = [UIColor whiteColor];
			self.textShadowColor = [UIColor clearColor];
			self.highlightedTextShadowColor = [UIColor darkGrayColor];
			break;
		}
	}
}

#pragma mark Designated initializer

- (id)initWithFrame:(CGRect)frame style:(NVUIGradientButtonStyle)style cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth andText:(NSString *)text
{
	self = [super initWithFrame:frame];
    if (self)
	{
		_cornerRadius = cornerRadius;
		_borderWidth = borderWidth;
		_text = [text copy];
		
		[self performDefaultInit];
		
		self.style = style;
    }
    return self;
}


#pragma mark Convenient initializers

- (id)initWithFrame:(CGRect)frame cornerRadius:(CGFloat)cornerRadius borderWidth:(CGFloat)borderWidth andText:(NSString *)text
{
	return [self initWithFrame:frame style:NVUIGradientButtonStyleDefault cornerRadius:cornerRadius borderWidth:borderWidth andText:text];
}


- (id)initWithFrame:(CGRect)frame style:(NVUIGradientButtonStyle)style
{
	return [self initWithFrame:frame style:style cornerRadius:NVUIGradientButtonDefaultCorderRadius borderWidth:NVUIGradientButtonDefaultBorderWidth andText:nil];
}

#pragma mark Overriden initializers

- (id)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame style:NVUIGradientButtonStyleDefault cornerRadius:NVUIGradientButtonDefaultCorderRadius borderWidth:NVUIGradientButtonDefaultBorderWidth andText:nil];
}


- (id)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	if (self)
	{
		_cornerRadius = NVUIGradientButtonDefaultCorderRadius;
		_borderWidth = NVUIGradientButtonDefaultBorderWidth;
		
		[self performDefaultInit];
		
		self.style = NVUIGradientButtonStyleDefault;
	}
	return self;
}


#pragma mark - Setters

- (void)setStyle:(NVUIGradientButtonStyle)style
{
	if (style != _style)
	{
		_style = style;
		[self updateAccordingToStyle];
	}
}


- (void)setTintColor:(UIColor *)tintColor
{
	if (tintColor != _tintColor)
	{
		[_tintColor release];
		_tintColor = [tintColor retain];
		
		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setHighlightedTintColor:(UIColor *)highlightedTintColor
{
	if (highlightedTintColor != _highlightedTintColor)
	{
		[_highlightedTintColor release];
		_highlightedTintColor = [highlightedTintColor retain];
		
		if ([self isHighlightedOrSelected])
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


- (void)setRightAccessoryImage:(UIImage *)rightAccessoryImage
{
	if (rightAccessoryImage != _rightAccessoryImage)
	{
		[_rightAccessoryImage release];
		_rightAccessoryImage = [rightAccessoryImage retain];
		
		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setRightHighlightedAccessoryImage:(UIImage *)rightHighlightedAccessoryImage
{
	if (rightHighlightedAccessoryImage != _rightHighlightedAccessoryImage)
	{
		[_rightHighlightedAccessoryImage release];
		_rightHighlightedAccessoryImage = [rightHighlightedAccessoryImage retain];
		
		if ([self isHighlightedOrSelected])
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


- (void)setRightAccessoryImage:(UIImage *)rightAccessoryImage forState:(UIControlState)state
{
	if (state == UIControlStateNormal)
		self.rightAccessoryImage = rightAccessoryImage;
	
	if (state & UIControlStateHighlighted || state & UIControlStateSelected)
		self.rightHighlightedAccessoryImage = rightAccessoryImage;
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


- (UIImage *)rightAccessoryImageAccordingToCurrentState
{
	UIImage *image = _rightAccessoryImage;
	
	if ([self isHighlightedOrSelected] && _rightHighlightedAccessoryImage)
		image = _rightHighlightedAccessoryImage;
	
	return image;
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
	else if (middleColor)
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

#define DEFAULT_PADDING		4

- (void)drawRect:(CGRect)rect
{
	// Setting Env
	CGContextRef ctx = UIGraphicsGetCurrentContext();
	UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:_cornerRadius];
	CGFloat padding = _borderWidth + DEFAULT_PADDING;
	UIColor *borderColor = [self borderColorAccordingToCurrentState];
	UIColor *textColor = [self textColorAccordingToCurrentState];
	UIColor *textShadowColor = [self textShadowColorAccordingToCurrentState];
	NSString *text = [self textAccordingToCurrentState];
	
	// Draw
	[path addClip];
	
	// Draw background
	if (_gradientEnabled)
	{
		CGGradientRef gradient = [self newGradientAccordingToCurrentState];
		CGFloat midX = CGRectGetMidX(self.bounds);
		CGFloat botY = CGRectGetMaxY(self.bounds);
		CGPoint startPoint = CGPointMake(midX, 0);
		CGPoint endPoint = CGPointMake(midX, botY);
		CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
		CGGradientRelease(gradient);
	}
	else
	{
		UIColor *tint = [self tintColorAccordingToCurrentState];
		[tint set];
		[path fill];
	}
	
	// Draw right image
	UIImage *rightImage = [self rightAccessoryImageAccordingToCurrentState];
	CGRect rightAccessoryRect = CGRectZero;
	if (rightImage)
	{
		CGFloat maxHeight = CGRectGetHeight(self.bounds) - padding*2;
		rightAccessoryRect.size.height = MIN(maxHeight, rightImage.size.height);
		rightAccessoryRect.size.width = rightAccessoryRect.size.height / rightImage.size.height * rightImage.size.width;
		rightAccessoryRect.origin.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(rightAccessoryRect)) / 2;
		rightAccessoryRect.origin.x = CGRectGetWidth(self.bounds) - CGRectGetWidth(rightAccessoryRect) - padding;
		[rightImage drawInRect:rightAccessoryRect];
	}
	
	// Draw border
	if (_borderWidth > 0)
	{
		path.lineWidth = _borderWidth;
		[borderColor set];
		[path stroke];
	}
	
	// Draw text
	CGRect innerRect = self.bounds;
	innerRect = CGRectInset(innerRect, padding, padding);
	if (rightImage)
		innerRect.size.width = CGRectGetMinX(rightAccessoryRect);
	
	_titleLabel.textColor = textColor;
	_titleLabel.shadowColor = textShadowColor;
	_titleLabel.text = text;
	
	[textColor set];
	[_titleLabel drawTextInRect:innerRect];
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
