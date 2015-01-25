//
//  YASProgressBar.m
//  YASProgressBar
//
//  Created by Konrad on 25.01.2015.
//  Copyright (c) 2015 Konrad. All rights reserved.
//

#import "YASProgressBar.h"

#import "YASProgressBar.h"

@interface YASProgressBar ()
@property (nonatomic, strong) CALayer *maskLayer;
@property (nonatomic, strong) CALayer *barLayer;
@property (nonatomic, strong) CALayer *trackLayer;
@property (nonatomic, assign) CGFloat boarderSpacing;
@property (nonatomic, assign) CGFloat roundedCorners;
@property (nonatomic, assign) BOOL pulse;
@property (nonatomic, assign) BOOL animated;

@end


@implementation YASProgressBar

@synthesize progress = _progress;


// designated initializer
- (instancetype)initWithFrame:(CGRect)frame boarderSpacing:(CGFloat)boarderSpacing cornerRadius:(CGFloat)cornerRadius pulse:(BOOL)pulse  animated:(BOOL)animated {
    self = [super initWithFrame:frame];
    if (self) {
        
        _boarderSpacing = boarderSpacing;
        _pulse = pulse;
        _animated = animated;
        _progress = 0;
        
        _trackLayer = [CALayer layer];
        _trackLayer.frame = CGRectMake(_boarderSpacing, _boarderSpacing, frame.size.width - 2*_boarderSpacing, frame.size.height - 2*_boarderSpacing);
        [self.layer addSublayer:_trackLayer];
        
        _barLayer = [CALayer layer];
        _barLayer.frame = CGRectMake(_boarderSpacing, _boarderSpacing, frame.size.width - 2*_boarderSpacing, frame.size.height - 2*_boarderSpacing);
        [self.layer addSublayer:_barLayer];
        
        _maskLayer = [CALayer layer];
        _maskLayer.frame = CGRectMake(0, 0, 0, frame.size.height);
        [self.layer addSublayer:_maskLayer];
        _maskLayer.backgroundColor = [UIColor blackColor].CGColor;
        [_barLayer setMask:_maskLayer];
        
        // default colors
        _trackLayer.backgroundColor = [UIColor colorWithRed:(232/255.0) green:(113/255.0) blue:(35/255.0) alpha:1.0].CGColor;
        _barLayer.backgroundColor = [UIColor redColor].CGColor;
        self.backgroundColor = [UIColor colorWithRed:(240/255.0) green:(147/255.0) blue:(8/255.0) alpha:1.0];
        
        [self setRoundedCorners:cornerRadius];
        
        if (_pulse) {
            [self animateWithPulse];
        }
    }
    return self;
}

// secondary initializer
- (instancetype)initWithFrame:(CGRect)frame pulse:(BOOL)pulse animated:(BOOL)animated {
    return [self initWithFrame:frame boarderSpacing:5.0f cornerRadius:5.0f pulse:pulse animated:animated];
}

// secondary initializer
- (instancetype)initWithFrame:(CGRect)frame animated:(BOOL)animated {
    return [self initWithFrame:frame boarderSpacing:5.0f cornerRadius:5.0f pulse:YES animated:animated];
}

// overriding the immediate superclass's designated initializer
- (instancetype)initWithFrame:(CGRect)frame {
    return [self initWithFrame:frame boarderSpacing:5.0f cornerRadius:5.0f pulse:YES animated:YES];
}


#pragma mark -
#pragma mark - setters & getters

- (UIColor *)barColor {
    return (id) self.barLayer.backgroundColor;
}

- (void)setBarColor:(UIColor *)barColor {
    self.barLayer.backgroundColor = barColor.CGColor;
}


- (UIColor *)trackColor {
    return (id) self.trackLayer.backgroundColor;
}

- (void)setTrackColor:(UIColor *)trackColor {
    self.trackLayer.backgroundColor = trackColor.CGColor;
}


- (CGFloat)progress {
    return _progress;
}

- (void)setProgress:(CGFloat)progress {
    if (self.animated) {
        [self setProgress:progress animated:YES];
    }else {
        [self setProgress:progress animated:NO];
    }
}

#pragma mark -

- (void)setRoundedCorners:(CGFloat)roundedCorners {
    self.layer.cornerRadius = roundedCorners;
    
    CGFloat ratio;
    ratio = self.layer.frame.size.width / self.layer.cornerRadius;
    
    self.barLayer.cornerRadius = floor(self.barLayer.frame.size.width / ratio);
    self.trackLayer.cornerRadius = floor(self.trackLayer.frame.size.width / ratio);
    
}

- (void)setProgress:(CGFloat)progress animated:(BOOL)animated {
    //NSLog(@"progress: %f", progress);
    
    if (progress >= 1.0f) {
        progress = 1.0f;
        [self barDidFinishedProgressing];
    }
    
    _progress = progress;
    
    CGRect rect = self.maskLayer.frame;
    rect.size.width = self.frame.size.width * self.progress;
    
    if (animated) {
        [CATransaction begin];
        [CATransaction setAnimationDuration:0.25f];
        self.maskLayer.frame = rect;
        [CATransaction commit];
    }else {
        [CATransaction begin];
        [CATransaction setValue:(id)kCFBooleanTrue forKey:kCATransactionDisableActions];
        self.maskLayer.frame = rect;
        [CATransaction commit];
    }
    
}

- (void) animateWithPulse {
    CABasicAnimation *pulseAnimation = [CABasicAnimation animationWithKeyPath:@"opacity"];
    pulseAnimation.duration = 0.25f;
    pulseAnimation.repeatCount = HUGE_VALF;
    pulseAnimation.autoreverses = YES;
    pulseAnimation.fromValue = [NSNumber numberWithFloat:1.0f];
    pulseAnimation.toValue = [NSNumber numberWithFloat:0.0f];
    [self.barLayer addAnimation:pulseAnimation forKey:@"pulseAnimation"];
}

- (void)barDidFinishedProgressing {
    if (self.pulse) {
        [self.barLayer removeAnimationForKey:@"pulseAnimation"];
    }
}






@end