//
//  PromptSuccessView.m
//  PromptViewDemo
//
//  Created by Liszt on 16/10/25.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import "PromptSuccessView.h"

#define Prompt_Line_Width 3
#define Prompt_Width 55

@interface PromptSuccessView()
/** 层背景View*/
@property (strong, nonatomic) UIView *successLayerBgView;
@end

@implementation PromptSuccessView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [self drawSuccess];
}

- (void)drawSuccess{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(Prompt_Width/2, Prompt_Width/2) radius:Prompt_Width/2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    path.lineCapStyle = kCGLineCapRound;
    path.lineJoinStyle = kCGLineCapRound;
    
    [path moveToPoint:CGPointMake(Prompt_Width/4, Prompt_Width/2)];
    CGPoint p1 = CGPointMake(Prompt_Width/4+10, Prompt_Width/2+10);
    [path addLineToPoint:p1];
    
    CGPoint p2 = CGPointMake(Prompt_Width/4*3.5, Prompt_Width/3);
    [path addLineToPoint:p2];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor colorWithRed:0/255.0 green:174/255.0 blue:259/255.0 alpha:1].CGColor;
    layer.lineWidth = Prompt_Line_Width;
    layer.path = path.CGPath;
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:NSStringFromSelector(@selector(strokeEnd))];
    animation.fromValue = @0;
    animation.toValue = @1;
    animation.duration = 0.5;
    [layer addAnimation:animation forKey:NSStringFromSelector(@selector(strokeEnd))];
    
    [self.successLayerBgView.layer addSublayer:layer];
    [self.layer addSublayer:self.successLayerBgView.layer];
}

#pragma  mark -  懒加载
- (UIView *)successLayerBgView{
    if(!_successLayerBgView){
        _successLayerBgView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-Prompt_Width)/2, (self.frame.size.height - Prompt_Width)/2, Prompt_Width, Prompt_Width)];
    }
    return _successLayerBgView;
}

@end
