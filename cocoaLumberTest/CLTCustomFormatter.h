//
//  CLTCustomFormatter.h
//  cocoaLumberTest
//
//  Created by 羽田 健太郎 on 2014/03/25.
//  Copyright (c) 2014年 羽田 健太郎. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <libkern/OSAtomic.h>
#import "DDLog.h"

@interface CLTCustomFormatter : NSObject <DDLogFormatter>
{
    int atomicLoggerCount;
    NSDateFormatter *threadUnsafeDateFormatter;
}

@end
