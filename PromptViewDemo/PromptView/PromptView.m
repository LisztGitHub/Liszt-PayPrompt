//
//  PromptView.m
//  PromptViewDemo
//
//  Created by Liszt on 16/10/25.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import "PromptView.h"
#import "PromptIndicatorView.h"
#import "PromptErrorView.h"
#import "PromptSuccessView.h"
#import "PromptHeader.pch"

#define Self_Tag 99325

@interface PromptView()
/** contentView*/
@property (strong, nonatomic) UIView *contentView;
/** 标题*/
@property (strong, nonatomic) UILabel *titleLabel;
/** customView*/
@property (strong, nonatomic) UIView *customView;
/** block回调*/
@property (copy, nonatomic) PromptCompletionBlock completionBlock;
/** offset_y*/
@property (assign, nonatomic) CGFloat offset_y;
@end

@implementation PromptView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        /** 1.添加试图*/
        [self addSubview:self.contentView];
        [self.contentView addSubview:self.titleLabel];
        
        /** 2.显示指示层*/
        [self show];
    }
    return self;
}

- (void)show{
    self.backgroundColor = [UIColor clearColor];
    self.contentView.transform = CGAffineTransformMakeScale(1.1, 1.1);
    self.contentView.alpha = .6;
    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        self.contentView.transform = CGAffineTransformIdentity;
        self.contentView.alpha = 1;
        self.backgroundColor = [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:0.2f];
    } completion:^(BOOL finished){
        /** 显示完成 可做代理回调*/
    }];
}

- (void)dismiss{
    [self removeFromSuperview];
    self.customView = nil;
    if(self.completionBlock){
        self.completionBlock();
    }
}

- (void)setOffset_y:(CGFloat)offset_y{
    _offset_y = offset_y;
    
    CGRect tempFrame = self.contentView.frame;
    tempFrame.origin.y = tempFrame.origin.y + offset_y;
    self.contentView.frame = tempFrame;
}

#pragma mark - 懒加载
- (UILabel *)titleLabel{
    if(!_titleLabel){
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, self.contentView.frame.size.height - 10 - proWidth * 20, self.contentView.frame.size.width - 10, proWidth * 20)];
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}
- (UIView *)contentView{
    if(!_contentView){
        _contentView = [[UIView alloc]initWithFrame:CGRectMake((self.frame.size.width - proWidth * 120)/2, (self.frame.size.height - proWidth * 120)/2, proWidth * 120, proWidth * 120)];
        _contentView.backgroundColor = [UIColor whiteColor];
        _contentView.layer.cornerRadius = 8;
        _contentView.layer.masksToBounds = YES;
    }
    return _contentView;
}

-(void)setCustomView:(UIView *)customView{
    _customView = customView;
    _customView.frame = CGRectMake(0, 0, CGRectGetWidth(self.contentView.frame), CGRectGetHeight(self.contentView.frame) - proWidth * 20 - 10);
    [self.contentView addSubview:_customView];
}

#pragma mark - public function
+(void)hideInView:(UIView *)inView{
    for(UIView *view in inView.subviews){
        if(view.tag==Self_Tag){
            [view removeFromSuperview];
        }
    }
}

+(void)showSuccessInView:(UIView *)inView content:(NSString *)content{
    [self showSuccessInView:inView content:content duration:0.f];
}
+(void)showSuccessInView:(UIView *)inView content:(NSString *)content duration:(NSTimeInterval)duration{
    [self showSuccessInView:inView content:content duration:duration completion:nil];
}
+(void)showSuccessInView:(UIView *)inView content:(NSString *)content duration:(NSTimeInterval)duration completion:(PromptCompletionBlock)completionBlock{
    PromptSuccessView *successView = [[PromptSuccessView alloc]init];
    [self showInView:inView content:content customView:successView duration:duration completion:completionBlock];
}

+ (void)showErrorInView:(UIView *)inView content:(NSString *)content{
    [self showErrorInView:inView content:content duration:0.f];
}
+ (void)showErrorInView:(UIView *)inView content:(NSString *)content duration:(NSTimeInterval)duration{
    [self showErrorInView:inView content:content duration:duration completion:nil];
}
+ (void)showErrorInView:(UIView *)inView content:(NSString *)content duration:(NSTimeInterval)duration completion:(PromptCompletionBlock)completionBlock{
    PromptErrorView *successView = [[PromptErrorView alloc]init];
    [self showInView:inView content:content customView:successView duration:duration completion:completionBlock];
}

+ (void)showIndeterminateWithInView:(UIView *)inView content:(NSString *)content{
    [self showIndeterminateWithInView:inView content:content duration:0.f];
}
+ (void)showIndeterminateWithInView:(UIView *)inView content:(NSString *)content duration:(NSTimeInterval)duration{
    [self showIndeterminateWithInView:inView content:content duration:duration completion:nil];
}
+ (void)showIndeterminateWithInView:(UIView *)inView content:(NSString *)content duration:(NSTimeInterval)duration completion:(PromptCompletionBlock)completionBlock{
    PromptIndicatorView *indicatorView = [[PromptIndicatorView alloc]init];
    [indicatorView startAnimation];
    
    [self showInView:inView content:content customView:indicatorView duration:duration completion:completionBlock];
}

+(void)showInView:(UIView *)inView content:(NSString *)content customView:(UIView *)customView{
    [self showInView:inView content:content customView:customView duration:0.f];
}
+(void)showInView:(UIView *)inView content:(NSString *)content customView:(UIView *)customView duration:(NSTimeInterval)duration{
    [self showInView:inView content:content customView:customView duration:duration completion:nil];
}
+(void)showInView:(UIView *)inView content:(NSString *)content customView:(UIView *)customView duration:(NSTimeInterval)duration completion:(PromptCompletionBlock)completionBlock{
    PromptView *prompt = [[PromptView alloc] initWithFrame:inView.bounds];
    prompt.titleLabel.text = content;
    prompt.offset_y = -50;
    prompt.tag=Self_Tag;
    prompt.customView = customView;
    [inView addSubview:prompt];
    prompt.completionBlock = completionBlock;
    if(duration>0.f){
        [prompt performSelector:@selector(dismiss) withObject:nil afterDelay:duration];
    }
}

@end
