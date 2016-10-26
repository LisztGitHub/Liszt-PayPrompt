//
//  ViewController.m
//  PromptViewDemo
//
//  Created by Liszt on 16/10/25.
//  Copyright © 2016年 https://github.com/LisztGitHub. All rights reserved.
//

#import "ViewController.h"
#import "PromptView.h"
#import "PromptIndicatorView.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *desLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.titleLable.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.titleLable.layer.shadowOpacity = 0.9f;
    self.titleLable.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.titleLable.layer.shadowRadius = 2.0f;
    self.titleLable.hidden = YES;
    self.titleLable.backgroundColor = [UIColor whiteColor];
    
    self.desLabel.layer.shadowColor = [UIColor lightGrayColor].CGColor;
    self.desLabel.layer.shadowOpacity = 0.9f;
//    self.desLabel.hidden = YES;
    self.desLabel.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.desLabel.layer.shadowRadius = 2.0f;
    self.desLabel.backgroundColor = [UIColor whiteColor];
}

- (IBAction)buttonAction:(UIButton *)sender {
    if(sender.tag==11){
        [PromptView showSuccessInView:self.navigationController.view content:@"支付成功成功" duration:2.0f completion:^{
            NSLog(@"回调");
        }];
    }
    else if(sender.tag==10){
        [PromptView showIndeterminateWithInView:self.navigationController.view content:@"支付中..." duration:2.0f completion:^{
            NSLog(@"回调");
        }];
    }
    else if(sender.tag==12){
        [PromptView showErrorInView:self.navigationController.view content:@"支付失败" duration:2.0f completion:^{
            NSLog(@"回调");
        }];
    }
    else{
        [PromptView showIndeterminateWithInView:self.navigationController.view content:@"支付中..." duration:0];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
