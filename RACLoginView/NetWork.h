//
//  NetWork.h
//  RACLoginView
//
//  Created by rocky on 17/2/10.
//  Copyright © 2017年 RockyFung. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ReactiveCocoa/ReactiveCocoa.h>

@interface NetWork : NSObject
+ (RACSignal *)loginWithUserName:(NSString *)name password:(NSString *)password;
@end
