//
//  ViewController.m
//  LeftRightSlider
//
//  Created by TienLe on 10/11/17.
//  Copyright © 2017 TL. All rights reserved.
//

#import "ViewController.h"
#import "TLLeftRightSlider.h"
#import "ASValueTrackingSlider.h"

@interface ViewController () <TLColorSliderDelegate, ASValueTrackingSliderDataSource>
@property (weak, nonatomic) IBOutlet TLLeftRightSlider *outletSlider;
@property (strong, nonatomic) TLLeftRightSlider *codeSlider;
@property (strong, nonatomic) TLLeftRightSlider *customSlider;

@property (weak, nonatomic) IBOutlet UIView *codeView;
@property (weak, nonatomic) IBOutlet UIView *customView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setSliderFromOutlet];
    [self setSliderFromCode];
    [self setCustomSlider];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [_codeSlider layoutIfNeeded];
    [_codeSlider reloadData];
    [_customSlider layoutIfNeeded];
    [_customSlider reloadData];
}

- (void)setSliderFromCode {
    _codeSlider = [[TLLeftRightSlider alloc] initWithFrame:CGRectMake(1, 1, 1, 1)];
    _codeSlider.maximumValue = 1;
    _codeSlider.minimumValue = -1;
    _codeSlider.skylineValue = 0;
    _codeSlider.currentValue = 0.5;
    _codeSlider.selectedBarColor = [UIColor redColor];
    _codeSlider.unselectedBarColor = [UIColor yellowColor];
    _codeSlider.heightOfSlider = 3;
    _outletSlider.tlSliderDelegate = self;
    [_codeSlider reloadData];
    
    [_codeView addSubview:_codeSlider];
    
    [_codeSlider setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_codeView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_codeSlider]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_codeSlider)]];
    
    NSDictionary *metrics = @{@"height": [NSNumber numberWithFloat:40],
                              @"top": [NSNumber numberWithFloat:60]};
    [_codeView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_codeSlider(height)]-(top)-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_codeSlider)]];
    
}

- (void)setSliderFromOutlet {
    _outletSlider.maximumValue = 100;
    _outletSlider.minimumValue = 0;
    _outletSlider.skylineValue = 20;
    _outletSlider.currentValue = 20;
    _outletSlider.selectedBarColor = [UIColor redColor];
    _outletSlider.unselectedBarColor = [UIColor yellowColor];
    _outletSlider.handlerColor = [UIColor orangeColor];
    _outletSlider.heightOfSlider = 6;
    _outletSlider.tlSliderDelegate = self;
    [_outletSlider reloadData];
}

- (void)setCustomSlider {
    _customSlider = [[TLLeftRightSlider alloc] initWithFrame:CGRectMake(1, 1, 1, 1) customSlider:[self tlCustomSlider]];
    _customSlider.maximumValue = 1;
    _customSlider.minimumValue = -1;
    _customSlider.skylineValue = 0;
    _customSlider.currentValue = 0.5;
    _customSlider.selectedBarColor = [UIColor redColor];
    _customSlider.unselectedBarColor = [UIColor yellowColor];
    _customSlider.handlerColor = [UIColor blueColor];
    _customSlider.heightOfSlider = 6;
    _customSlider.tlSliderDelegate = self;
    [_customSlider reloadData];
    
    [_customView addSubview:_customSlider];
    
    [_customSlider setTranslatesAutoresizingMaskIntoConstraints:NO];
    [_customView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-10-[_customSlider]-10-|" options:0 metrics:nil views:NSDictionaryOfVariableBindings(_customSlider)]];
    
    NSDictionary *metrics = @{@"height": [NSNumber numberWithFloat:40],
                              @"top": [NSNumber numberWithFloat:60]};
    [_customView addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_customSlider(height)]-(top)-|" options:0 metrics:metrics views:NSDictionaryOfVariableBindings(_customSlider)]];
    [_customView layoutIfNeeded];
    [_customSlider layoutIfNeeded];
}

#pragma mark - TLColorSliderDelegate
- (void)tlSlider:(UISlider *)slider changeToValue:(CGFloat)value {
//    NSLog(@"Slider: %@ changeToValue: %f", slider, value);
}

- (void)tlSlider:(UISlider *)slider didEndSliding:(CGFloat)value {
//    NSLog(@"Slider: %@ didEndSliding: %f", slider, value);
}

#pragma mark - Custom Slider Delegate
- (UISlider *)tlCustomSlider {
    ASValueTrackingSlider *_slider = [[ASValueTrackingSlider alloc] initWithFrame:_customSlider.bounds];
    _slider.dataSource = self;
    _slider.popUpViewCornerRadius = 10.0;
    _slider.popUpViewArrowLength = 20.0;
    _slider.font = [UIFont fontWithName:@"HelveticaNeue-CondensedBold" size:17];
    _slider.textColor = [UIColor whiteColor];
    _slider.popUpViewAnimatedColors = @[[UIColor purpleColor]];
    _slider.backgroundColor = [UIColor clearColor];
    return _slider;
}

- (NSString *)slider:(ASValueTrackingSlider *)slider stringForValue:(float)value {
    return [NSString stringWithFormat:@"%.2f", value];
}
@end
