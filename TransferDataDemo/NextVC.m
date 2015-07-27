//
//  NextVC.m
//  TransferDataDemo
//
//  Created by 我的宝宝 on 15/7/27.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import "NextVC.h"

@interface NextVC ()
{
    UIButton *_useDelegate;
    UIButton *_useBlock;
    UIButton *_useNotice;
}
@end

@implementation NextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"第二个页面";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self initSubview];
}

- (void)initSubview {
    CGPoint center = self.view.center;
    
    
    _text = [[UITextField alloc]initWithFrame:CGRectMake(center.x - 75, 200, 150, 30)];
    _text.textColor = [UIColor lightGrayColor];
    _text.font = [UIFont systemFontOfSize:14.0];
    _text.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:_text];
    
    _useDelegate = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _useDelegate.frame = CGRectMake(center.x - 75, 250, 150, 30);
    [_useDelegate setTitle:@"使用Delegate传值" forState:UIControlStateNormal];
    [_useDelegate setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_useDelegate setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_useDelegate setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:_useDelegate];
    
    [_useDelegate addTarget:self action:@selector(tranferUseDelegate) forControlEvents:UIControlEventTouchUpInside];
    
    _useBlock = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _useBlock.frame = CGRectMake(center.x - 75, 300, 150, 30);
    [_useBlock setTitle:@"使用Block传值" forState:UIControlStateNormal];
    [_useBlock setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_useBlock setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_useBlock setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:_useBlock];
    
    [_useBlock addTarget:self action:@selector(transferUseKVO) forControlEvents:UIControlEventTouchUpInside];
    
    _useNotice = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    _useNotice.frame = CGRectMake(center.x - 75, 350, 150, 30);
    [_useNotice setTitle:@"使用notice传值" forState:UIControlStateNormal];
    [_useNotice setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [_useNotice setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_useNotice setBackgroundColor:[UIColor greenColor]];
    [self.view addSubview:_useNotice];
    
    [_useNotice addTarget:self action:@selector(tranferUseNotice) forControlEvents:UIControlEventTouchUpInside];
}


/**
 *  @author Chan
 *
 *  @brief  使用Delegate进行页面传值
 */
- (void)tranferUseDelegate {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(tranferText:)]) {
        [self.delegate tranferText:_text.text];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}


/**
 *  @author Chan
 *
 *  @brief  使用Block进行页面传值
 */
- (void)tranferUseBlock {
    if (self.NextVCBlock) {
        self.NextVCBlock(_text.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)tranferUseNotice {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"tranferText" object:_text.text];
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)transferUseKVO {
    [self setValue:_text.text forKey:@"text.text"];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
