//
//  UIWebView+JavaScriptAlert.m
//  Hybrid Framework for iPhone
//
//  Created by Nep Tong on 4/15/13.
//  Copyright (c) 2013 PwC. All rights reserved.
//

#import "UIWebView+JavaScriptAlert.h"

@implementation UIWebView (JavaScriptAlert)

static BOOL _waitingForUserChoise;
static BOOL _diagStat;

- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame
{
    UIAlertView* customAlert = [[UIAlertView alloc] initWithTitle:@"" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [customAlert show];
    
}

- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame
{
    UIAlertView *confirmDiag = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
    [confirmDiag show];
    
    _waitingForUserChoise = YES;
    do
    {
        [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:0.01f]];
    }
    while (_waitingForUserChoise);
    
    return _diagStat;
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0)
    {
        _diagStat = YES;
        
    }
    else if (buttonIndex == 1)
    {
        _diagStat = NO;        
    }
    _waitingForUserChoise = NO;
}

@end
