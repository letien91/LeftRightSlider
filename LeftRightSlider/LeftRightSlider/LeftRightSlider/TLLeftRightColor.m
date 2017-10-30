//
//  TLLeftRightColor.m
//  LeftRightSlider
//
//  Created by TienLe on 10/11/17.
//  Copyright © 2017 TL. All rights reserved.
//

#import "TLLeftRightColor.h"
#import "UIView+TLHelper.h"

@interface TLLeftRightColor ()
@property (strong, nonatomic) UIView *colorView;
@property (strong, nonatomic) UIView *trackView;
@end

@implementation TLLeftRightColor

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

- (void)setupColorView:(CGRect)frame {
    if (_colorView) {
        [_colorView removeFromSuperview];
        _colorView = nil;
    }
    _colorView = [[UIView alloc] initWithFrame:frame];
    _colorView.backgroundColor = _runingColor;
    _colorView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [self addSubview:_colorView];
    [UIView makeBorderForView:_colorView sizeCornor:4.f borderWidth:0 withColor:nil];
}

- (void)setupTrackView:(CGRect)frame {
    if (_trackView) {
        [_trackView removeFromSuperview];
        _trackView = nil;
    }
    _trackView = [[UIView alloc] initWithFrame:frame];
    _trackView.backgroundColor = _trackColor;
    _trackView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleWidth;
    [self addSubview:_trackView];
    [UIView makeBorderForView:_trackView sizeCornor:4.f borderWidth:0 withColor:nil];
}

- (void)drawViewFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint {
    if (startPoint.x < endPoint.x) {
        CGFloat width = endPoint.x - startPoint.x;
        _colorView.frame = CGRectMake(startPoint.x, _colorView.frame.origin.y, fabs(width), _colorView.frame.size.height);
    } else {
        CGFloat width = endPoint.x - startPoint.x;
        _colorView.frame = CGRectMake(endPoint.x, _colorView.frame.origin.y, fabs(width), _colorView.frame.size.height);
    }
}

@end
