//
//  HXViewController.m
//  HXDropMenu
//
//  Created by Insofan on 03/20/2017.
//  Copyright (c) 2017 Insofan. All rights reserved.
//

#import "HXViewController.h"
#import <HXDropMenu/HXDropMenu.h>
//一个我自己很简单的工具库
#import <HXTool/HXTool.h>

@interface HXViewController ()

@end

@implementation HXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    // Do any additional setup after loading the view, typically from a nib.
    //Color tool framework
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRGBString:@"E53935"]];
    NSArray *titles = @[@"First", @"Second", @"Third", @"Fourth", @"Fifth",@"Sixed", @"Seventh", @"Eighth"];
    HXDropMenu *menuView = [[HXDropMenu alloc] initWithFrame:CGRectMake(0, 0,100, 44) titles:titles];
    
    menuView.selectedAtIndex = ^(int index)
    {
        NSLog(@"选择 %@", titles[index]);
    };
    menuView.width = 400;
    self.navigationItem.titleView = menuView;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
