//
//  UIWebView+JavaScriptAlert.h
//  Hybrid Framework for iPhone
//
//  Created by Nep Tong on 4/15/13.
//  Copyright (c) 2013 PwC. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WebFrame;

@interface UIWebView (JavaScriptAlert)
- (void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame;
- (BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WebFrame *)frame;
@end
