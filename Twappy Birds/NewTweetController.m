//
//  NewTweetController.m
//  Twappy Birds
//
//  Created by Vishy Poosala on 11/1/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import "NewTweetController.h"
#import "User.h"
#import "UIImageView+AFNetworking.h"
#import "TwitterClient.h"

@interface NewTweetController ()

@end

@implementation NewTweetController

- (void)viewDidLoad {
    [super viewDidLoad];

    //self.tweetsTable.rowHeight = UITableViewAutomaticDimension;
    self.tweetField.delegate = self;
    [self.tweetField addTarget:self
                  action:@selector(textFieldDidChange)
        forControlEvents:UIControlEventEditingChanged];
    
    
    self.title = @"";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Tweet" style:UIBarButtonItemStylePlain target:self action:@selector(onTweet)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(onCancel)];
    
    //NSLog(@"current user: %@", [User currentUser]);
    User *u = [User currentUser];
    
    
    [self.userImage setImageWithURL:[NSURL URLWithString:u.profileImageUrl]];
    
    self.name.text = u.name;
    self.handle.text =[NSString stringWithFormat:@"@%@", u.screenName];
    self.tweetField.text = self.replyHandle;
    // Do any additional setup after loading the view from its nib.
}

- (void) onTweet {
    

    
    [[TwitterClient sharedInstance] postTweetForUser:[User currentUser] withText:self.tweetField.text completion:^(NSError *error) {
        if (error) {

            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Tweet Error" message:[error localizedDescription] delegate:self cancelButtonTitle:@"cancel" otherButtonTitles:nil];
            [alert show];
        } else {

            [self.navigationController popViewControllerAnimated:YES];
        }
    }];

}

- (void) onCancel {
    
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) textFieldDidChange {
    long l = 140 - [self.tweetField.text length];
    self.lengthLabel.text = [NSString stringWithFormat:@"%ld", l];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
