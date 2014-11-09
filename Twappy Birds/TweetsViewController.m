//
//  TweetsViewController.m
//  Twappy Birds
//
//  Created by Vishy Poosala on 10/27/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import "TweetsViewController.h"
#import "User.h"
#import "TwitterClient.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "UIImageView+AFNetworking.h"
#import "TTTTimeIntervalFormatter.h"
#import "NewTweetController.h"
#import "DetailViewController.h"
#import "ProfileViewController.h"

@interface TweetsViewController ()
@property (strong, nonatomic) NSMutableArray *tweets;
@property (strong, nonatomic) NSMutableArray *userTweets;
@property (nonatomic) int userTweetIdx;
@property (nonatomic) BOOL showingMenu;

@property (strong, nonatomic) UIRefreshControl *refreshControl;
@end

@implementation TweetsViewController
BOOL startInfScroll;

- (void) reloadTweets {
    
    [[TwitterClient sharedInstance] homeTimelineWithParams:nil completion:^(NSArray *tweets, NSError *error) {
        
        [self.tweets removeAllObjects];
        [self.tweets addObjectsFromArray:tweets];
        
        [self.tweetsTable reloadData];
        
    }];
}

- (void) getUserTweets:(NSString *)userName {
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithObjectsAndKeys:userName, @"screen_name", nil];
    [[TwitterClient sharedInstance] userTimelineWithParams:params completion:^(NSArray *tweets, NSError *error) {
        
        [self.userTweets removeAllObjects];
        [self.userTweets addObjectsFromArray:tweets];
        self.userTweetIdx = 1;
        [self.tweetsTable reloadData];
        
        
    }];
    
}

- (void) getOlderTweets {
    startInfScroll = NO;
    
    if ([self.tweets count] <= 0) return;
    Tweet *lt =  [self.tweets lastObject];
    NSString *maxid = lt.idstr;
    NSMutableDictionary *dict = [NSMutableDictionary dictionaryWithObjectsAndKeys:maxid, @"max_id", nil];
    NSLog(@"getting older tweets");
    [[TwitterClient sharedInstance] homeTimelineWithParams:dict completion:^(NSArray *tweets, NSError *error) {
        
        [self.tweets addObjectsFromArray:tweets];
        
        [self.tweetsTable reloadData];
        
        
    }];
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    self.showingMenu = NO;
    startInfScroll = NO;
    self.tweets = [[NSMutableArray alloc] init];
    self.userTweets = [[NSMutableArray alloc] init];
    self.userTweetIdx = -1;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnTweetPlay:) name:PlayOnTweetNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(OnProfileClicked:) name:@"UserProfileClicked" object:nil];
    
    // Do any additional setup after loading the view from its nib.
    self.tweetsTable.rowHeight = UITableViewAutomaticDimension;
    self.tweetsTable.delegate = self;
    self.tweetsTable.dataSource = self;
    
    self.title = @"Home";
    self.tabBarItem.title = @"Home";
    self.navigationController.navigationBar.barTintColor = [UIColor colorWithRed:29/255.9 green:202/255.0 blue:255/255.0 alpha:1.0];
    
    NSDictionary *attributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                [UIColor whiteColor],
                                NSForegroundColorAttributeName, nil];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"New" style:UIBarButtonItemStylePlain target:self action:@selector(onNewTweetButton)];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStylePlain target:self action:@selector(onLogoutButton)];
    
    
    [self.tweetsTable registerNib:[UINib nibWithNibName:@"TweetCell" bundle:nil] forCellReuseIdentifier:@"TweetCell"];
    //[self reloadTweets];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(reloadTweets) forControlEvents:UIControlEventValueChanged];
    [self.tweetsTable insertSubview:self.refreshControl atIndex:0];
    
    startInfScroll = YES;
    
}


- (void) OnProfileClicked:(NSNotification*)notification {
    NSDictionary* userInfo = notification.userInfo;
    NSString *userHandle = userInfo[@"userHandle"];
    NSLog(@"user profile clicked, got event. %@", userHandle);
    
    ProfileViewController *ptc = [[ProfileViewController alloc] init];
    ptc.userHandle = userHandle;
    
    UINavigationController *nvc = [[UINavigationController alloc]initWithRootViewController:ptc];
    
    [self presentViewController:nvc animated:YES completion:nil];
    
    //[self.navigationController pushViewController:ptc animated:YES];
    //ntc.title = @"Tweet";

}


- (void) OnTweetPlay:(NSNotification*)notification
{
    
    NSDictionary* userInfo = notification.userInfo;
    NSNumber* rownum = (NSNumber*)userInfo[@"rownum"];
    Tweet *tw = self.tweets[rownum.intValue];
    
    if (self.userTweetIdx > 0) {
        self.userTweetIdx++;
        [self.tweetsTable reloadData];
    } else {
        [self getUserTweets:tw.author.screenName];
    }
}

-(void)viewWillAppear:(BOOL)animated {
    [self reloadTweets];
    //[self.tweetsTable reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Tweet *item;
    
    TweetCell *cell = [self.tweetsTable dequeueReusableCellWithIdentifier:@"TweetCell"];
    //TweetCell *cell = [self.tweetsTable dequeueReusableCellWithIdentifier:@"TweetCell"];
    
    
    // TODO: implementing the side Play button for Row 2 for now.. it's easy to extend to all rows
    // with a dictionary of such tweets for all rows.
    if ((indexPath.row == 2) && (self.userTweetIdx > 0) && (self.userTweetIdx < [self.userTweets count]-1)) {
        item = self.userTweets[self.userTweetIdx];
    } else {
        item = self.tweets[indexPath.row];
    }
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


-(void)onNewTweetButton {
    NewTweetController *ntc = [[NewTweetController alloc] init];
    [self.navigationController pushViewController:ntc animated:YES];
    ntc.title = @"Tweet";
    /* VPSettingsViewController *svc = [[VPSettingsViewController alloc] init];
     [self.navigationController pushViewController:svc animated:YES];
     svc.title = @"Tip Settings";
     */
}

-(void)onLogoutButton {
    /* VPSettingsViewController *svc = [[VPSettingsViewController alloc] init];
     [self.navigationController pushViewController:svc animated:YES];
     svc.title = @"Tip Settings";
     */
    [User logout];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)onLogout:(id)sender {
    
}

-(void) scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    CGFloat actualPosition = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.contentSize.height - 700;
    // NSLog(@"positions %f -- %f", actualPosition, contentHeight);
    if (! startInfScroll) return;
    if (contentHeight < 100) return;
    if (actualPosition >= contentHeight) {
        startInfScroll = NO;
        
        [self getOlderTweets];
        
        startInfScroll = YES;
        
    }
}



/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

- (IBAction)onMenuClicked:(id)sender {
    
    UIButton *button = sender;
    switch (button.tag) {
        case 0: {
            [_delegate movePanelToOriginalPosition];
            self.showingMenu = NO;
            break;
        }
            
        case 1: {
            [_delegate movePanelRight];
            self.showingMenu = YES;
            break;
        }
            
        default:
            break;
    }
}
- (IBAction)onTableTapped:(UITapGestureRecognizer *)sender {
    
    
    if (self.showingMenu) {
        [_delegate movePanelToOriginalPosition];
        self.showingMenu = NO;
    } else {
        
        [_delegate movePanelRight];
        self.showingMenu = YES;
    }
    
}
/*
- (IBAction)onTablePanned:(UIPanGestureRecognizer *)sender {
    CGPoint point = [sender locationInView:self.view];
    point.x += self.view.frame.origin.x;
   // CGPoint velocity = [sender velocityInView:self.view];
    if (sender.state == UIGestureRecognizerStateBegan){
        NSLog(@"gesture began at: %@", NSStringFromCGPoint(point));
        [_delegate startPanningAtLocation:point];
            [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    }
    else if (sender.state == UIGestureRecognizerStateChanged){
       // NSLog(@"gesture changed at: %@, velocity = %@", NSStringFromCGPoint(point), NSStringFromCGPoint(velocity));
        [_delegate panPanelRightAtLocation:point];
    }
    else if (sender.state == UIGestureRecognizerStateEnded){
        NSLog(@"gesture ended at: %@", NSStringFromCGPoint(point));
        [_delegate endPanningAtLocation:point];
    }

}
*/


@end
