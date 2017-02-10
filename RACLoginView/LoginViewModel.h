//
//  LoginViewModel.h
//  RACLoginView
//
//  Created by rocky on 17/2/10.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AccountModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LoginViewModel : NSObject
@property (nonatomic, strong) AccountModel *account;

// 是否允许登陆的信号
@property (nonatomic, strong, readonly) RACSignal *enableLoginSignal;
@property (nonatomic, strong, readonly) RACCommand *loginCommand;
@end
