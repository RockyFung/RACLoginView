//
//  NetWork.m
//  RACLoginView
//
//  Created by rocky on 17/2/10.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import "NetWork.h"


@implementation NetWork
+(void)loginWithUserName:(NSString *)userName password:(NSString *)password otherPara:(NSString *)otherPara success:(void(^)(id value))success failure:(void(^)(NSError *))failure{
    // 网络请求
    NSLog(@"参数：userName=%@  password=%@ otherPara=%@",userName, password,otherPara);
    NSDictionary *value = @{@"name":@"rocky",@"age":@"33"};
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(2 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
       success(value);
    });
    
}
@end
