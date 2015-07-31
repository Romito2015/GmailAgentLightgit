//
//  RSMessageInList.m
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 30.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import "RSMessageInList.h"

@implementation RSMessageInList

- (id)initWithListResponse:(NSDictionary *)responseList
{
    self = [super init];
    if (self) {
        
        NSString *stringValue   = [responseList objectForKey:@"resultSizeEstimate"];
        self.resultSizeEstimate = [stringValue integerValue];
        self.messagesArray      = [responseList objectForKey:@"messages"];
        self.nextPageToken      = [responseList objectForKey:@"nextPageToken"];
   
    }
    return self;
}

@end
