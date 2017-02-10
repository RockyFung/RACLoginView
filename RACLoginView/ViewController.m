//
//  ViewController.m
//  RACLoginView
//
//  Created by rocky on 17/2/10.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import "ViewController.h"
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "LoginViewModel.h"
#import "AccountModel.h"
#import "DataModel.h"
#import "LoginSuccessViewController.h"

@interface ViewController ()
@property (nonatomic, strong) LoginViewModel *loginViewModel;
@property (nonatomic, strong) UITextField *userName;
@property (nonatomic, strong) UITextField *password;
@property (nonatomic, strong) UIButton *loginBtn;
@property (nonatomic, strong) UIActivityIndicatorView *indicator;
@end

@implementation ViewController

- (LoginViewModel *)loginViewModel{
    if (_loginViewModel == nil) {
        _loginViewModel = [[LoginViewModel alloc]init];
    }
    return _loginViewModel;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self creatUI];
    
    [self bindModel];
}

- (void)creatUI{
    UILabel *label1 = [[UILabel alloc]initWithFrame:CGRectMake(10, 100, 50, 30)];
    label1.text = @"账号";
    [self.view addSubview:label1];
    
    self.userName = [[UITextField alloc]initWithFrame:CGRectMake(100, 100, 200, 30)];
    self.userName.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.userName];
    
    
    UILabel *label2 = [[UILabel alloc]initWithFrame:CGRectMake(10, 150, 50, 30)];
    label2.text = @"密码";
    [self.view addSubview:label2];
    
    self.password = [[UITextField alloc]initWithFrame:CGRectMake(100, 150, 200, 30)];
    self.password.borderStyle = UITextBorderStyleRoundedRect;
    [self.view addSubview:self.password];
    
    self.loginBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.loginBtn.frame = CGRectMake(100, 200, 200, 30);
    [self.loginBtn setTitle:@"loging" forState:UIControlStateNormal];
    self.loginBtn.backgroundColor = [UIColor grayColor];
    [self.view addSubview:self.loginBtn];
    
    UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc]initWithFrame:CGRectMake(0, 0, 50, 50)];
    indicator.center = CGPointMake([UIScreen mainScreen].bounds.size.width/2, 300);
    indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyleWhiteLarge;
    indicator.backgroundColor = [UIColor grayColor];
    indicator.layer.cornerRadius = 6;
    indicator.alpha = 0.5;
    [self.view addSubview:indicator];
    self.indicator = indicator;
}


// 视图模型绑定
- (void)bindModel{
    // 给模型的属性绑定信号
    // 只要账号文本框一改变，就会给account赋值
    RAC(self.loginViewModel.account, userName) = self.userName.rac_textSignal;
    RAC(self.loginViewModel.account, password) = self.password.rac_textSignal;
    
    // 绑定登陆按钮
//    RAC(self.loginBtn,enabled) = self.loginViewModel.enableLoginSignal;
    
    // 绑定按钮的背景颜色
    RAC(self.loginBtn,backgroundColor) = [self.loginViewModel.enableLoginSignal map:^id(id value) {
        return [value boolValue] ? [UIColor greenColor] : [UIColor redColor];
    }];
    
    
    
    // 监听登陆按钮点击
//    self.loginBtn.rac_command = self.loginViewModel.loginCommand;
    
    // 用上面方法绑定后就不需要加点击方法
    [[self.loginBtn rac_signalForControlEvents:UIControlEventTouchUpInside]subscribeNext:^(id x) {
       // 执行登陆事件,可传递参数
        [[self.loginViewModel.loginCommand execute:@"其他参数"]subscribeNext:^(id x) {
            DataModel *model = (DataModel *)x;
            NSLog(@"获取到的数据: name=%@ age=%@",model.name, model.age);
            LoginSuccessViewController *vc = [[LoginSuccessViewController alloc]init];
            vc.model = model;
            // 代理信号
            vc.delegateSubject = [RACSubject subject];
            [vc.delegateSubject subscribeNext:^(id x) {
               // 方法实现
                NSLog(@"接收到数据：%@",x);
            }];
            [self presentViewController:vc animated:YES completion:nil];
        }error:^(NSError *error) {
            
        }];
    }];

    
    // 获取最新网络请求的数据
//    [self.loginViewModel.loginCommand.executionSignals.switchToLatest subscribeNext:^(id x) {
//        NSLog(@"获取到的数据: %@",x);
//    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



















@end
