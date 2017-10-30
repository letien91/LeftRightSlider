//
//  TLLeftRightColor.h
//  LeftRightSlider
//
//  Created by TienLe on 10/11/17.
//  Copyright © 2017 TL. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TLLeftRightColor : UIView

@property (strong, nonatomic) UIColor *runingColor;
@property (strong, nonatomic) UIColor *trackColor;

- (void)drawViewFromPoint:(CGPoint)startPoint toPoint:(CGPoint)endPoint;
- (void)setupColorView:(CGRect)frame;
- (void)setupTrackView:(CGRect)frame;

@end
