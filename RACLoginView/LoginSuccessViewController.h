//
//  LoginSuccessViewController.h
//  RACLoginView
//
//  Created by rocky on 17/2/10.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataModel.h"
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface LoginSuccessViewController : UIViewController
@property (nonatomic, strong) DataModel *model;
@property (nonatomic, strong) RACSubject *delegateSubject; // 代理
@end
