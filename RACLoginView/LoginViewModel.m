//
//  LoginViewModel.m
//  RACLoginView
//
//  Created by rocky on 17/2/10.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import "LoginViewModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "NetWork.h"

@implementation LoginViewModel

- (AccountModel *)account{
    if (_account == nil) {
        _account = [[AccountModel alloc]init];
    }
    return _account;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self initialBind];
    }
    return self;
}

// 初始化绑定
- (void)initialBind{
    // 监听账号的属性值改变，把他们聚合成一个信号
    _enableLoginSignal = [RACSignal combineLatest:@[RACObserve(self.account, userName), RACObserve(self.account, password)] reduce:^id(NSString *userName, NSString *pwd){
//        NSLog(@"---%@",userName);
        return @(userName.length>2 && pwd.length>2);
    }];
    
    // 处理登陆业务逻辑
   
    // 初始化方法一
    /*
    _loginCommand = [[RACCommand alloc]initWithSignalBlock:^RACSignal *(id input) {
        NSLog(@"%@",input);
        return [[RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
            // 模仿网络延迟
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                
                [subscriber sendNext:@"请求的数据"];
                // 数据传送完毕，必须调用完成，否则命令永远处于执行状态
                [subscriber sendCompleted];
            });
            return nil;
        }]delay:1]; // deleay:延迟发送信号
    }];
     */
    
    
    // 初始化方法二：第一个参数为当前commond是否可用的信号
    // 不能动态改变button的enable 如：RAC(self.button, enable) = someSignal;
    
    _loginCommand = [[RACCommand alloc]initWithEnabled:_enableLoginSignal signalBlock:^RACSignal *(id input) {
        NSLog(@"%@",input);
        return [NetWork loginWithUserName:self.account.userName password:self.account.password];
    }];
    
    // 错误信息
    [_loginCommand.errors subscribeNext:^(id x) {
        NSLog(@"error --> %@",x);
    }];
    
    
    // 监听登陆状态
    [[_loginCommand.executing skip:1]subscribeNext:^(id x) {
        if ([x isEqualToNumber:@(YES)]) {
            // 正在登陆
            NSLog(@"正在登陆...:%@",x);
        }else{
            NSLog(@"登陆成功啦:%@",x);
        }
    }];
}
@end
