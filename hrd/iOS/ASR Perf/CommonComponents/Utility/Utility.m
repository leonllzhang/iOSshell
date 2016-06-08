//
//  Utility.m
//  HybridFramework
//
//  Created by Nep Tong on 4/9/13.
//  Copyright (c) 2013 Nep Tong. All rights reserved.
//

#import "Utility.h"

@implementation Utility

+ (UIColor *)getColorFromDictionary:(NSDictionary *)dicColor
{
    CGFloat red = [[dicColor valueForKey:@"red"] floatValue] / 255.0f;
    CGFloat green = [[dicColor valueForKey:@"green"] floatValue] / 255.0f;
    CGFloat blue = [[dicColor valueForKey:@"blue"] floatValue] / 255.0f;
    CGFloat alpha = [[dicColor valueForKey:@"alpha"] floatValue] / 255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

+ (NSString *)getFullUrlWithApplicationPath:(NSString *)applicationPath
{
    NSString *domainString = [[NSBundle mainBundle].infoDictionary objectForKey:@"DomainString"];
    return [domainString stringByAppendingString:applicationPath];
}
@end
