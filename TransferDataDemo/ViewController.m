//
//  ViewController.m
//  TransferDataDemo
//
//  Created by 我的宝宝 on 15/7/27.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import "ViewController.h"
#import "NextVC.h"

@interface ViewController ()<NextVCDelegate>{
    
    UILabel *_useDelegateText;
    UILabel *_useBlockText;
    
    
    UIButton *_toNextVC_Delegate;
    UIButton *_toNextVC_Block;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"第一个页面";
    self.view.backgroundColor = [UIColor clearColor];
    
    [self initSubview];
}

- (void)initSubview {
    
    CGPoint center = [self.view center];
    
    _useDelegateText = [[UILabel alloc]initWithFrame:CGRectMake(center.x - 125, center.y - 100, 250, 30)];
    _useDelegateText.font = [UIFont systemFontOfSize:14.0];
    _useDelegateText.backgroundColor = [UIColor lightGrayColor];
    _useDelegateText.textAlignment = NSTextAlignmentCenter;
    [_useDelegateText setTextColor:[UIColor whiteColor]];
    [self.view addSubview:_useDelegateText];


    _useBlockText = [[UILabel alloc]initWithFrame:CGRectMake(center.x - 125, center.y - 50, 250, 30)];
    _useBlockText.font = [UIFont systemFontOfSize:14.0];
    _useBlockText.textAlignment = NSTextAlignmentCenter;
    _useBlockText.backgroundColor = [UIColor lightGrayColor];
    [_useBlockText setTextColor:[UIColor whiteColor]];
    [self.view addSubview:_useBlockText];
    
    
    _toNextVC_Delegate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _toNextVC_Delegate.frame = CGRectMake(center.x - 75, center.y + 50, 150, 30);
    [_toNextVC_Delegate setTitle:@"Delegate" forState:UIControlStateNormal];
    [_toNextVC_Delegate setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_toNextVC_Delegate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_toNextVC_Delegate setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:_toNextVC_Delegate];
    
    [_toNextVC_Delegate addTarget:self action:@selector(toNext_Delegate) forControlEvents:UIControlEventTouchUpInside];
    
    _toNextVC_Block = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _toNextVC_Block.frame = CGRectMake(center.x - 75, center.y + 100, 150, 30);
    [_toNextVC_Block setTitle:@"Block" forState:UIControlStateNormal];
    [_toNextVC_Block setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_toNextVC_Block setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_toNextVC_Block setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:_toNextVC_Block];
    
    [_toNextVC_Block addTarget:self action:@selector(toNext_Block) forControlEvents:UIControlEventTouchUpInside];
}

- (void)toNext_Delegate {
    
    NextVC *next = [[NextVC alloc]init];
    next.delegate = self;
    [self.navigationController pushViewController:next animated:YES];
}


- (void)toNext_Block {
    
    NextVC *next = [[NextVC alloc]init];
    
    next.NextVCBlock = ^(NSString *text){
        _useBlockText.text = [NSString stringWithFormat:@"I'm from block : %@", text];
    };
    [self.navigationController pushViewController:next animated:YES];
}
#pragma mark - NextVCDelegate

- (void)tranferText:(NSString *)text {
    _useDelegateText.text = [NSString stringWithFormat:@"I'm from delegate : %@", text];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
