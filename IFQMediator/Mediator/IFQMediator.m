//
//  IFQMediator.m
//  IFQMediator
//
//  Created by taizi on 16/10/10.
//  Copyright © 2016年 Qiuyin. All rights reserved.
//

#import "IFQMediator.h"
#import "IFQProtocolManager.h"
#import "NSObject+IFQPerformSelector.h"


#warning 修改schemeName为你自己app的scheme
static NSString * const APP_SCHEME = @"schemeName";

@implementation IFQMediator

+ (instancetype)sharedInstance {
    static IFQMediator *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });
    return instance;
}


/*
 scheme://[MediatorCategory]/[action]?[params]
 
 url sample:
 ifa://ModuleA/actionB:?p1=aa&p2&p3=null
 */

+ (id)performActionWithUrl:(NSURL *)url callback:(void(^)(BOOL isExcSucc,id returnVal))callback
{

    if (![url.scheme isEqualToString:APP_SCHEME]) {
        // 这里就是针对远程app调用404的简单处理了，根据不同app的产品经理要求不同，你们可以在这里自己做需要的逻辑
        if (callback) {
            callback(NO,nil);
        }
        return nil;
    }
    
    NSMutableArray *params = [[NSMutableArray alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) {
            [params addObject:[NSNull null]];
        }else {
            [params addObject:[elts lastObject]];
        }
    }
    
    // 这里这么写主要是出于安全考虑，防止黑客通过远程方式调用本地模块。这里的做法足以应对绝大多数场景，如果要求更加严苛，也可以做更加复杂的安全逻辑。
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
    if ([actionName hasPrefix:@"native"]) {
        if (callback) {
            callback(NO,nil);
        }
        return nil;
    }
    
    // 这个demo针对URL的路由处理非常简单，就只是取对应的target名字和method名字，但这已经足以应对绝大部份需求。如果需要拓展，可以在这个方法调用之前加入完整的路由逻辑
    id rs = [self performSelector:NSSelectorFromString(actionName) withObjects:params failure:^{
        // 处理URL action出错
        NSLog(@"IFQMediator 所有Category中不存在 %@ 方法",actionName);
    }];
    return rs;
}

+ (id)performModuleProtocol:(NSString *)protocolName action:(NSString *)actionName params:(NSArray *)params callback:(void(^)(BOOL isExcSucc,id returnVal))callback
{
    id protocol = NSProtocolFromString(protocolName);
    id implClassInstance = [[IFQProtocolManager manager] creatInstanceFromProtocol:protocol];
    SEL action = NSSelectorFromString(actionName);
    
    if (implClassInstance == nil) {
        // 这里是处理响应出错的请求
        if (callback) {
            callback(NO,nil);
        }
        return nil;
    }
    
    if ([implClassInstance respondsToSelector:action]) {
        id returnVal = [implClassInstance performSelector:action withObjects:params];
        if (callback) {
            callback(YES,returnVal);
        }
    } else {
        // 这里是处理无响应请求的地方，如果无响应，则尝试调用对应target的notFound方法统一处理
        SEL action = NSSelectorFromString(@"notFound:");
        if ([implClassInstance respondsToSelector:action]) {
            [implClassInstance performSelector:action withObjects:params];
        } else {
            // 这里也是处理无响应请求的地方，在notFound都没有的时候，这个demo是直接return了。实际开发过程中，可以用前面提到的固定的target顶上的。
            
        }
        if (callback) {
            callback(NO,nil);
        }
    }
    return implClassInstance;
}


@end
