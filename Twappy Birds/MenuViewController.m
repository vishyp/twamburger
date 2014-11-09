//
//  MenuViewController.m
//  Twappy Birds
//
//  Created by Vishy Poosala on 11/7/14.
//  Copyright (c) 2014 Vi Po. All rights reserved.
//

#import "MenuViewController.h"
#import "MenuViewCell.h"
#import "UIImageView+AFNetworking.h"
#import "User.h"

@interface MenuViewController ()
@property (strong, nonatomic) NSArray *menuItems;

@end

@implementation MenuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.menuTableView.delegate = self;
    self.menuTableView.dataSource = self;
    
    self.menuItems = @[@{@"code": @"profile", @"txt" : @"My Profile"},
                       @{@"code": @"home", @"txt" : @"Home Timeline"},
                       @{@"code": @"mentions", @"txt" : @"Mentions"}
                       ];
    
    User *u = [User currentUser];
    [self.userImage setImageWithURL:[NSURL URLWithString:u.profileImageUrl]];
    [self.menuTableView registerNib:[UINib nibWithNibName:@"MenuViewCell" bundle:nil] forCellReuseIdentifier:@"MenuViewCell"];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
 
    
    
    MenuViewCell *cell = [self.menuTableView dequeueReusableCellWithIdentifier:@"MenuViewCell"];
    cell.menuLabel.text = self.menuItems[indexPath.row][@"txt"];
    return cell;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuItems count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.delegate newViewSelected:self.menuItems[indexPath.row][@"code"]];
    

    
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
