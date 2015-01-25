//
//  YASProgressBar.h
//  YASProgressBar
//
//  Created by Konrad on 25.01.2015.
//  Copyright (c) 2015 Konrad. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YASProgressBar : UIView
@property (nonatomic, strong) UIColor *barColor;
@property (nonatomic, strong) UIColor *trackColor;
@property (nonatomic, assign) CGFloat progress;

/**
 * Designated initializer.
 *
 * @param frame Sets the frame of YASProgressBar object.
 * @param boarderSpacing Sets the distance between the progress bar and its frame.
 * @param cornerRadius Sets cornerRadius of all layers in YASProgressBar object.
 * @param pulse Adds pulse animation of the progres bar while moving.
 * @param animated Sets CALayer implicit animation while moving progress bar.
 *
 * @return A YASProgressBar object.
 */
- (instancetype)initWithFrame:(CGRect)frame boarderSpacing:(CGFloat)boarderSpacing cornerRadius:(CGFloat)cornerRadius pulse:(BOOL)pulse animated:(BOOL)animated;


- (instancetype)initWithFrame:(CGRect)frame pulse:(BOOL)pulse animated:(BOOL)animated;


- (instancetype)initWithFrame:(CGRect)frame animated:(BOOL)animated;


- (void)setProgress:(CGFloat)progress animated:(BOOL)animated;



@end