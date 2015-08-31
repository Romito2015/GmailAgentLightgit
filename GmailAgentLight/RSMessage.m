//
//  RSMessageInList.m
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 30.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import "RSMessage.h"

@implementation RSMessage

- (id)initWithResponse:(NSDictionary *)responseList
{
    self = [super init];
    if (self) {
        
        self.messageId = [responseList objectForKey:@"id"];
        self.snippet   = [responseList objectForKey:@"snippet"];
        //self.labelIds  = [NSMutableArray arrayWithArray:];
        
        for (NSString *label in [responseList objectForKey:@"labelIds"]) {
            if ([label isEqualToString:@"SENT"]) {
                self.currentLabel = RSSent;
                break;
            } else if ([label isEqualToString:@"INBOX"]) {
                self.currentLabel = RSInbox;
                break;
            } else if (![label isEqualToString:@"INBOX"] && ![label isEqualToString:@"SENT"]) {
                self.currentLabel = RSOther;
                break;
            }

        }
    }
    return self;
}
@end
