//
//  VersionResponse.m
//  Hybrid Framework for iPhone
//
//  Created by Nep Tong on 2/20/14.
//  Copyright (c) 2014 PwC. All rights reserved.
//

#import "VersionResponse.h"

@implementation VersionResponse

@synthesize AppCode;
@synthesize MandatoryFlag;
@synthesize OptionFlag;
@synthesize Message;

- (id)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self)
    {
        self.AppCode = [dictionary objectForKey:@"AppCode"];
        self.MandatoryFlag = [[dictionary objectForKey:@"MandatoryFlag"] boolValue];
        self.OptionFlag = [[dictionary objectForKey:@"OptionFlag"] boolValue];
        self.Message = [[dictionary objectForKey:@"Message"]stringByReplacingOccurrencesOfString:@"[br]" withString:@"\n"];
    }
    return self;
}

@end
