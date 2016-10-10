//
//  IFQProtocolManager.m
//  IFQMediator
//
//  Created by taizi on 16/10/10.
//  Copyright © 2016年 Qiuyin. All rights reserved.
//

#import "IFQProtocolManager.h"

@interface IFQProtocolManager ()
@property (nonatomic, strong) NSMutableDictionary<NSString*,NSString*> *allProtocolCls;
@property (nonatomic, strong) NSRecursiveLock *lock;
@end

@implementation IFQProtocolManager

+ (instancetype)manager {
    static IFQProtocolManager *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}

- (void)registerClass:(Class)cls protocol:(Protocol*)protocol {
    
    NSParameterAssert(cls != nil);
    NSParameterAssert(protocol != nil);
    
    // 判断注册的类是否实现接口
    if (![cls conformsToProtocol:protocol]) {
        NSString *err = [NSString stringWithFormat:@"%@ class does not comply with %@ protocol", NSStringFromClass(cls), NSStringFromProtocol(protocol)];
        assert(err);
    }
    
    // 判断接口是否已经被实现
    if ([self.allProtocolCls.allKeys containsObject:NSStringFromProtocol(protocol)]) {
        NSString *err = [NSString stringWithFormat:@"%@ protocol has been registed", NSStringFromProtocol(protocol)];
        assert(err);
    }
    

    [self.lock lock];
    [self.allProtocolCls setObject:NSStringFromClass(cls) forKey:NSStringFromProtocol(protocol)];
    [self.lock unlock];
    
}

- (Class)targetClsFromProtocol:(Protocol*)protocol {
    
    id targetCls = nil;
    if (protocol) {
        NSString *targetClsName = [self.allProtocolCls objectForKey:NSStringFromProtocol(protocol)];
        targetCls = NSClassFromString(targetClsName);
    }
    return targetCls;
}

- (id)creatInstanceFromProtocol:(Protocol*)protocol {
    Class targetCls = [self targetClsFromProtocol:protocol];
    id clsInstance = nil;
    if (targetCls) {
        clsInstance = [[targetCls alloc] init];
    }
    return clsInstance;
}

#pragma mark getter
- (NSMutableDictionary<NSString *,NSString *> *)allProtocolCls {
    if (!_allProtocolCls) {
        _allProtocolCls = [NSMutableDictionary dictionary];
    }
    return _allProtocolCls;
}

- (NSRecursiveLock *)lock
{
    if (!_lock) {
        _lock = [[NSRecursiveLock alloc] init];
    }
    return _lock;
}

@end
