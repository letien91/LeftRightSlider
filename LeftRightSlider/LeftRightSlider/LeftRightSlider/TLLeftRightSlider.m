//
//  TLLeftRightSlider.m
//  TLLeftRightSlider
//
//  Created by TienLe on 10/11/17.
//  Copyright © 2017 TL. All rights reserved.
//

#import "TLLeftRightSlider.h"
#import "TLLeftRightColor.h"

#define kTLColorSliderHeight 3

@interface TLLeftRightSlider ()

@property (strong, nonatomic) TLLeftRightColor *colorView;
@property (assign, nonatomic) CGPoint currentSliderPoint;
@property (assign, nonatomic) CGPoint firstSliderPoint;

@end

@implementation TLLeftRightSlider

- (id)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setup];
    }
    return self;
}

- (id)initWithFrame:(CGRect)frame customSlider:(UISlider *)customSider {
    self = [super initWithFrame:frame];
    if (self) {
        _slider = customSider;
        [self setup];
        
    }
    return self;
}

#pragma mark - Slider
- (void)setup {
    self.backgroundColor = [UIColor clearColor];
    
    _maximumValue = 1;
    _minimumValue = 0;
    _skylineValue = 0;
    _currentValue = 0;
    _heightOfSlider = kTLColorSliderHeight;
    
    self.selectedBarColor = [UIColor colorWithRed:179/255.0 green:179/255.0 blue:193/255.0 alpha:0.8];
    self.unselectedBarColor = [UIColor colorWithRed:55/255.0 green:55/255.0 blue:94/255.0 alpha:0.8];
    
    [self setupSliderView];
    [self runningColorView];
    [self bringSubviewToFront:_slider];
}

- (void)reloadData {
    
    _slider.maximumValue = _maximumValue;
    _slider.minimumValue = _minimumValue;
    [_slider setValue:_currentValue animated:NO];
    
    _colorView.runingColor = _selectedBarColor;
    _colorView.trackColor = _unselectedBarColor;
    
    if (_heightOfSlider == 0) {
        _heightOfSlider = kTLColorSliderHeight;
    }
    
    [_colorView setupTrackView:CGRectMake([self minPostion],
                                          _colorView.frame.size.height/2 - _heightOfSlider/2,
                                          [self maxPostion] - [self minPostion],
                                          _heightOfSlider)];
    [_colorView setupColorView:CGRectMake([self defaultSliderPoint].x,
                                          _colorView.frame.size.height/2 - _heightOfSlider/2,
                                          _heightOfSlider,
                                          _heightOfSlider)];
    [_colorView drawViewFromPoint:[self defaultSliderPoint] toPoint:[self firstSliderPoint]];
}

- (void)setHeightOfSlider:(CGFloat)heightOfSlider {
    _heightOfSlider = heightOfSlider;
}

- (void)setHandlerColor:(UIColor *)handlerColor {
    _handlerColor = handlerColor;
    if (_handlerColor) {
        [_slider setThumbImage:[UIImage imageNamed:@"thumbTint.png"] forState:UIControlStateNormal];
        _slider.thumbTintColor = _handlerColor;
    }
}

- (void)setupSliderView {
 
    if (!_slider) {
        _slider = [[UISlider alloc] initWithFrame:self.bounds];
        [_slider setBackgroundColor:[UIColor clearColor]];
    }
    
    [_slider setMinimumTrackImage:[[UIImage alloc] init] forState:UIControlStateNormal];
    [_slider setMaximumTrackImage:[[UIImage alloc] init] forState:UIControlStateNormal];
    
    _slider.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(sliderDidEndSliding:) forControlEvents:(UIControlEventTouchUpInside | UIControlEventTouchUpOutside)];
    _slider.maximumValue = _maximumValue;
    _slider.minimumValue = _minimumValue;
    [_slider setValue:_currentValue animated:NO];
    
    [self addSubview:_slider];
}

- (void)setSlider:(UISlider *)slider {
    [self addSubview:slider];
}

- (void)sliderDidEndSliding:(UISlider *)aSlider {
    if (_tlSliderDelegate && [_tlSliderDelegate respondsToSelector:@selector(tlSlider:didEndSliding:)]) {
        [_tlSliderDelegate tlSlider:aSlider didEndSliding:aSlider.value];
    }
}

- (void)sliderValueChanged:(UISlider *)aSlider {
    CGRect trackRect = [_slider trackRectForBounds:_slider.bounds];
    CGRect thumbRect = [_slider thumbRectForBounds:_slider.bounds trackRect:trackRect value:_slider.value];
    
    CGPoint point = CGPointMake(thumbRect.origin.x + thumbRect.size.width/2, thumbRect.origin.y);
    _currentSliderPoint = point;
    
    [_colorView drawViewFromPoint:[self defaultSliderPoint] toPoint:_currentSliderPoint];
    
    if (_tlSliderDelegate && [_tlSliderDelegate respondsToSelector:@selector(tlSlider:changeToValue:)]) {
        [_tlSliderDelegate tlSlider:aSlider changeToValue:aSlider.value];
    }
}

- (void)setValue:(CGFloat)value animated:(BOOL)animated {
    _currentValue = value;
    [_slider setValue:value animated:animated];
    [self reloadData];
}

- (CGPoint)defaultSliderPoint {
    
    CGFloat ranger = _maximumValue - _minimumValue;
    CGFloat minValue = _skylineValue - _minimumValue;
    
    CGFloat currentX = [self minPostion] + ([self maxPostion] - [self minPostion])/(ranger * 1.0) * minValue ;
    
    return CGPointMake(currentX, 0);
}

- (CGPoint)firstSliderPoint {
    CGFloat ranger = _maximumValue - _minimumValue;
    CGFloat minValue = _currentValue - _minimumValue;
    
    CGFloat currentX = [self minPostion] + ([self maxPostion] - [self minPostion])/(ranger * 1.0) * minValue ;
    
    return CGPointMake(currentX, 0);
}

- (CGFloat)minPostion {
    CGRect trackRect = [_slider trackRectForBounds:_slider.bounds];
    CGRect thumbRect = [_slider thumbRectForBounds:_slider.bounds trackRect:trackRect value:_slider.value];
    
    return thumbRect.size.width/4.f;
}

- (CGFloat)maxPostion {
    CGRect trackRect = [_slider trackRectForBounds:_slider.bounds];
    CGRect thumbRect = [_slider thumbRectForBounds:_slider.bounds trackRect:trackRect value:_slider.value];
    
    return trackRect.size.width - thumbRect.size.width/4.f;
}

#pragma mark - RunningView
- (void)runningColorView {
    if (_colorView) {
        [_colorView removeFromSuperview];
        _colorView = nil;
    }
    _colorView = [[TLLeftRightColor alloc] initWithFrame:self.bounds];
    _colorView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    _colorView.backgroundColor = [UIColor clearColor];
    _colorView.runingColor = _selectedBarColor;
    _colorView.trackColor = _unselectedBarColor;
    
    [_colorView setupTrackView:CGRectMake([self minPostion],
                                          _colorView.frame.size.height/2 - _heightOfSlider/2,
                                          [self maxPostion] - [self minPostion],
                                          _heightOfSlider)];
    [_colorView setupColorView:CGRectMake([self defaultSliderPoint].x,
                                          _colorView.frame.size.height/2 - _heightOfSlider/2,
                                          _heightOfSlider,
                                          _heightOfSlider)];
    
    [self addSubview:_colorView];
    [_colorView drawViewFromPoint:[self defaultSliderPoint] toPoint:[self firstSliderPoint]];
    
}

@end
