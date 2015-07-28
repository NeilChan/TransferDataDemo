//
//  NextVC.h
//  TransferDataDemo
//
//  Created by 我的宝宝 on 15/7/27.
//  Copyright (c) 2015年 Caesar. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol NextVCDelegate <NSObject>
- (void)transferText: (NSString *)text;
@end

@interface NextVC : UIViewController

@property (nonatomic, assign)id<NextVCDelegate> delegate;
@property (nonatomic, copy) void(^NextVCBlock)(NSString *text);
@property (nonatomic, strong) UITextField *text;


- (id)init;
@end
