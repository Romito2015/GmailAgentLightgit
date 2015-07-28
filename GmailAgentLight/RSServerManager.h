//
//  RSServerManager.h
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 25.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSAccessToken.h"

@class RSUser;

@interface RSServerManager : NSObject

@property (strong, nonatomic) RSUser *currentUser;

+ (RSServerManager *) sharedManager;

- (void) authorizeUser: (NSString *) recivedAuthorizationCode
             onSuccess:(void(^)(RSAccessToken *gmailToken)) success
             onFailure: (void (^)(NSError *error, NSInteger statusCode)) failure;

- (void) getMessagesList: (RSAccessToken *) accessToken
               onSuccess:(void(^)(id *result)) success
             onFailure: (void (^)(NSError *error, NSInteger statusCode)) failure;

@end
