//
//  OptionalUpdateAlert.m
//  Hybrid Framework for iPhone
//
//  Created by Nep Tong on 2/20/14.
//  Copyright (c) 2014 PwC. All rights reserved.
//

#import "OptionalUpdateAlert.h"

@implementation OptionalUpdateAlert

- (id)initWithMessage:(NSString *)message
{
    self = [super initWithTitle:@"Update Available" message:message delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
    return self;
}

@end
