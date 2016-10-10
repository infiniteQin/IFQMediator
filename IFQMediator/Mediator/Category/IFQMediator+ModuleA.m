//
//  IFQMediator+ModuleA.m
//  IFQMediator
//
//  Created by taizi on 16/10/10.
//  Copyright © 2016年 Qiuyin. All rights reserved.
//

#import "IFQMediator+ModuleA.h"
#import "ModuleATest01ViewControllerProtocol.h"
#import "IFQProtocolManager.h"

#define PARAM_NULL ([NSNull null])

@implementation IFQMediator (ModuleA)

+ (UIViewController<ModuleATest01ViewControllerProtocol> *)test01WithBgColor:(UIColor*)bgColor {
    
//    NSArray *params = nil;
//    if (bgColor) {
//        params = @[bgColor];
//    }else {
//        params = @[PARAM_NULL];
//    }
//    id<ModuleATest01ViewControllerProtocol> t1VC = [self performModuleProtocol:NSStringFromProtocol(@protocol(ModuleATest01ViewControllerProtocol)) action:NSStringFromSelector(@selector(setBgColor:)) params:params callback:NULL];
    
    id<ModuleATest01ViewControllerProtocol> t1VC = [[IFQProtocolManager manager] creatInstanceFromProtocol:@protocol(ModuleATest01ViewControllerProtocol)];
    if ([t1VC respondsToSelector:@selector(setBgColor:)]) {
        [t1VC setBgColor:bgColor];
    }
    if ([t1VC isKindOfClass:[UIViewController class]]) {
        return (UIViewController<ModuleATest01ViewControllerProtocol>*)t1VC;
    }
    return nil;
}

- (void)presetToTest01VCWithBgColor:(NSString*)hexColor {
    UIColor *bgColor = [UIColor blueColor];
    id<ModuleATest01ViewControllerProtocol> t1VC = [[IFQProtocolManager manager] creatInstanceFromProtocol:@protocol(ModuleATest01ViewControllerProtocol)];
    if ([t1VC respondsToSelector:@selector(setBgColor:)]) {
        [t1VC setBgColor:bgColor];
    }
    if ([t1VC respondsToSelector:@selector(setShowDismissBtn:)]) {
        [t1VC setShowDismissBtn:YES];
    }
    if ([t1VC isKindOfClass:[UIViewController class]]) {
        [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:(UIViewController*)t1VC animated:YES completion:NULL];
    }
}

@end
