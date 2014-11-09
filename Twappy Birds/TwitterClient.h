//
//  TwitterClient.h
//  Twappy Birds
//
//  Created by Vishy Poosala on 10/27/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import "BDBOAuth1RequestOperationManager.h"
#import "User.h"

@interface TwitterClient : BDBOAuth1RequestOperationManager

+ (TwitterClient *) sharedInstance;

- (void) loginWithCompletion:(void(^)(User *user, NSError *error))completion;

- (void) postTweetForUser:(User *)user withText:(NSString *)txt completion:(void (^)(NSError *error)) completion;


- (void) favToggle:(NSString *)tid completion:(void (^)(NSError *error)) completion;

- (void) retweet:(NSString *)tid completion:(void (^)(NSError *error)) completion;


- (void) openURL:(NSURL *)url;

- (void) homeTimelineWithParams:(NSDictionary *) params completion:(void (^)(NSArray *tweets, NSError *error)) completion;

- (void) userTimelineWithParams:(NSDictionary *) params completion:(void (^)(NSArray *tweets, NSError *error)) completion;

- (void) getUserByHandle:(NSString *)userHandle completion:(void (^)(User *user, NSError *error)) completion;

@end
