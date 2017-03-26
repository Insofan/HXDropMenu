//
//  HXViewController.m
//  HXDropMenu
//
//  Created by Insofan on 03/20/2017.
//  Copyright (c) 2017 Insofan. All rights reserved.
//

#import "HXViewController.h"
#import <Masonry/Masonry.h>
#import <HXDropMenu/HXDropMenu.h>
//一个我自己很简单的工具库
#import <HXTool/HXTool.h>

@interface HXViewController ()
@property (strong, nonatomic) UILabel *label;
@end

@implementation HXViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor greenColor];
    
    //Color tool framework
    //用了自己的一个颜色工具
    [self.navigationController.navigationBar setBarTintColor:[UIColor colorWithRGBString:@"E53935"]];
    
    //Table data
    //下拉列表的数据
    NSArray *titles = @[@"First", @"Second", @"Third", @"Fourth", @"Fifth",@"Sixed", @"Seventh", @"Eighth"];
    
    //Init HXDropMenu
    //初始化HXDropMenu
    HXDropMenu *menuView = [[HXDropMenu alloc] initWithFrame:CGRectMake(0, 0,100, 44) titles:titles];
    
    //Set width
    menuView.width = 400;
    
    self.navigationItem.titleView = menuView;
    
    //UILabel
    self.label = ({
        _label = [UILabel new];
        [self.view addSubview:_label];
        _label.backgroundColor = [UIColor redColor];
        //Recommand in init load default index, i'm use a cheat code
        //在init中可以加载default index这里偷懒写成了first
        _label.text = @"First";
        _label;
    });
    
    //Callback block receive value
    //回调闭包接受参数
        menuView.selectedAtIndex = ^(int index)
    {
        NSLog(@"选择 %@", titles[index]);
        self.label.text = titles[index];
    };

    //label layout
    [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.centerY.mas_equalTo(self.view);
        make.width.height.mas_equalTo(100);
    }];
}

@end
