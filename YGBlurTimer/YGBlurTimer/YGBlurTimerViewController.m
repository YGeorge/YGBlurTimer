//
//  YGBlurTimerViewController.m
//
//  Created by George on 27.07.14.
//  Copyright (c) 2014 George Ymydykov. All rights reserved.
//

#import "YGBlurTimerViewController.h"

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

@implementation YGBlurTimerViewController

- (id)initWithTimerValue: (NSUInteger)timerValue {
    self = [super init];
    if (self) {
        _timerValue = timerValue;
        UIApplication *app =  [UIApplication sharedApplication];
        UIWindow* currentWindow =app.keyWindow;
        UIGraphicsBeginImageContext(currentWindow.bounds.size);
        [currentWindow.layer renderInContext:UIGraphicsGetCurrentContext()];
        UIImage *screenshot = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        blurBackground = [[UIImageView alloc] initWithImage:screenshot];
    }
    return self;
}


- (void)loadView {
    UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
    self.view = [[UIView alloc] initWithFrame:currentWindow.frame];
    [self.view addSubview:blurBackground];

    JCRBlurView *blurView = [JCRBlurView new];
    [blurView setFrame:currentWindow.frame];
    [self.view addSubview:blurView];

    MDRadialProgressTheme *newTheme = [[MDRadialProgressTheme alloc] init];
    newTheme.completedColor = [UIColor colorWithRed:28 / 255.0 green:102 / 255.0 blue:102 / 255.0 alpha:1.0];
    newTheme.incompletedColor = [UIColor colorWithRed:102 / 255.0 green:204 / 255.0 blue:204 / 255.0 alpha:1.0];
    newTheme.centerColor = [UIColor clearColor];
    newTheme.centerColor = [UIColor colorWithRed:228 / 255.0 green:246 / 255.0 blue:247 / 255.0 alpha:1.0];
    newTheme.sliceDividerHidden = YES;
    newTheme.drawIncompleteArcIfNoProgress = YES;
    newTheme.labelColor = [UIColor blackColor];
    newTheme.labelShadowColor = [UIColor whiteColor];

    CGRect frame = IS_IPHONE_5 ? CGRectMake(60, 150, 200, 200) : CGRectMake(60, 120, 200, 200);
    radialView = [[MDRadialProgressView alloc] initWithFrame:frame andTheme:newTheme];
    radialView.progressTotal = self.timerValue;
    radialView.progressCounter = 0;
    [radialView.label setText:[self stringFromTimeInterval:self.timerValue]];
    [self.view addSubview:radialView];

    UIButton *closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [closeButton addTarget:self
                    action:@selector(closeTimerWindow:)
          forControlEvents:UIControlEventTouchUpInside];


    [closeButton setTitle:@"Close" forState:UIControlStateNormal];
    [closeButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [closeButton setFrame:CGRectMake(frame.origin.x, currentWindow.frame.size.height - 80, frame.size.width, 40.0)];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"btn@2x.png"] forState:UIControlStateNormal];
    [closeButton setBackgroundImage:[UIImage imageNamed:@"btn_h@2x.png"] forState:UIControlStateHighlighted];
    [self.view addSubview:closeButton];
}

- (void)closeTimerWindow:(id)closeTimerWindow {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (!timer.isValid) {
        timer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                                 target:self
                                               selector:@selector(updateTimerOnTick:) userInfo:nil repeats:YES];
    }
}

- (void)setTimerValue:(NSUInteger)timerValue {
    _timerValue = timerValue;
    radialView.progressCounter = radialView.progressTotal - timerValue;
    [radialView.label setText:[self stringFromTimeInterval:self.timerValue]];
}

- (void)updateTimerOnTick:(id)updateTimerOnTick {
    if (self.timerValue > 0) {
        self.timerValue--;
    }
    else {
        [self invalidateTimer];
    }
}

- (void)invalidateTimer {
    [timer invalidate];
    timer = nil;
}

- (NSString *)stringFromTimeInterval:(NSUInteger)interval {
    NSInteger seconds = interval % 60;
    NSInteger minutes = (interval / 60) % 60;
    NSString *time = [NSString stringWithFormat:@"%02i:%02i", minutes, seconds];
    return time;
}

@end
