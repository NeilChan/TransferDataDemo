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
    UILabel *_useNoticeText;
    
    
    UIButton *_toNextVC_Delegate;
    UIButton *_toNextVC_Block;
    UIButton *_toNextVC_Notice;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"第一个页面";
    self.view.backgroundColor = [UIColor clearColor];
    
    NextVC *next = [[NextVC alloc]init];
    
    next.NextVCBlock = ^(NSString *text){
        _useBlockText.text = [NSString stringWithFormat:@"I'm from foo block : %@", text];
    };
    
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
    
    _useNoticeText = [[UILabel alloc]initWithFrame:CGRectMake(center.x - 125, center.y, 250, 30)];
    _useNoticeText.font = [UIFont systemFontOfSize:14.0];
    _useNoticeText.textAlignment = NSTextAlignmentCenter;
    _useNoticeText.backgroundColor = [UIColor lightGrayColor];
    [_useNoticeText setTextColor:[UIColor whiteColor]];
    [self.view addSubview:_useNoticeText];
    
    
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
    
    _toNextVC_Notice = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _toNextVC_Notice.frame = CGRectMake(center.x - 75, center.y + 150, 150, 30);
    [_toNextVC_Notice setTitle:@"Notice" forState:UIControlStateNormal];
    [_toNextVC_Notice setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_toNextVC_Notice setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_toNextVC_Notice setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:_toNextVC_Notice];
    
    [_toNextVC_Notice addTarget:self action:@selector(toNext_Notice) forControlEvents:UIControlEventTouchUpInside];
    [self addNotice];
}

- (void)addNotice {
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"tranferText" object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotice:) name:@"tranferText" object:nil];
}

- (void)toNext_Notice {
    NextVC *next = [[NextVC alloc]init];
    [self.navigationController pushViewController:next animated:YES];
}

- (void)receiveNotice:(NSNotification *)notice {
    NSString *text = (NSString *)notice.object;
    _useNoticeText.text = [NSString stringWithFormat:@"I'm from notice : %@", text];
}

- (void)toNext_Delegate {
    
    NextVC *next = [[NextVC alloc]init];
    next.delegate = self;
    [self.navigationController pushViewController:next animated:YES];
}

/**
 *  @author Chan
 *
 *  @brief  按钮事件：进入下个页面，指定Block回调函数
 */
- (void)toNext_Block {
    
    NextVC *next = [[NextVC alloc]init];
    
    __weak typeof (NextVC) *weakNext = next;
    
    weakNext.NextVCBlock = ^(NSString *text){
        _useBlockText.text = [NSString stringWithFormat:@"I'm from block : %@", text];
        NSLog(@"I'm weakNext == %@",weakNext.description);
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
