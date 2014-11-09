//
//  DetailViewController.m
//  Twappy Birds
//
//  Created by Vishy Poosala on 11/1/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import "DetailViewController.h"
#import "UIImageView+AFNetworking.h"
#import "TTTTimeIntervalFormatter.h"
#import "TwitterClient.h"
#import "NewTweetController.h"


@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self showTweet];
}

-(void) showTweet {


    [self.userImage setImageWithURL:[NSURL URLWithString:self.tweet.author.profileImageUrl]];
    
    
    //TTTTimeIntervalFormatter *tif = [[TTTTimeIntervalFormatter alloc] init];
    //int sec = [self.tweet.createdAt timeIntervalSinceNow];
    
   // NSString *tt = [tif stringForTimeInterval:sec];
    self.createdAt.text = [NSString stringWithFormat:@"%@", self.tweet.createdAt];
    self.tweetText.text = self.tweet.text;
    self.displayName.text = self.tweet.author.name;
    self.userHandle.text =[NSString stringWithFormat:@"@%@", self.tweet.author.screenName];
    

    
    [self.replyButton setImage:[UIImage imageNamed:@"reply_hover"] forState:UIControlStateHighlighted];
    [self.retweetButton setImage:[UIImage imageNamed:@"retweet_hover"] forState:UIControlStateHighlighted];
    [self.favButton setImage:[UIImage imageNamed:@"fav-over"] forState:UIControlStateHighlighted];
    
    self.numFavs.text = [NSString stringWithFormat:@"%d", self.tweet.favCount];
    self.numRetweets.text = [NSString stringWithFormat:@"%d", self.tweet.retweetCount];
    

    if (self.tweet.sender != nil) {
        self.retweetTextAtTop.text = [NSString stringWithFormat:@"%@ retweeted", self.tweet.sender.name];
        
        [self.retweetTextAtTop setHidden:NO];
        [self.retweetImageAtTop setHidden:NO];
        self.imageTopConstraint.constant = 100;
    } else {
        [self.retweetTextAtTop setHidden:YES];
        [self.retweetImageAtTop setHidden:YES];
        self.imageTopConstraint.constant = 80;
    }

    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)onReply:(id)sender {
    NewTweetController *ntc = [[NewTweetController alloc] init];
    ntc.replyHandle = [NSString stringWithFormat:@"@%@ ", self.tweet.author.screenName];
    [self.navigationController pushViewController:ntc animated:YES];
}

- (IBAction)onRetweet:(id)sender {
    [[TwitterClient sharedInstance] retweet:self.tweet.idstr completion:^(NSError *error) {
        if (! error) {
            [self.retweetButton setImage:[UIImage imageNamed:@"retweet_on"] forState:UIControlStateNormal];
        }
    }];
}

- (IBAction)onFav:(id)sender {
    
    [[TwitterClient sharedInstance] favToggle:self.tweet.idstr completion:^(NSError *error) {
        if (! error) {
          [self.favButton setImage:[UIImage imageNamed:@"fav-on"] forState:UIControlStateNormal];
        }
    }];
    
}




@end
