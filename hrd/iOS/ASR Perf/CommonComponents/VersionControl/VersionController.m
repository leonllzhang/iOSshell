//
//  VersionController.m
//  Hybrid Framework for iPhone
//
//  Created by Nep Tong on 2/20/14.
//  Copyright (c) 2014 PwC. All rights reserved.
//

#import "VersionController.h"
#import "WCFJSONRequest.h"
#import "VersionResponse.h"
#import "MandatoryUpdateAlert.h"
#import "OptionalUpdateAlert.h"

#define VersionControlUrl @"%@VersionControl/api/Versions/?platform=iOS&appCode=HRDashboardMobile&currentVersion=%@"

@implementation VersionController

+ (void)checkVersion
{
    dispatch_async(dispatch_queue_create("CheckVersion", NULL), ^{
        VersionResponse *response = [self checkVersionWithServer];
        if (response != nil)
        {
            if (response.MandatoryFlag)
            {
                // Mandatory update
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[MandatoryUpdateAlert alloc] initWithMessage:response.Message] show];
                });
            }
            else if (response.OptionFlag)
            {
                // Optional update
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[[OptionalUpdateAlert alloc] initWithMessage:response.Message] show];
                });
            }
            else
            {
                // Newest, do nothing
            }
        }
    });
}

+ (VersionResponse *)checkVersionWithServer
{
    VersionResponse *response = nil;
    NSString *buildNo = [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey];
    WCFJSONRequest *request = [[WCFJSONRequest alloc] initWithMethod:HttpMethodGET];
//    NSString *domainString = @"https://mobileappsuat.pwchk.com/";
    NSString *domainString = [[NSBundle mainBundle].infoDictionary objectForKey:@"DomainString"];
    request.serviceUrl = [NSString stringWithFormat:VersionControlUrl, domainString, buildNo];
    WebAccessResult accessResult = [request start];
    if (accessResult == WebAccessResultDone)
    {
        response = [[VersionResponse alloc] initWithDictionary:request.resultObject];
    }
    return response;
}

@end
