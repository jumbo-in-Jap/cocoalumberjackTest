//
//  CLTViewController.m
//  cocoaLumberTest
//
//  Created by 羽田 健太郎 on 2014/03/24.
//  Copyright (c) 2014年 羽田 健太郎. All rights reserved.
//

#import "CLTViewController.h"

@interface CLTViewController ()

@end

@implementation CLTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    DDLogError(@"Paper Jam!");       // E | Paper Jam!
    DDLogWarn(@"Low toner.");        // W | Low toner.
    DDLogInfo(@"Doc printed.");      // I | Doc printed.
    DDLogDebug(@"Debugging");        // D | Debugging
    DDLogVerbose(@"Init doc_parse"); // V | Init doc_parse.
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
