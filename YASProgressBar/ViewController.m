//
//  ViewController.m
//  YASProgressBar
//
//  Created by Konrad on 25.01.2015.
//  Copyright (c) 2015 Konrad. All rights reserved.
//


#import "ViewController.h"
#import "YASProgressBar.h"

@interface ViewController ()
@property (nonatomic, strong) YASProgressBar *redProgressBar;
@property (nonatomic, strong) YASProgressBar *blueProgressBar;
@property (nonatomic, strong) NSTimer *taskTimer;
@property (nonatomic, assign) CGFloat taskProgress;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.taskProgress = 0.0f;
    
    self.redProgressBar = [[YASProgressBar alloc]initWithFrame:CGRectMake(100, 100, 200, 40) boarderSpacing:2.0f cornerRadius:0.0f pulse:YES animated:YES];
    [self.view addSubview:self.redProgressBar];
    
    self.blueProgressBar = [[YASProgressBar alloc]initWithFrame:CGRectMake(100, 200, 200, 40) pulse:NO animated:YES];
    self.blueProgressBar.trackColor = [UIColor colorWithRed:(61/255.0) green:(101/255.0) blue:(239/255.0) alpha:1.0];
    self.blueProgressBar.backgroundColor = [UIColor colorWithRed:(97/255.0)  green:(170/255.0)  blue:(252/255.0)  alpha:1.0];
    self.blueProgressBar.barColor = [UIColor blueColor];
    [self.view addSubview:self.blueProgressBar];
    
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    self.taskTimer = [NSTimer scheduledTimerWithTimeInterval:1.0f target:self selector:@selector(makeTaskProgress) userInfo:nil repeats:YES];
    [self.taskTimer fire];
    
}

- (void)makeTaskProgress {
    
    self.taskProgress += 0.05f;
    [self.redProgressBar setProgress:self.taskProgress];
    [self.blueProgressBar setProgress:self.taskProgress];
    
    if (self.taskProgress > 1.0f) {
        [self.taskTimer invalidate];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

