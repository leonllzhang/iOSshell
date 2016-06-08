//
//  VersionResponse.h
//  Hybrid Framework for iPhone
//
//  Created by Nep Tong on 2/20/14.
//  Copyright (c) 2014 PwC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface VersionResponse : NSObject

@property (strong, nonatomic) NSString *AppCode;
@property (nonatomic) BOOL MandatoryFlag;
@property (nonatomic) BOOL OptionFlag;
@property (strong, nonatomic) NSString *Message;

- (id)initWithDictionary:(NSDictionary *)dictionary;

@end
