//
//  RSAccessToken.h
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 25.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RSAccessToken : NSObject

@property (strong, nonatomic) NSString *access_token;
@property (strong, nonatomic) NSDate   *expires_in;
@property (strong, nonatomic) NSString *id_token;
@property (strong, nonatomic) NSString *refresh_token;
@property (strong, nonatomic) NSString *token_type;

- (id) initWithGmailTokenResponse:(NSDictionary *)dictFromJSON;

@end
