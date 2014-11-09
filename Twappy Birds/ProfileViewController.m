//
//  ProfileViewController.m
//  Twappy Birds
//
//  Created by Vishy Poosala on 11/8/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import "ProfileViewController.h"
#import "User.h"
#import "Tweet.h"
#import "TwitterClient.h"
#import "UIImageView+AFNetworking.h"
#import "TweetCell.h"
#import "TTTTimeIntervalFormatter.h"
#import "DetailViewController.h"

@interface ProfileViewController ()
@property (strong, nonatomic) NSMutableArray *tweets;

@end

@implementation ProfileViewController


- (void) reloadTweets:(NSString *)userName {
    NSLog(@"getting tweets for %@", userName);
 
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:userName, @"screen_name", nil];
    [[TwitterClient sharedInstance] userTimelineWithParams:params completion:^(NSArray *tweets, NSError *error) {
        
        
        [self.tweets removeAllObjects];
        [self.tweets addObjectsFromArray:tweets];
        
        [self.userTweetsTableView reloadData];
        
    }];
}

-(void)viewWillAppear:(BOOL)animated {
    User *u;
    
    if (self.userHandle == nil) {
        u = [User currentUser];
        [self reloadTweets:u.name];
    }    else
        [self reloadTweets:self.userHandle];
    //[self.tweetsTable reloadData];
}

- (void) loadDataForUser:(User *) u {
    
    
    [self.userImageView setImageWithURL:[NSURL URLWithString:u.profileImageUrl]];
    [self.headerImageView setImageWithURL:[NSURL URLWithString:u.headerImgUrl]];
    
    self.nameLabel.text = u.name;
    
    NSLog(@"labels: followers %@, following %@, tweets %@", u.followers, u.following, u.numtweets);
    self.numFollowersLabel.text = u.followers;
    self.numFollowingLabel.text = u.following;
    self.numTweetsLabel.text = u.numtweets;
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tweets = [[NSMutableArray alloc] init];
    self.userTweetsTableView.rowHeight = UITableViewAutomaticDimension;
    self.userTweetsTableView.delegate = self;
    self.userTweetsTableView.dataSource = self;
    [self.userTweetsTableView registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    
    
    
    NSLog(@"in PVC user is %@", self.userHandle);
    if (self.userHandle == nil) {
        User *u = [User currentUser];
        [self loadDataForUser:u];
    }
    else {
       [[TwitterClient sharedInstance] getUserByHandle:self.userHandle completion:^(User *user, NSError *error) {
           User *u = user;
           [self loadDataForUser:u];
       }];
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



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Tweet *item;
    
    TweetCell *cell = [self.userTweetsTableView dequeueReusableCellWithIdentifier:@"TweetCell"];
    item = self.tweets[indexPath.row];
    
    cell.tweet = item;
    cell.rownum = (int)indexPath.row;
    
    [cell.authorImage setImageWithURL:[NSURL URLWithString:item.author.profileImageUrl]];
    
    
    TTTTimeIntervalFormatter *tif = [[TTTTimeIntervalFormatter alloc] init];
    int sec = [item.createdAt timeIntervalSinceNow];
    
    NSString *tt = [tif stringForTimeInterval:sec];
    cell.timeLabel.text = [tt substringToIndex:[tt length] - 4];
    
    //[NSString stringWithFormat:@"%@", item.createdAt];
    
    cell.tweetText.text = item.text;
    cell.authorName.text = item.author.name;
    cell.authorHandle.text = [NSString stringWithFormat:@"@%@", item.author.screenName];
    
    [cell.replyButton setImage:[UIImage imageNamed:@"reply_hover"] forState:UIControlStateHighlighted];
    [cell.retweetButton setImage:[UIImage imageNamed:@"retweet_hover"] forState:UIControlStateHighlighted];
    [cell.favButton setImage:[UIImage imageNamed:@"fav-over"] forState:UIControlStateHighlighted];
    
    
    
    if (item.sender != nil) {
        
        cell.retweetedLabel.text = [NSString stringWithFormat:@"%@ retweeted", item.sender.name];
        //cell.retweetedLabel.text = item.retweetedMsg;
        [cell.retweetedLabel setHidden:NO];
        cell.imageTopMarginConstraint.constant = 17;
    } else {
        [cell.retweetedLabel setHidden:YES];
        cell.imageTopMarginConstraint.constant = 2;
    }
    
    
    
    return cell;
}


- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.tweets count];
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    DetailViewController *dvc = [[DetailViewController alloc]init];
    //mdvc.movie = self.movies[indexPath.row];
    dvc.title = @"Tweet";
    
    dvc.tweet = self.tweets[indexPath.row];
    [self.navigationController pushViewController:dvc animated:YES];
    
}


@end
