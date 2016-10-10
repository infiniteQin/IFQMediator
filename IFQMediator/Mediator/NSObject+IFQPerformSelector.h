//
//  NSObject+IFQPerformSelector.h
//  IFQMediator
//
//  Created by taizi on 16/10/10.
//  Copyright © 2016年 Qiuyin. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (IFQPerformSelector)

- (id)performSelector:(SEL)selector withObjects:(NSArray *)objects;

@end
