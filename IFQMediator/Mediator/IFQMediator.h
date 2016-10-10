//
//  IFQMediator.h
//  IFQMediator
//
//  Created by taizi on 16/10/10.
//  Copyright © 2016年 Qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IFQMediator : NSObject

+ (instancetype)sharedInstance;

- (id)performActionWithUrl:(NSURL *)url callback:(void(^)(BOOL isExcSucc,id returnVal))callback;

+ (id)performModuleProtocol:(NSString *)protocolName action:(NSString *)actionName params:(NSArray *)params callback:(void(^)(BOOL isExcSucc,id returnVal))callback;

@end
