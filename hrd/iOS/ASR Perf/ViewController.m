//
//  ViewController.m
//  ePay
//
//  Created by Nep Tong on 4/10/13.
//  Copyright (c) 2013 Nep Tong. All rights reserved.
//

#import "ViewController.h"
#import "UIViewController_PwCSSOAwakeViewController.h"
#import "SSOSharedInfo.h"
#import "UIWebView+JavaScriptAlert.h"
#import "Reachability.h"
#import "Utility.h"
#import "iPhoneGuideView.h"
#import "iPadGuideView.h"

@interface ViewController ()
{
    UIActivityIndicatorView *_actIndicator;
    Reachability *_hostReach;
    UIView<IGuideView> *_guideView;
}

@end

@implementation ViewController

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        // iPad
        _guideView = [[iPadGuideView alloc] init];
    }
    else
    {
        // iPhone
        _guideView = [[iPhoneGuideView alloc] init];
    }
    [self.view addSubview:_guideView];
}

- (void)loadAfterAuthenticated
{
    // Add web status observer
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(connectionStatusChanged:) name:kReachabilityChangedNotification object:nil];
    _hostReach = [Reachability reachabilityWithHostName:@"mobileapps.pwchk.com"];
    [_hostReach startNotifier];
    
    NSString *urlString = [Utility getFullUrlWithApplicationPath:@"hrd"];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:urlString]];
    [request setValue:[SSOSharedInfo sharedInstance].userInfo.token forHTTPHeaderField:@"AUTHORIZATION"];
    [self.webView loadRequest:request];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotate
{
    if (_guideView != nil && _guideView.isShowing)
    {
        return NO;
    }
    
    return [super shouldAutorotate];
}

#pragma mark - Webview Delegate

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [self showWaiting];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self hideWaiting];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [self hideWaiting];
}

#pragma mark - Indicator
-(void)showWaiting {
    if (!_actIndicator)
    {
        _actIndicator = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle: UIActivityIndicatorViewStyleGray];
        _actIndicator.center = self.webView.center;
        _actIndicator.hidesWhenStopped = YES;
        [self.webView addSubview:_actIndicator];
    }    
    [_actIndicator startAnimating];
}

-(void)hideWaiting
{
    [_actIndicator stopAnimating];
}

#pragma mark - Connection status observer
- (void) connectionStatusChanged:(NSNotification *)notification
{
    Reachability *currentAbility = [notification object];
    if (currentAbility.currentReachabilityStatus == NotReachable)
    {
        NSLog(@"Disconnected");
        [self.webView stopLoading];
        NSURL *url = [NSURL fileURLWithPath:[[NSBundle mainBundle] pathForResource:@"Disconnection" ofType:@"html"]];
        [self.webView loadRequest:[NSURLRequest requestWithURL:url]];
    }
}
@end
