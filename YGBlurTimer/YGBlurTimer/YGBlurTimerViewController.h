//
//  YGBlurTimerViewController.h
//
//  Created by George on 27.07.14.
//  Copyright (c) 2014 George Ymydykov. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MDRadialProgressTheme.h"
#import "MDRadialProgressView.h"
#import "MDRadialProgressLabel.h"
#import "JCRBlurView.h"

@interface YGBlurTimerViewController : UIViewController {
    UIImageView *blurBackground;
    NSTimer *timer;
    MDRadialProgressView *radialView;
}

- (id)initWithTimerValue:(NSUInteger)timerValue;

@property (nonatomic, assign) NSUInteger timerValue;

@end
