//
//  MainWindowAppDelegate.h
//  ShowGirl美妆
//
//  Created by 徐 军 on 13-8-10.
//  Copyright (c) 2013年 徐 军. All rights reserved.
//

#import <UIKit/UIKit.h>

//test1
//2
//3
//4


@class MainWindowViewController;

@interface MainWindowAppDelegate : UIResponder <UIApplicationDelegate, WeiboSDKDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) MainWindowViewController *viewController;

@end
