//
//  NVUIGradientButton.m
//
//  Created by Nicolas Verinaud on 20/06/12.
//  Copyright (c) 2012 nverinaud.com. All rights reserved.
//

#import "NVUIGradientButton.h"

NS_ASSUME_NONNULL_BEGIN

static CGGradientRef NVCGGradientCreate(CGColorRef startColor, CGColorRef endColor)
{
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
    CGFloat locations[] = { 0.0, 1.0 };
    NSArray *colors = @[(__bridge id) startColor, (__bridge id) endColor];
    CGGradientRef gradient = CGGradientCreateWithColors(colorSpace, (__bridge CFArrayRef) colors, locations);
	CGColorSpaceRelease(colorSpace);
	
	return gradient;
}


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
- (UIImage *)leftAccessoryImageAccordingToCurrentState;
- (CGGradientRef)newGradientAccordingToCurrentState;
@property (strong, nonatomic, readwrite) UILabel *titleLabel;

// Glossy additions
@property (nonatomic, strong) UIColor *glossyStartColor;
@property (nonatomic, strong) UIColor *glossyEndColor;

@end


@implementation NVUIGradientButton

#pragma mark - UIAppearance

+ (void)initialize
{
	if (self == NVUIGradientButton.class && [self conformsToProtocol:@protocol(UIAppearance)])
	{
		NVUIGradientButton *appearance = [self appearance];
		CGFloat gray = 220.0/255.0;
		
		[appearance setTintColor:[UIColor colorWithRed:gray green:gray blue:gray alpha:1]];
		[appearance setHighlightedTintColor:[UIColor colorWithRed:0 green:(CGFloat)157/255 blue:1 alpha:1]];
		[appearance setBorderColor:[UIColor darkGrayColor]];
		[appearance setHighlightedBorderColor:[UIColor whiteColor]];
		[appearance setTextColor:[UIColor blackColor]];
		[appearance setHighlightedTextColor:[UIColor whiteColor]];
		[appearance setTextShadowColor:[UIColor clearColor]];
		[appearance setHighlightedTextShadowColor:[UIColor darkGrayColor]];
		
		if ([UIView instancesRespondToSelector:@selector(tintColor)])
			[appearance setGradientEnabled:NO];
		else
			[appearance setGradientEnabled:YES];
		
		[appearance setGlossy:NO];
	}
}

#pragma mark - Creation

#define NVUIGradientButtonDefaultCorderRadius	10.0
#define NVUIGradientButtonDefaultBorderWidth	2.0

- (void)performDefaultInit
{
	// Defaults
	_highlightedText = [_text copy];
	_disabledText = [_text copy];
	_highlightedAttributedText = [_attributedText copy];
	_disabledAttributedText = [_attributedText copy];
	
	// Label
	_titleLabel = [[UILabel alloc] init];
	_titleLabel.textAlignment = NSTextAlignmentCenter;
	_titleLabel.lineBreakMode = NSLineBreakByTruncatingMiddle;
	_titleLabel.numberOfLines = 0;
	_titleLabel.font = [UIFont boldSystemFontOfSize:15.0];
	_titleLabel.adjustsFontSizeToFitWidth = YES;
	_titleLabel.minimumScaleFactor = 0.5;
	_titleLabel.shadowOffset = CGSizeMake(0, -1);
	
	if (![[self class] conformsToProtocol:@protocol(UIAppearance)])
	{
		_gradientEnabled = YES;
		_glossy = NO;
	}
	
	_glossyStartColor = [[UIColor alloc] initWithWhite:1 alpha:0.35];
	_glossyEndColor = [[UIColor alloc] initWithWhite:1 alpha:0.1];
	
	self.opaque = NO;
	self.backgroundColor = [UIColor clearColor];
}


- (void)updateAccordingToStyle
{
	if ([UIView instancesRespondToSelector:@selector(tintColor)])
		self.gradientEnabled = NO;
	else
		self.gradientEnabled = YES;
	
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
			if (![[self class] conformsToProtocol:@protocol(UIAppearance)])
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
			}
			else
			{
				NVUIGradientButton *appearance = [[self class] appearance];
				self.tintColor = [appearance tintColor];
				self.highlightedTintColor = [appearance highlightedTintColor];
				self.borderColor = [appearance borderColor];
				self.highlightedBorderColor = [appearance highlightedBorderColor];
				self.textColor = [appearance textColor];
				self.highlightedTextColor = [appearance highlightedTextColor];
				self.textShadowColor = [appearance textShadowColor];
				self.highlightedTextShadowColor = [appearance highlightedTextShadowColor];
				self.gradientEnabled = [appearance isGradientEnabled];
				self.glossy = [appearance isGlossy];
				self.rightAccessoryImage = [appearance rightAccessoryImage];
				self.rightHighlightedAccessoryImage = [appearance rightHighlightedAccessoryImage];
				self.leftAccessoryImage = [appearance leftAccessoryImage];
				self.leftHighlightedAccessoryImage = [appearance leftHighlightedAccessoryImage];
			}
			break;
		}
	}
}

#pragma mark Designated initializer

- (instancetype)initWithFrame:(CGRect)frame
						style:(NVUIGradientButtonStyle)style
				 cornerRadius:(CGFloat)cornerRadius
				  borderWidth:(CGFloat)borderWidth
					  andText:(NSString *)text
{
	self = [super initWithFrame:frame];
	
    if (self)
	{
		_cornerRadius = cornerRadius;
		_borderWidth = borderWidth;
		_text = [text copy];
		
		[self performDefaultInit];
		
		_style = style;
		if (_style != NVUIGradientButtonStyleDefault)
		{
			[self updateAccordingToStyle];
		}
    }
	
    return self;
}


#pragma mark Convenient initializers

- (instancetype)initWithFrame:(CGRect)frame
				 cornerRadius:(CGFloat)cornerRadius
				  borderWidth:(CGFloat)borderWidth
					  andText:(NSString *)text
{
	return [self initWithFrame:frame
						 style:NVUIGradientButtonStyleDefault
				  cornerRadius:cornerRadius
				   borderWidth:borderWidth
					   andText:text];
}


- (instancetype)initWithFrame:(CGRect)frame style:(NVUIGradientButtonStyle)style
{
	return [self initWithFrame:frame
						 style:style
				  cornerRadius:NVUIGradientButtonDefaultCorderRadius
				   borderWidth:NVUIGradientButtonDefaultBorderWidth
					   andText:@""];
}

#pragma mark Overriden initializers

- (instancetype)initWithFrame:(CGRect)frame
{
    return [self initWithFrame:frame
						 style:NVUIGradientButtonStyleDefault
				  cornerRadius:NVUIGradientButtonDefaultCorderRadius
				   borderWidth:NVUIGradientButtonDefaultBorderWidth
					   andText:@""];
}


- (nullable instancetype)initWithCoder:(NSCoder *)aDecoder
{
	self = [super initWithCoder:aDecoder];
	
	if (self)
	{
		_cornerRadius = NVUIGradientButtonDefaultCorderRadius;
		_borderWidth = NVUIGradientButtonDefaultBorderWidth;
		
		[self performDefaultInit];
		
		_style = NVUIGradientButtonStyleDefault;
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
		_tintColor = tintColor;
		
		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setHighlightedTintColor:(UIColor *)highlightedTintColor
{
	if (highlightedTintColor != _highlightedTintColor)
	{
		_highlightedTintColor = highlightedTintColor;
		
		if ([self isHighlightedOrSelected])
			[self setNeedsDisplay];
	}
}


- (void)setBorderColor:(UIColor *)borderColor
{
	if (borderColor != _borderColor)
	{
		_borderColor = borderColor;
		
		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setHighlightedBorderColor:(UIColor *)highlightedBorderColor
{
	if (highlightedBorderColor != _highlightedBorderColor)
	{
		_highlightedBorderColor = highlightedBorderColor;
		
		if ([self isHighlightedOrSelected])
			[self setNeedsDisplay];
	}
}


- (void)setTextColor:(UIColor *)textColor
{
	if (textColor != _textColor)
	{
		_textColor = textColor;
		
		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setHighlightedTextColor:(UIColor *)highlightedTextColor
{
	if (highlightedTextColor != _highlightedTextColor)
	{
		_highlightedTextColor = highlightedTextColor;
		
		if ([self isHighlightedOrSelected])
			[self setNeedsDisplay];
	}
}


- (void)setTextShadowColor:(UIColor *)textShadowColor
{
	if (textShadowColor != _textShadowColor)
	{
		_textShadowColor = textShadowColor;
		
		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setHighlightedTextShadowColor:(UIColor *)highlightedTextShadowColor
{
	if (highlightedTextShadowColor != _highlightedTextShadowColor)
	{
		_highlightedTextShadowColor = highlightedTextShadowColor;
		
		if ([self isHighlightedOrSelected])
			[self setNeedsDisplay];
	}
}


- (void)setText:(NSString *)text
{
	if (![text isEqualToString:_text])
	{
		_text = [text copy];
		
		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setHighlightedText:(NSString *)highlightedText
{
	if (![highlightedText isEqualToString:_highlightedText])
	{
		_highlightedText = [highlightedText copy];
		
		if ([self isHighlightedOrSelected])
			[self setNeedsDisplay];
	}
}


- (void)setDisabledText:(NSString *)disabledText
{
	if (![disabledText isEqualToString:_disabledText])
	{
		_disabledText = [disabledText copy];
		
		if (self.state & UIControlStateDisabled)
			[self setNeedsDisplay];
	}
}


- (void)setAttributedText:(nullable NSAttributedString *)attributedText
{
	if (![attributedText isEqualToAttributedString:_attributedText])
	{
		_attributedText = [attributedText copy];

		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setHighlightedAttributedText:(nullable NSAttributedString *)highlightedAttributedText
{
	if (![highlightedAttributedText isEqualToAttributedString:_highlightedAttributedText])
	{
		_highlightedAttributedText = [highlightedAttributedText copy];

		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setDisabledAttributedText:(nullable NSAttributedString *)disabledAttributedText
{
	if (![disabledAttributedText isEqualToAttributedString:_disabledAttributedText])
	{
		_disabledAttributedText = [disabledAttributedText copy];

		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setGradientEnabled:(NSInteger)gradientEnabled
{
	if (gradientEnabled != _gradientEnabled)
	{
		_gradientEnabled = gradientEnabled;
		[self setNeedsDisplay];
	}
}


- (void)setGlossy:(NSInteger)glossy
{
	if (glossy != _glossy)
	{
		_glossy = glossy;
		[self setNeedsDisplay];
	}
}


- (void)setRightAccessoryImage:(UIImage *)rightAccessoryImage
{
	if (rightAccessoryImage != _rightAccessoryImage)
	{
		_rightAccessoryImage = rightAccessoryImage;
		
		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setRightHighlightedAccessoryImage:(UIImage *)rightHighlightedAccessoryImage
{
	if (rightHighlightedAccessoryImage != _rightHighlightedAccessoryImage)
	{
		_rightHighlightedAccessoryImage = rightHighlightedAccessoryImage;
		
		if ([self isHighlightedOrSelected])
			[self setNeedsDisplay];
	}
}


- (void)setLeftAccessoryImage:(UIImage *)leftAccessoryImage
{
	if (leftAccessoryImage != _leftAccessoryImage)
	{
		_leftAccessoryImage = leftAccessoryImage;
		
		if (self.state == UIControlStateNormal)
			[self setNeedsDisplay];
	}
}


- (void)setLeftHighlightedAccessoryImage:(UIImage *)leftHighlightedAccessoryImage
{
	if (leftHighlightedAccessoryImage != _leftHighlightedAccessoryImage)
	{
		_leftHighlightedAccessoryImage = leftHighlightedAccessoryImage;
		
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


- (void)setAttributedText:(nullable NSAttributedString *)attributedText forState:(UIControlState)state
{
	if (state == UIControlStateNormal)
		self.attributedText = attributedText;

	if (state & UIControlStateDisabled)
		self.disabledAttributedText = attributedText;

	if (state & UIControlStateHighlighted || state & UIControlStateSelected)
		self.highlightedAttributedText = attributedText;
}


- (void)setRightAccessoryImage:(UIImage *)rightAccessoryImage forState:(UIControlState)state
{
	if (state == UIControlStateNormal)
		self.rightAccessoryImage = rightAccessoryImage;
	
	if (state & UIControlStateHighlighted || state & UIControlStateSelected)
		self.rightHighlightedAccessoryImage = rightAccessoryImage;
}


- (void)setLeftAccessoryImage:(UIImage *)leftAccessoryImage forState:(UIControlState)state
{
	if (state == UIControlStateNormal)
		self.leftAccessoryImage = leftAccessoryImage;
	
	if (state & UIControlStateHighlighted || state & UIControlStateSelected)
		self.leftHighlightedAccessoryImage = leftAccessoryImage;
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


- (nullable NSAttributedString *)attributedTextAccordingToCurrentState
{
	NSAttributedString *attributedText = _attributedText;

	if (!self.enabled && _disabledAttributedText)
		attributedText = _disabledAttributedText;
	else if ([self isHighlightedOrSelected] && _highlightedAttributedText)
		attributedText = _highlightedAttributedText;

	return attributedText;
}


- (UIImage *)rightAccessoryImageAccordingToCurrentState
{
	UIImage *image = _rightAccessoryImage;
	
	if ([self isHighlightedOrSelected] && _rightHighlightedAccessoryImage)
		image = _rightHighlightedAccessoryImage;
	
	return image;
}


- (UIImage *)leftAccessoryImageAccordingToCurrentState
{
	UIImage *image = _leftAccessoryImage;
	
	if ([self isHighlightedOrSelected] && _leftHighlightedAccessoryImage)
		image = _leftHighlightedAccessoryImage;
	
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

#pragma mark - Layout updating

- (void)layoutSubviews
{
    [super layoutSubviews];
    [self setNeedsDisplay];
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
	NSAttributedString *attributedText = [self attributedTextAccordingToCurrentState];
	UIImage *leftImage = [self leftAccessoryImageAccordingToCurrentState];
	UIImage *rightImage = [self rightAccessoryImageAccordingToCurrentState];
	CGFloat maxHeight = CGRectGetHeight(self.bounds) - padding*2;
	
	// Draw
	[path addClip];
	
	// Draw background
	CGPoint startPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMinY(self.bounds));
	CGPoint endPoint = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMaxY(self.bounds));
	if (_gradientEnabled)
	{
		CGGradientRef gradient = [self newGradientAccordingToCurrentState];
		CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
		CGGradientRelease(gradient);
	}
	else
	{
		UIColor *tint = [self tintColorAccordingToCurrentState];
		[tint set];
		[path fill];
	}
	
	// Glossy
	if (_glossy)
	{
		CGGradientRef gradient = NVCGGradientCreate(_glossyStartColor.CGColor, _glossyEndColor.CGColor);
		endPoint.y /= 2;
		CGContextDrawLinearGradient(ctx, gradient, startPoint, endPoint, 0);
		CGGradientRelease(gradient);
	}
	
	// Draw left image
	CGRect leftAccessoryRect = CGRectZero;
	if (leftImage)
	{
		leftAccessoryRect.size.height = MIN(maxHeight, leftImage.size.height);
		leftAccessoryRect.size.width = leftAccessoryRect.size.height / leftImage.size.height * leftImage.size.width;
		leftAccessoryRect.origin.y = (CGRectGetHeight(self.bounds) - CGRectGetHeight(leftAccessoryRect)) / 2;
		leftAccessoryRect.origin.x = padding;
		[leftImage drawInRect:leftAccessoryRect];
	}
	
	// Draw right image
	CGRect rightAccessoryRect = CGRectZero;
	if (rightImage)
	{
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
	
	if (leftImage)
	{
		innerRect.size.width -= CGRectGetWidth(leftAccessoryRect);
		innerRect.origin.x = CGRectGetMaxX(leftAccessoryRect);
	}

	if (attributedText && [_titleLabel respondsToSelector:@selector(attributedText)])
	{
		_titleLabel.attributedText = attributedText;
	}
	else
	{
		_titleLabel.textColor = textColor;
		_titleLabel.shadowColor = textShadowColor;
		_titleLabel.text = text;
		[textColor set];
	}
	
	[_titleLabel drawTextInRect:innerRect];
}


#pragma mark - Touch Handling

- (BOOL)beginTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
{
	self.highlighted = YES;
	[self setNeedsDisplay];
	return [super beginTrackingWithTouch:touch withEvent:event];
}


- (BOOL)continueTrackingWithTouch:(UITouch *)touch withEvent:(nullable UIEvent *)event
{
	self.highlighted = [self isTouchInside];
	[self setNeedsDisplay];
	return [super continueTrackingWithTouch:touch withEvent:event];
}


- (void)endTrackingWithTouch:(nullable UITouch *)touch withEvent:(nullable UIEvent *)event
{
	[super endTrackingWithTouch:touch withEvent:event];
	self.highlighted = NO;
	[self setNeedsDisplay];
}


- (void)cancelTrackingWithEvent:(nullable UIEvent *)event
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


- (nullable NSString *)accessibilityLabel
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


- (nullable NSString *)accessibilityHint
{
	return [self textAccordingToCurrentState];
}


@end

NS_ASSUME_NONNULL_END