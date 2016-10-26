//
//  PromptTypeView.m
//  PromptViewDemo
//
//  Created by Liszt on 16/10/25.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import "PromptErrorView.h"
#import "PromptHeader.pch"


@interface PromptErrorView()
/** 层背景View*/
@property (strong, nonatomic) UIView *successLayerBgView;
@end

@implementation PromptErrorView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

-(void)drawRect:(CGRect)rect{
    [self drawError];
}

- (void)drawError{
    UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:CGPointMake(Item_Width/2, Item_Width/2) radius:Item_Width/2 startAngle:0 endAngle:M_PI*2 clockwise:YES];
    
    CGPoint p1 =  CGPointMake(Item_Width/4, Item_Width/4);
    [path moveToPoint:p1];
    
    CGPoint p2 =  CGPointMake(Item_Width/4*3, Item_Width/4*3);
    [path addLineToPoint:p2];
    
    CGPoint p3 =  CGPointMake(Item_Width/4*3, Item_Width/4);
    [path moveToPoint:p3];
    
    CGPoint p4 =  CGPointMake(Item_Width/4, Item_Width/4*3);
    [path addLineToPoint:p4];
    
    CAShapeLayer *layer = [[CAShapeLayer alloc] init];
    layer.lineWidth = Prompt_Line_Width;
    layer.path = path.CGPath;
    layer.fillColor = [UIColor clearColor].CGColor;
    layer.strokeColor = [UIColor redColor].CGColor;
    
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
        _successLayerBgView = [[UIView alloc] initWithFrame:CGRectMake((self.frame.size.width-Item_Width)/2, (self.frame.size.height - Item_Width)/2, Item_Width, Item_Width)];
    }
    return _successLayerBgView;
}

@end
