//
//  HXDropMenu.m
//  Pods
//
//  Created by 海啸 on 2017/3/22.
//
//

#import "HXDropMenu.h"
#import "Masonry.h"

static const CGFloat HXDropMenuHeaderHeight = 400;
static const CGFloat HXDropMenuAutoHideHeight = 44;
@interface HXDropMenu() <UITableViewDelegate, UITableViewDataSource>

@property (copy, nonatomic  ) NSArray     *titles;
@property (assign, nonatomic) BOOL        isMenuShow;
@property (assign, nonatomic) NSUInteger  selectedIndex;

@property (strong, nonatomic) UIButton    *titleButton;
@property (strong, nonatomic) UIImageView *arrowImageView;

@property (strong, nonatomic) UIView      *wrapperView;
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic) UIView      *backgroundView;

@end
@implementation HXDropMenu

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray *)titles {
    self = [super initWithFrame:frame];
    if (self) {
        
        _width = 0.0;
        _animationDuration = 0.4;
        _backgroundAlpha = 0.3;
        _cellHeight = 44;
        _isMenuShow = false;
        _selectedIndex = 0;
        _titles = titles;
        
        [self addSubview:self.titleButton];
        [self addSubview:self.arrowImageView];
        
        [self.wrapperView addSubview:self.backgroundView];
        [self.wrapperView addSubview:self.tableView];
        
        //设置KVO选项
        NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
        
        //监视tableView
        [self.tableView addObserver:self forKeyPath:@"contentOffset" options:options context:nil];
    }
    return self;
}

//已经显示
- (void)didMoveToWindow {
    [super didMoveToWindow];
    
    if (self.window) {
        //添加wrapperView
        [self.window addSubview:self.wrapperView];
        
        [self.titleButton mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
        }];
        [self.arrowImageView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.mas_equalTo(self.titleButton.mas_right).offset(5);
            make.centerY.mas_equalTo(self.titleButton.mas_centerY);
        }];
        
        [self.wrapperView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.right.mas_equalTo(self.window);
            //让wrapperView在Navgation Bar下面
            make.top.mas_equalTo(self.superview.mas_bottom);
        }];
        
        //使边缘对齐wrapperView
        [self.backgroundView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.wrapperView);
        }];
        
        CGFloat tableCellsHeight = _cellHeight * _titles.count;
        [self.tableView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.wrapperView.mas_centerX);
            if (self.width > 79.9) {
                make.width.mas_equalTo(self.width);
            }else {
                make.width.mas_equalTo(self.wrapperView.mas_width);
            }
            //根据cellsHeight计算tableView的top和bottom
            make.top.equalTo(self.wrapperView.mas_top).offset(-tableCellsHeight - HXDropMenuHeaderHeight);
            make.bottom.equalTo(self.wrapperView.mas_bottom).offset(tableCellsHeight + HXDropMenuHeaderHeight);
        }];
        self.wrapperView.hidden = true;
    }else {
        [self.wrapperView removeFromSuperview];
    }
}

- (void)dealloc {
    [self.tableView removeObserver:self forKeyPath:@"contentOffset"];
}

#pragma mark: KVO
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
   //遇到情况返回
    if (!self.userInteractionEnabled || !self.isMenuShow) {
        return;
    }
    
    //
    if ([keyPath isEqualToString:@"contentOffset"]) {
        CGPoint newOffset = [[change valueForKey:@"new"] CGPointValue];
        if (newOffset.y > HXDropMenuAutoHideHeight) {
            self.isMenuShow = !self.isMenuShow;
        }
    }
}

#pragma mark: UITableView Datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titles.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return self.cellHeight;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"reuseCell" forIndexPath:indexPath];
    
    cell.textLabel.text = [self.titles objectAtIndex:indexPath.row];
    if (self.selectedIndex == indexPath.row) {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }else {
         cell.accessoryType = UITableViewCellAccessoryNone;
    }

//    cell.tintColor           = self.cellAccessoryCheckmarkColor;
    cell.tintColor = [UIColor whiteColor];
    cell.backgroundColor     = self.cellColor;
    cell.textLabel.font      = self.textFont;
    cell.textLabel.textColor = self.textColor;
    return cell;
}


#pragma mark: UITableView Delegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    self.selectedIndex = indexPath.row;
    [tableView deselectRowAtIndexPath:indexPath animated:true];
    if (self.selectedAtIndex) {
        self.selectedAtIndex((int)indexPath.row);
    }
}

#pragma mark: Handle actions
- (void)tapOnTitleButton:(UIButton *)button {
    self.isMenuShow = !self.isMenuShow;
}

//转向
- (void)orientChange:(NSNotification *)noti {
    NSLog(@"change orient");
}

#pragma mark: Method
- (void)showMenu {
    self.titleButton.enabled = NO;
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, HXDropMenuHeaderHeight)];
    headerView.backgroundColor = self.cellColor;
    self.tableView.tableHeaderView = headerView;
    [self.tableView layoutIfNeeded];
    
    //用Masonry做tableView的动画让tableView
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wrapperView.mas_top).offset(-HXDropMenuHeaderHeight);
        make.bottom.equalTo(self.wrapperView.mas_bottom).offset(HXDropMenuHeaderHeight);
    }];
    self.wrapperView.hidden = NO;
    self.backgroundView.alpha = 0.0;
    
    //旋转尖头
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
                     }];
    
    //Table View动画
    [UIView animateWithDuration:self.animationDuration * 1.5
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.tableView layoutIfNeeded];
                         self.backgroundView.alpha = self.backgroundAlpha;
                         self.titleButton.enabled = YES;
                     } completion:nil];
}

- (void)hideMenu
{
    self.titleButton.enabled = NO;
    CGFloat tableCellsHeight = _cellHeight * _titles.count;
    
    //Mas动画
    [self.tableView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.wrapperView.mas_top).offset(-tableCellsHeight - HXDropMenuHeaderHeight);
        make.bottom.equalTo(self.wrapperView.mas_bottom).offset(tableCellsHeight + HXDropMenuHeaderHeight);
    }];
    
    //旋转箭头
    [UIView animateWithDuration:self.animationDuration
                     animations:^{
                         self.arrowImageView.transform = CGAffineTransformRotate(self.arrowImageView.transform, M_PI);
                     }];
    
    //收回table
    [UIView animateWithDuration:self.animationDuration * 1.5
                          delay:0
         usingSpringWithDamping:0.7
          initialSpringVelocity:0.5
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         [self.tableView layoutIfNeeded];
                         self.backgroundView.alpha = 0.0;
                     } completion:^(BOOL finished) {
                         self.wrapperView.hidden = YES;
                         [self.tableView reloadData];
                         self.titleButton.enabled = YES;
                     }];
}

#pragma mark: Getter and setter
- (UIColor *)cellColor
{
    //懒加载 如果没有
    if (!_cellColor) {
        _cellColor = [UIColor colorWithRed:229/255.5 green:57/255.5 blue:53/255.5 alpha:1.000];
    }
    
    return _cellColor;
}

//用synthesize实现cellSepratorColor
@synthesize cellSeparatorColor = _cellSeparatorColor;
- (UIColor *)cellSeparatorColor {

    if (!_cellSeparatorColor){
        _cellSeparatorColor = [UIColor whiteColor];
    }
    
    return _cellSeparatorColor;
}

- (void)setCellSeparatorColor:(UIColor *)cellSeparatorColor {
    if (_tableView) {
        _tableView.separatorColor = cellSeparatorColor;
    }
    _cellSeparatorColor = cellSeparatorColor;
}

@synthesize textColor = _textColor;
- (UIColor *)textColor {
    if (!_textColor) {
        _textColor = [UIColor whiteColor];
    }
    
    return _textColor;
}

- (void)setTextColor:(UIColor *)textColor
{
    if (_titleButton) {
        [_titleButton setTitleColor:textColor forState:UIControlStateNormal];
    }
    _textColor = textColor;
}

@synthesize textFont = _textFont;
- (UIFont *)textFont
{
    if(!_textFont) {
        _textFont = [UIFont systemFontOfSize:17];
    }
    
    return _textFont;
}

- (void)setTextFont:(UIFont *)textFont
{
    if (_titleButton) {
        [_titleButton.titleLabel setFont:textFont];;
    }
    _textFont = textFont;
}

#pragma mark: 设置UI

- (UIButton *)titleButton {
    if (!_titleButton) {
        _titleButton = [[UIButton alloc] init];
        [_titleButton setTitle:[self.titles objectAtIndex:0] forState:UIControlStateNormal];
        [_titleButton addTarget:self action:@selector(tapOnTitleButton:) forControlEvents:UIControlEventTouchUpInside];
        [_titleButton.titleLabel setFont:self.textFont];
        [_titleButton setTitleColor:self.textColor forState:UIControlStateNormal];
    }
    
    return _titleButton;
}

- (UIImageView *)arrowImageView {
    //加载箭头图片
    if (!_arrowImageView) {
        NSString * bundlePath = [[NSBundle mainBundle] pathForResource:@"HXDropMenu" ofType:@"bundle"];
        NSString *imagePath = [bundlePath stringByAppendingPathComponent:@"arrow.png"];
        UIImage *image = [UIImage imageWithContentsOfFile:imagePath];
        _arrowImageView = [[UIImageView alloc] initWithImage:image];
    }
    return _arrowImageView;
}

- (UITableView *)tableView
{
    if (!_tableView)
    {
        _tableView = [[UITableView alloc] init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = self.cellSeparatorColor;
        [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"reuseCell"];
    }
    return _tableView;
}

- (UIView *)wrapperView {
    if (!_wrapperView){
        _wrapperView = [[UIView alloc] init];
        _wrapperView.clipsToBounds = true;
    }
    
    return _wrapperView;
}

- (UIView *)backgroundView
{
    if (!_backgroundView) {
        _backgroundView = [[UIView alloc] init];
        _backgroundView.backgroundColor = [UIColor blackColor];
        _backgroundView.alpha = self.backgroundAlpha;
    }
    
    return _backgroundView;
}

- (void)setIsMenuShow:(BOOL)isMenuShow {
    if (_isMenuShow != isMenuShow) {
        _isMenuShow = isMenuShow;
        if (isMenuShow) {
            [self showMenu];
        } else {
            [self hideMenu];
        }
    }
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
    if (_selectedIndex != selectedIndex) {
        _selectedIndex = selectedIndex;
        [_titleButton setTitle:[_titles objectAtIndex:selectedIndex] forState:UIControlStateNormal];
    }
    
    self.isMenuShow = false;
}

- (void)setWidth:(CGFloat)width {
    if (width < 80.0) {
        NSLog(@"width must bigger than 80");
        return;
    }
    
    _width = width;
}



@end
