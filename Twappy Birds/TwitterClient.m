//
//  TwitterClient.m
//  Twappy Birds
//
//  Created by Vishy Poosala on 10/27/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import "TwitterClient.h"
#import "Tweet.h"

NSString * const kTwitterConsumerKey = @"tHgleGjQ0HdK7rlxtgS98RuSR";
NSString * const kTwitterConsumerSecret = @"hkL00obHJFEVwWRXysVsJh3T3moFs7baSl65HBFKBANPaqE6a7";
NSString * const kTwitterBaseUrl = @"https://api.twitter.com";

@interface TwitterClient()

@property (nonatomic, strong) void(^loginCompletion)(User *user, NSError *error);
@end

@implementation TwitterClient

+ (TwitterClient *) sharedInstance {
    
    static TwitterClient *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (instance == nil) {
            instance = [[TwitterClient alloc] initWithBaseURL:[NSURL URLWithString:kTwitterBaseUrl] consumerKey:kTwitterConsumerKey consumerSecret:kTwitterConsumerSecret];
        }
    });
    return instance;
}


- (void) loginWithCompletion:(void(^)(User *user, NSError *error))completion {
    self.loginCompletion = completion;
    
    [self.requestSerializer removeAccessToken];
    [self fetchRequestTokenWithPath:@"oauth/request_token" method:@"GET" callbackURL:[NSURL URLWithString:@"cptwitterdemo://oauth"] scope:nil success:^(BDBOAuthToken *requestToken) {
        NSLog(@"got request token");
        NSURL *authUrl = [NSURL URLWithString:[NSString stringWithFormat:@"https://api.twitter.com/oauth/authorize?oauth_token=%@", requestToken.token]];
        [[UIApplication sharedApplication] openURL:authUrl];
       // self.loginCompletion
    } failure:^(NSError *error) {
        NSLog(@"failed to get request token");
        self.loginCompletion(nil, error);
    }];
    
    
}

- (void) getUserByHandle:(NSString *)userHandle completion:(void (^)(User  *user, NSError *error)) completion{
    NSLog(@"getting user for %@", userHandle);
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:userHandle, @"screen_name", nil];
    
    [self GET:@"1.1/users/lookup.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {

        User *user = [[User alloc] initWithDictionary:responseObject[0]];
        completion(user, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"not getting users %@", error);
        
        completion(nil, error);
    }];

    
}

- (void)openURL:(NSURL *)url {
    
    [self fetchAccessTokenWithPath:@"oauth/access_token" method:@"POST" requestToken:[BDBOAuthToken tokenWithQueryString:url.query] success:^(BDBOAuthToken *accessToken) {
        NSLog(@"got the access token");
        [self.requestSerializer saveAccessToken:accessToken];
        
        [self GET:@"1.1/account/verify_credentials.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            // NSLog(@"current user: %@", responseObject);
            User *user = [[User alloc] initWithDictionary:responseObject];
            [User setCurrentUser:user];
            NSLog(@"current user: %@", user.name);
            self.loginCompletion(user, nil);
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"could not get current user");
            self.loginCompletion(nil, error);
        }];
/*
        [[TwitterClient sharedInstance] GET:@"1.1/statuses/home_timeline.json" parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
            //NSLog(@"home timeline: %@", responseObject);
            NSArray *tweets = [Tweet tweetsWithArray:responseObject];
            for (Tweet *tweet in tweets) {
                NSLog(@"tweet: %@, created at %@, by %@", tweet.text, tweet.createdAt, tweet.author);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"could not get timeline");
        }];*/
        
        
    } failure:^(NSError *error) {
        NSLog(@"failed to get the access token");
    }];
    
}

- (void) homeTimelineWithParams:(NSDictionary *) params completion:(void (^)(NSArray *tweets, NSError *error)) completion {
    NSLog(@"getting timeline");
    [self GET:@"1.1/statuses/home_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];
        NSLog(@"got timeline");

        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"not getting timeline %@", error);

        completion(nil, error);
    }];
    
}

- (void) userTimelineWithParams:(NSDictionary *) params completion:(void (^)(NSArray *tweets, NSError *error)) completion {
    NSLog(@"getting user timeline");
    [self GET:@"1.1/statuses/user_timeline.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *tweets = [Tweet tweetsWithArray:responseObject];

        completion(tweets, nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(nil, error);
    }];
    
}

- (void) favToggle:(NSString *)tid completion:(void (^)(NSError *error)) completion {
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:tid, @"id", nil];
    NSLog(@"fav params %@", params);
 
    [self GET:@"1.1/favorites/create.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"fav well!");
        completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fav error %@", error);
        completion(error);
    }];
}

- (void) retweet:(NSString *)tid completion:(void (^)(NSError *error)) completion {
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:tid, @"id", nil];
    
    NSString *str = [NSString stringWithFormat:@"1.1/statuses/retweet/%@.json", tid];
    NSLog(@"ret url = %@", str);
    [self POST:str parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"fav well!");
        completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"fav error %@", error);
        completion(error);
    }];
}

- (void) postTweetForUser:(User *)user withText:(NSString *)txt completion:(void (^)(NSError *error)) completion {
    
    NSDictionary *params = [[NSDictionary alloc] initWithObjectsAndKeys:txt, @"status", nil];
    NSLog(@"posting tweet: %@", params);

    if ([txt length] <= 0) {
        NSLog(@"oops");
        NSMutableDictionary* details = [NSMutableDictionary dictionary];
        
        [details setValue:@"Empty Tweet?!!" forKey:NSLocalizedDescriptionKey];
        // populate the error object with the details
        completion([NSError errorWithDomain:@"tweets" code:200 userInfo:details]);
        return;
    }

    [self POST:@"1.1/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        completion(nil);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        completion(error);
    }];
    
}

@end
