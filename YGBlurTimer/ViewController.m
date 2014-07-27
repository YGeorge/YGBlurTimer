//
//  ViewController.m
//  YGBlurTimer
//
//  Created by George on 27.07.14.
//  Copyright (c) 2014 George Ymydykov. All rights reserved.
//

#import "ViewController.h"
#import "YGBlurTimerViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)closeTimerWindow {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)showTimer:(id)sender {
    YGBlurTimerViewController *timerVC = [[YGBlurTimerViewController alloc] initWithTimerValue:90];
    [self presentViewController:timerVC animated:YES completion:nil];
}

@end
