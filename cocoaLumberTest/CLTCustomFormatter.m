//
//  CLTCustomFormatter.m
//  cocoaLumberTest
//
//  Created by 羽田 健太郎 on 2014/03/25.
//  Copyright (c) 2014年 羽田 健太郎. All rights reserved.
//


#import "CLTCustomFormatter.h"

@implementation CLTCustomFormatter

- (NSString *)stringFromDate:(NSDate *)date
{
    int32_t loggerCount = OSAtomicAdd32(0, &atomicLoggerCount);
    NSString* dateFormatString = [NSString stringWithFormat:@"yyyy/MM/dd HH:mm:ss"];
    
    if (loggerCount <= 1)
    {
        // Single-threaded mode.
        
        if (threadUnsafeDateFormatter == nil)
        {
            threadUnsafeDateFormatter = [[NSDateFormatter alloc] init];
            [threadUnsafeDateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
            [threadUnsafeDateFormatter setDateFormat:dateFormatString];
        }
        
        return [threadUnsafeDateFormatter stringFromDate:date];
    }
    else
    {
        // Multi-threaded mode.
        // NSDateFormatter is NOT thread-safe.
        
        NSString *key = @"MyCustomFormatter_NSDateFormatter";
        
        NSMutableDictionary *threadDictionary = [[NSThread currentThread] threadDictionary];
        NSDateFormatter *dateFormatter = [threadDictionary objectForKey:key];
        
        if (dateFormatter == nil)
        {
            dateFormatter = [[NSDateFormatter alloc] init];
            [dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
            [dateFormatter setDateFormat:dateFormatString];
            
            [threadDictionary setObject:dateFormatter forKey:key];
        }
        
        return [dateFormatter stringFromDate:date];
    }
}

- (NSString *)formatLogMessage:(DDLogMessage *)logMessage
{
    NSString *logLevel;
    switch (logMessage->logFlag)
    {
        case LOG_FLAG_ERROR : logLevel = @"E"; break;
        case LOG_FLAG_WARN  : logLevel = @"W"; break;
        case LOG_FLAG_INFO  : logLevel = @"I"; break;
        case LOG_FLAG_DEBUG : logLevel = @"D"; break;
        default             : logLevel = @"V"; break;
    }
    NSString *dateAndTime = [self stringFromDate:(logMessage->timestamp)];
    NSString *logMsg = logMessage->logMsg;
    NSString *fileName = logMessage.fileName;
    NSString *methodName = logMessage.methodName;
    int lineNumber = logMessage->lineNumber;
    NSString *threadID = logMessage.threadID;
    
    return [NSString stringWithFormat:@"%@ (%@) %@ [%@(%d) %@] %@",
            dateAndTime, threadID, logLevel, fileName, lineNumber, methodName, logMsg];
}

- (void)didAddToLogger:(id <DDLogger>)logger
{
    OSAtomicIncrement32(&atomicLoggerCount);
}
- (void)willRemoveFromLogger:(id <DDLogger>)logger
{
    OSAtomicDecrement32(&atomicLoggerCount);
}

@end
