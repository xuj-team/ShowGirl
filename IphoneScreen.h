//
//  IphoneScreen.h
//  MeiJiaLove
//
//  Created by Wu.weibin on 13-5-25.
//  Copyright (c) 2013年 Wu.weibin. All rights reserved.
//

#import <Foundation/Foundation.h>
#define IS_IPHONE5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 960), [[UIScreen mainScreen] currentMode].size) : NO)
#define ScreenHeight (IS_IPHONE5 ? 548.0 : 460.0)

@interface IphoneScreen : NSObject
 
@end
