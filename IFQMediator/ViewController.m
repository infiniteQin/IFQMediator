//
//  ViewController.m
//  IFQMediator
//
//  Created by taizi on 16/10/10.
//  Copyright © 2016年 Qiuyin. All rights reserved.
//

#import "ViewController.h"
#import "IFQMediator+ModuleA.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}


- (IBAction)pushToTest01VC:(id)sender {
    UIViewController *vc = [IFQMediator test01WithBgColor:[UIColor redColor]];
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)openURL:(id)sender {
    NSString *urlStr = @"schemeName://ModuleA/presetToTest01VCWithBgColor:?bgcolor=009911";
    NSURL *url = [NSURL URLWithString:urlStr];
    [[IFQMediator sharedInstance] performActionWithUrl:url callback:NULL];
}

@end
