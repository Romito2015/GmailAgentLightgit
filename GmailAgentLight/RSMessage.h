//
//  RSMessageInList.h
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 30.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//
typedef enum {
    
    RSSent                  = 1 << 0,
    RSInbox                 = 1 << 1,
    RSImportant             = 1 << 2,
    RSUnread                = 1 << 3,
    RSSpam                  = 1 << 4,
    RSTrash                 = 1 << 5,
    RSCategoryPromotioms    = 1 << 6,
    RSCategoryPersonal      = 1 << 7,
    RSCategorySocial        = 1 << 8
   
    
} RSMessageLabel;



#import <Foundation/Foundation.h>

@interface RSMessage : NSObject

@property (strong, nonatomic) NSString *messageId;
@property (strong, nonatomic) NSString *snippet;
//@property (assign, nonatomic) NSMutableArray *labelIds;
@property (assign, nonatomic) RSMessageLabel currentLabels;

- (id) initWithResponse:(NSDictionary *)responseList;

- (void) cloneLabelsToObjectMesage:(NSArray *) labelIds;
- (RSMessageLabel) getLabelType: (NSString *) labelId;

@end

/*
 
SENT
INBOX
IMPORTANT
UNREAD
SPAM
TRASH
CATEGORY_PROMOTIONS
CATEGORY_PERSONAL
CATEGORY_SOCIAL
 
*/
