//
//  TLLeftRightSlider.h
//  TLLeftRightSlider
//
//  Created by TienLe on 10/11/17.
//  Copyright © 2017 TL. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TLColorSliderDelegate <NSObject>
@optional
- (void)tlSlider:(UISlider *)slider changeToValue:(CGFloat)value;
- (void)tlSlider:(UISlider *)slider didEndSliding:(CGFloat)value;
@end


@interface TLLeftRightSlider : UIView

@property (assign, nonatomic) CGFloat skylineValue;
@property (assign, nonatomic) CGFloat minimumValue;
@property (assign, nonatomic) CGFloat maximumValue;
@property (assign, nonatomic) CGFloat currentValue;

@property (assign, nonatomic) CGFloat heightOfSlider;

@property (nonatomic) UIColor *selectedBarColor;
@property (nonatomic) UIColor *unselectedBarColor;
@property (nonatomic) UIColor *handlerColor;

@property (strong, nonatomic) UISlider *slider;

@property (assign, nonatomic) IBOutlet id<TLColorSliderDelegate> tlSliderDelegate;

- (id)initWithFrame:(CGRect)frame customSlider:(UISlider *)customSider;

- (void)reloadData;
- (void)setValue:(CGFloat)value animated:(BOOL)animated;

@end
