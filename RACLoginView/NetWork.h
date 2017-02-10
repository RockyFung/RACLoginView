//
//  NetWork.h
//  RACLoginView
//
//  Created by rocky on 17/2/10.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>
#import "DataModel.h"

@interface NetWork : NSObject
+(void)loginWithUserName:(NSString *)userName password:(NSString *)password otherPara:(NSString *)otherPara success:(void(^)(id value))success failure:(void(^)(NSError *))failure;
@end
