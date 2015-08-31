//
//  RSAccessToken.m
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 25.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import "RSAccessToken.h"

@implementation RSAccessToken

- (id)initWithGmailTokenResponse:(NSDictionary *)responseObject
{
    self = [super init];
    if (self) {
        
        self.access_token  = [responseObject objectForKey:@"access_token"];
        self.expires_in    = [responseObject objectForKey:@"expires_in"];
        self.id_token      = [responseObject objectForKey:@"id_token"];
        self.refresh_token = [responseObject objectForKey:@"refresh_token"];
        self.token_type    = [responseObject objectForKey:@"token_type"];
        
    }
    return self;
}

@end
