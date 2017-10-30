//
//  UIView+TLHelper.m
//  LeftRightSlider
//
//  Created by TienLe on 10/11/17.
//  Copyright © 2017 TL. All rights reserved.
//

#import "UIView+TLHelper.h"

@implementation UIView (TLHelper)

+ (void)makeBorderForView:(UIView *)view
               sizeCornor:(CGFloat)cornor
              borderWidth:(CGFloat)borderWidth
                withColor:(UIColor *)color {
    view.layer.cornerRadius = cornor;
    view.layer.borderColor = [color CGColor];
    [view.layer setBorderWidth:borderWidth];
    view.layer.masksToBounds = YES;
}

@end
