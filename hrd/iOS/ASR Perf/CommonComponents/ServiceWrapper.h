//
//  ServiceWrapper.h
//  PwC Contacts for iphone
//
//  Created by Nep Tong on 2/18/13.
//
//

#import <Foundation/Foundation.h>

@interface ServiceWrapper : NSObject

@property (readonly) NSInteger returnCode;
@property (strong, nonatomic, readonly) id data;
@property (strong, nonatomic, readonly) NSString *message;

- (id)initWithDictionary:(NSDictionary *)aDictionary;
@end
