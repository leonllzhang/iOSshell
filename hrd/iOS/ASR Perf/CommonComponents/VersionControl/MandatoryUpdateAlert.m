//
//  MandatoryUpdateAlert.m
//  Hybrid Framework for iPhone
//
//  Created by Nep Tong on 2/20/14.
//  Copyright (c) 2014 PwC. All rights reserved.
//

#import "MandatoryUpdateAlert.h"

@implementation MandatoryUpdateAlert

- (id)initWithMessage:(NSString *)message
{
    self = [super initWithTitle:@"Update Available" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    return self;
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    abort();
}
@end
