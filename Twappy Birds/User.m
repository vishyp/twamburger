//
//  User.m
//  Twappy Birds
//
//  Created by Vishy Poosala on 10/27/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import "User.h"
#import "TwitterClient.h"


NSString * const UserDidLoginNotification = @"UserDidLoginNotification";
NSString * const UserDidLogoutNotification = @"UserDidLogoutNotification";


@interface User()
@property (nonatomic, strong) NSDictionary *dictionary;
@end

@implementation User

- (id) initWithDictionary:(NSDictionary *) dictionary {
    
    if (self = [super init]) {
        self.dictionary = dictionary;
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        self.profileImageUrl = dictionary[@"profile_image_url"];
        self.tagline = dictionary[@"description"];
        self.followers = [NSString stringWithFormat:@"%@ followers", dictionary[@"followers_count"]];
        self.following = [NSString stringWithFormat:@"%@ following", dictionary[@"friends_count"]];
        self.numtweets = [NSString stringWithFormat:@"%@ tweets", dictionary[@"statuses_count"]];
        self.headerImgUrl = [NSString stringWithFormat:@"%@/300x100",  dictionary[@"profile_banner_url"]];
        NSLog(@"got header img: %@", self.headerImgUrl);
    }
    return self;
}

- (NSString*)description
{
    return [NSString stringWithFormat:@"User: <name = %@, screenName = %@, profileImageUrl = %@, tagline = %@>", self.name, self.screenName, self.profileImageUrl, self.tagline];
}

static User *_currentUser = nil;
NSString *const kCurrentUserKey = @"kCurrentUserKey";

+ (User *) currentUser {
    if (_currentUser == nil) {
        NSData *data = [[NSUserDefaults standardUserDefaults] objectForKey:kCurrentUserKey];
        if (data != nil) {
            NSDictionary *dictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
            _currentUser = [[User alloc] initWithDictionary:dictionary];
        }
    }
    return _currentUser;
}

+ (void) setCurrentUser:(User *) currentUser {
    _currentUser = currentUser;
    if (_currentUser != nil) {
        NSData *data = [NSJSONSerialization dataWithJSONObject:currentUser.dictionary options:0 error:NULL];
        [[NSUserDefaults standardUserDefaults] setObject:data forKey:kCurrentUserKey];
    } else {
        [[NSUserDefaults standardUserDefaults] setObject:nil forKey:kCurrentUserKey];
    }
    [[NSUserDefaults standardUserDefaults] synchronize];
    
}

+ (void) logout {
    [User setCurrentUser:nil];
    [[TwitterClient sharedInstance].requestSerializer removeAccessToken];

    [[NSNotificationCenter defaultCenter] postNotificationName:UserDidLogoutNotification object:nil];
}


@end
