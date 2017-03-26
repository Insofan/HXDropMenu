# HXDropMenu

[![CI Status](http://img.shields.io/travis/Insofan/HXDropMenu.svg?style=flat)](https://travis-ci.org/Insofan/HXDropMenu)
[![Version](https://img.shields.io/cocoapods/v/HXDropMenu.svg?style=flat)](http://cocoapods.org/pods/HXDropMenu)
[![License](https://img.shields.io/cocoapods/l/HXDropMenu.svg?style=flat)](http://cocoapods.org/pods/HXDropMenu)
[![Platform](https://img.shields.io/cocoapods/p/HXDropMenu.svg?style=flat)](http://cocoapods.org/pods/HXDropMenu)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

HXDropMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "HXDropMenu"
```

## Preview

![PRVGn.gif](http://storage1.imgchr.com/PRVGn.gif)

## Usage

1. Set table titles 

```
//Table data
//下拉列表的数据
NSArray *titles = @[@"First", @"Second", @"Third", @"Fourth", @"Fifth",@"Sixed", @"Seventh", @"Eighth"];
```

2.Init HXDropMenu

```
//Init HXDropMenu
//初始化HXDropMenu
HXDropMenu *menuView = [[HXDropMenu alloc] initWithFrame:CGRectMake(0, 0,100, 44) titles:titles];
//Set width
menuView.width = 400;    
self.navigationItem.titleView = menuView;
```

## Author

Insofan, insofan3156@gmail.com

## License

HXDropMenu is available under the MIT license. See the LICENSE file for more info.
