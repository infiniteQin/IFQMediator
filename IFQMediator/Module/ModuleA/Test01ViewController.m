//
//  Test01ViewController.m
//  IFQMediator
//
//  Created by taizi on 16/10/10.
//  Copyright © 2016年 Qiuyin. All rights reserved.
//

#import "Test01ViewController.h"
#import "ModuleATest01ViewControllerProtocol.h"
#import "IFQProtocolManager.h"

@interface Test01ViewController ()<ModuleATest01ViewControllerProtocol>

@end

@implementation Test01ViewController

IFQ_REGISTER_PROTOCOLCLASS(ModuleATest01ViewControllerProtocol)

- (void)viewDidLoad {
    [super viewDidLoad];
    if (self.bgColor) {
        self.view.backgroundColor = self.bgColor;
    }
    if (self.showDismissBtn) {
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 100, 50)];
        btn.backgroundColor = [UIColor whiteColor];
        [btn setTitle:@"DISMISS" forState:UIControlStateNormal];
        [btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(dismiss:) forControlEvents:UIControlEventTouchUpInside];
        btn.center = self.view.center;
        [self.view addSubview:btn];
    }
    
}

- (void)dismiss:(id)sender {
    [self dismissViewControllerAnimated:YES completion:NULL];
}

@end
