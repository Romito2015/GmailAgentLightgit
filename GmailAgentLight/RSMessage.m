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
        
        
        NSArray *labelIds = [responseList objectForKey:@"labelIds"];
        [self cloneLabelsToObjectMesage:labelIds];
        
        
    }
    return self;
}

- (void) cloneLabelsToObjectMesage:(NSArray *) labelIds {
    
    for (NSString *label in labelIds) {
        
        RSMessageLabel oneOfLabels = [self getLabelType:label];
        self.currentLabels = self.currentLabels | oneOfLabels;
    
    }
    
    
}


- (RSMessageLabel) getLabelType: (NSString *) labelId {
    
    RSMessageLabel label;
    
    if ([labelId isEqualToString:@"SENT"]) {
        label = RSSent;
        
    } else if ([labelId isEqualToString:@"INBOX"]) {
        label = RSInbox;
        
    } else if ([labelId isEqualToString:@"IMPORTANT"]) {
        label = RSImportant;
        
    } else if ([labelId isEqualToString:@"UNREAD"]) {
        label = RSUnread;
        
    } else if ([labelId isEqualToString:@"SPAM"]) {
        label = RSSpam;
        
    } else if ([labelId isEqualToString:@"TRASH"]) {
        label = RSTrash;
        
    } else if ([labelId isEqualToString:@"CATEGORY_PROMOTIONS"]) {
        label = RSCategoryPromotioms;
        
    } else if ([labelId isEqualToString:@"CATEGORY_PERSONAL"]) {
        label = RSCategoryPersonal;
        
    } else if ([labelId isEqualToString:@"CATEGORY_SOCIAL"]) {
        label = RSCategorySocial;
    }
    
    
    return label;
    
}



- (NSString*) answerByType:(RSMessageLabel) labelType {
    return self.currentLabels & labelType ? @"YES" : @"no";
}

- (NSString*) description {
    
    return [NSString stringWithFormat: @"SENT = %@\n"
                                        "INBOX = %@\n"
                                        "IMPORTANT = %@\n"
                                        "UNREAD = %@\n"
                                        "SPAM = %@\n"
                                        "TRASH = %@\n"
                                        "CATEGORY_PROMOTIONS = %@\n"
                                        "CATEGORY_PERSONAL = %@\n"
                                        "CATEGORY_SOCIAL = %@",
                                        [self answerByType:RSSent],
                                        [self answerByType:RSInbox],
                                        [self answerByType:RSImportant],
                                        [self answerByType:RSUnread],
                                        [self answerByType:RSSpam],
                                        [self answerByType:RSTrash],
                                        [self answerByType:RSCategoryPromotioms],
                                        [self answerByType:RSCategoryPersonal],
                                        [self answerByType:RSCategorySocial]];
    
}


@end
