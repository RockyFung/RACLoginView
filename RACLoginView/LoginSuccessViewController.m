//
//  LoginSuccessViewController.m
//  RACLoginView
//
//  Created by rocky on 17/2/10.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import "LoginSuccessViewController.h"

@interface LoginSuccessViewController ()
@property (nonatomic, strong) UILabel *welcomeLabel;
@end

@implementation LoginSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    // Do any additional setup after loading the view from its nib.
    self.welcomeLabel = [[UILabel alloc]initWithFrame:CGRectMake(30, 100, 200, 30)];
    self.welcomeLabel.textColor = [UIColor redColor];
    self.welcomeLabel.textAlignment = NSTextAlignmentCenter;
    self.welcomeLabel.text = [NSString stringWithFormat:@"welcome %@",self.model.name];
    [self.view addSubview:self.welcomeLabel];
    
    
    UIButton *backBtn = [[UIButton alloc]initWithFrame:CGRectMake(100, 150, 100, 30)];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(backAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backBtn];
}

- (void)backAction:(id)sender {
    if (self.delegateSubject) {
        [self.delegateSubject sendNext:@"第二页数据"];
    }
    [self dismissViewControllerAnimated:YES completion:nil];
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
