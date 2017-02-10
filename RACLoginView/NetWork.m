//
//  NetWork.m
//  RACLoginView
//
//  Created by rocky on 17/2/10.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import "NetWork.h"

@implementation NetWork
+(RACSignal *)loginWithUserName:(NSString *)name password:(NSString *)password{
    return [RACSignal createSignal:^RACDisposable *(id<RACSubscriber> subscriber) {
        // 网络请求
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [subscriber sendNext:[NSString stringWithFormat:@"账号：%@, 密码：%@",name,password]];
            [subscriber sendCompleted];
        });
        return nil;
    }];
}
@end
