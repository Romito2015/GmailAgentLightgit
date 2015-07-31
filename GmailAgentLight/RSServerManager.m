//
//  RSServerManager.m
//  GmailAgentLight
//
//  Created by Roman Chopovenko on 25.07.15.
//  Copyright (c) 2015 Roman Chopovenko. All rights reserved.
//

#import "RSServerManager.h"
#import "AFNetworking.h"
#import "RSUser.h"
#import "RSAccessToken.h"
#import "RSMessageInList.h"


@interface RSServerManager()

@property (strong, nonatomic) AFHTTPRequestOperationManager *requestOperationManager;

@end


@implementation RSServerManager

//singleton
+ (RSServerManager *) sharedManager {
    
    static RSServerManager *manager = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[RSServerManager alloc] init];
    });
    
    return manager;
    
}

- (id)init
{
    self = [super init];
    if (self) {
        NSURL *url = [NSURL URLWithString:@"https://www.googleapis.com/"];
        self.requestOperationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    }
    return self;
}


- (void) authorizeUser:(NSString *)recivedAuthorizationCode
                   onSuccess:(void (^)(RSAccessToken *gmailToken))success
                   onFailure:(void (^)(NSError *, NSInteger))failure {
    
    NSDictionary *tokenParameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                                      recivedAuthorizationCode, @"code",
   @"555621197106-tbhcihl4onod6560neusglq41i6g6m7f.apps.googleusercontent.com", @"client_id",
                                                   @"dYnKQi2a55a9YMG4axZjJdQr", @"client_secret",
                                                           @"http://localhost", @"redirect_uri",
                                                         @"authorization_code", @"grant_type", nil];
    
    [self.requestOperationManager
     POST:@"oauth2/v3/token"
     parameters:tokenParameters
     success:^(AFHTTPRequestOperation *operation, id responseObject) {
         //NSLog(@"JSON : %@", responseObject);
         RSAccessToken * gmailToken = [[RSAccessToken alloc] initWithGmailTokenResponse:responseObject];
         
         if (success) {
             success(gmailToken);
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}

- (void) getMessagesList:(RSAccessToken *)accessToken
               onSuccess:(void (^)(RSMessageInList *result))success
               onFailure:(void (^)(NSError *, NSInteger))failure {
    
    NSDictionary *Parameters = [NSDictionary dictionaryWithObjectsAndKeys:
                                                                  @"true", @"includeSpamTrash",
                                              @"https://mail.google.com/", @"scope",nil];
    
    AFHTTPRequestSerializer *requestSerializer = [AFJSONRequestSerializer serializer];
    NSString *authValue = [NSString stringWithFormat:@"Bearer %@", accessToken.access_token];
   [requestSerializer setValue: authValue forHTTPHeaderField:@"Authorization"];
   [requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    
    self.requestOperationManager.requestSerializer = requestSerializer;
    [self.requestOperationManager
     GET:@"gmail/v1/users/me/messages"
     parameters: Parameters
     success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
         
         //NSLog(@"JSON : %@", responseObject);
         
         RSMessageInList * messagesList = [[RSMessageInList alloc] initWithListResponse:responseObject];
        
         if (success) {
             success(messagesList);
         }
     }
     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
         NSLog(@"Error: %@", error);
         if (failure) {
             failure(error, operation.response.statusCode);
         }
     }];
}




@end
