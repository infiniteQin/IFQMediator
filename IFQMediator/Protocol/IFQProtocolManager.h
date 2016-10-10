//
//  IFQProtocolManager.h
//  IFQMediator
//
//  Created by taizi on 16/10/10.
//  Copyright © 2016年 Qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

#define IFQ_REGISTER_PROTOCOLCLASS(ptl) \
+ (void)load { [[IFQProtocolManager manager] registerClass:[self class] protocol:@protocol(ptl)]; }

@interface IFQProtocolManager : NSObject

+ (instancetype)manager;

- (void)registerClass:(Class)cls protocol:(Protocol*)protocol;

- (id)creatInstanceFromProtocol:(Protocol*)protocol;

@end
