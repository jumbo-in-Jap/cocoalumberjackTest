cocoalumberjackTest
===================

## setting

platform :ios, '7.0'
pod 'BlocksKit'
pod 'SVProgressHUD'
pod 'CocoaLumberjack'

$ pod install

### xxx-Prefix.pch

        #ifdef DEBUG
          static const int ddLogLevel = LOG_LEVEL_VERBOSE;
        #else
          static const int ddLogLevel = LOG_LEVEL_OFF;
        #endif

and add new formatfile , like CLTCustomFormatter in this sample Source .

and write in 

### AppDelegate

      - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
      {
          DDTTYLogger *ttyLogger = [DDTTYLogger sharedInstance];
          ttyLogger.logFormatter = [[CLTCustomFormatter alloc] init];
          [DDLog addLogger:ttyLogger];
          
          // setting log save dir.
          NSString *logPath = [NSHomeDirectory() stringByAppendingPathComponent:@"Library/Logs/"];
          DDLogFileManagerDefault *logFileManager = [[DDLogFileManagerDefault alloc] initWithLogsDirectory:logPath];
          self.fileLogger = [[DDFileLogger alloc] initWithLogFileManager:logFileManager];
          self.fileLogger.logFormatter = [[CLTCustomFormatter alloc] init];
          self.fileLogger.maximumFileSize = 10 * 1024 * 1024;
          self.fileLogger.logFileManager.maximumNumberOfLogFiles = 5;
          [DDLog addLogger:self.fileLogger];
          
          DDLogInfo(@"%@", self.fileLogger.logFileManager.logsDirectory);
      
          return YES;
      }
      
and use, import your new formatter and write above.

      DDLogError(@"Paper Jam!");       
      DDLogWarn(@"Low toner.");        
      DDLogInfo(@"Doc printed.");      
      DDLogDebug(@"Debugging");       
      DDLogVerbose(@"Init doc_parse"); .
