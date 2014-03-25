//
//  CLTAppDelegate.h
//  cocoaLumberTest
//
//  Created by 羽田 健太郎 on 2014/03/24.
//  Copyright (c) 2014年 羽田 健太郎. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CocoaLumberjack/DDLog.h>
#import <CocoaLumberjack/DDLog+LOGV.h>
#import <CocoaLumberjack/DDTTYLogger.h>
#import <CocoaLumberjack/DDFileLogger.h>
#import "CLTCustomFormatter.h"

@interface CLTAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic)DDFileLogger* fileLogger;
@end
