//
//  PromptIndicatorView.m
//  PromptViewDemo
//
//  Created by Liszt on 16/10/25.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import "PromptIndicatorView.h"

@interface PromptIndicatorView()
/** 动画层*/
@property (strong, nonatomic) CALayer *spotLayer;
@property (strong, nonatomic) CAReplicatorLayer *replicatorLayer;

/** 指示层高度*/
@property (assign, nonatomic) CGSize size;
@end

@implementation PromptIndicatorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.layer.backgroundColor = [UIColor clearColor].CGColor;
        self.layer.speed = 1.0f;
        self.layer.opacity = 1.0;
    }
    return self;
}

- (void)setFrame:(CGRect)frame{
    self.replicatorLayer.frame = CGRectMake((frame.size.width - _size.width)/2, (frame.size.height - _size.height)/2, _size.width, _size.height);
}

- (void)configAnimationAtLayer:(CALayer *)layer withTintColor:(UIColor *)color size:(CGSize)size{
    _size = size;
    self.replicatorLayer.frame = CGRectMake(0, 0, _size.width, _size.height);
    [layer addSublayer:self.replicatorLayer];
    [self addCyclingSpotAnimationLayerAtLayer:self.replicatorLayer withTintColor:color size:size];
    
    NSInteger numOfDot = 15;
    self.replicatorLayer.instanceCount = numOfDot;
    CGFloat angle = (M_PI * 2)/numOfDot;
    self.replicatorLayer.instanceTransform = CATransform3DMakeRotation(angle, 0, 0, 1);
    self.replicatorLayer.instanceDelay = 1.5/numOfDot;
}
- (void)addCyclingSpotAnimationLayerAtLayer:(CALayer *)layer withTintColor:(UIColor *)color size:(CGSize)size{
    self.spotLayer = [CALayer layer];
    self.spotLayer.bounds = CGRectMake(0, 0, size.width/6, size.width/6);
    self.spotLayer.position = CGPointMake(size.width/2, 5);
    self.spotLayer.cornerRadius = self.spotLayer.bounds.size.width/2;
    self.spotLayer.backgroundColor = color.CGColor;
    self.spotLayer.transform = CATransform3DMakeScale(0.1, 0.1, 0.1);
    
    [layer addSublayer:self.spotLayer];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.fromValue = @1;
    animation.toValue = @0.1;
    animation.duration = 1.5;
    animation.repeatCount = CGFLOAT_MAX;
    
    [self.spotLayer addAnimation:animation forKey:@"animation"];
}

#pragma mark - 懒加载
- (CAReplicatorLayer *)replicatorLayer{
    if(!_replicatorLayer){
        _replicatorLayer = [CAReplicatorLayer layer];
        _replicatorLayer.position = CGPointMake(0,0);
        _replicatorLayer.backgroundColor = [UIColor clearColor].CGColor;
    }
    return _replicatorLayer;
}

#pragma mark - public funtion
-(void)startAnimation{
    [self configAnimationAtLayer:self.layer withTintColor:[UIColor colorWithRed:0/255.0 green:174/255.0 blue:259/255.0 alpha:1] size:CGSizeMake(55, 55)];
}
-(void)stopAnimation{
    [self.spotLayer removeAnimationForKey:@"animation"];
}
@end
