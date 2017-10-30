//
//  UIView+TLHelper.h
//  LeftRightSlider
//
//  Created by TienLe on 10/11/17.
//  Copyright © 2017 TL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (TLHelper)

+ (void)makeBorderForView:(UIView *)view
               sizeCornor:(CGFloat)cornor
              borderWidth:(CGFloat)borderWidth
                withColor:(UIColor *)color;
@end
