//
//  MainViewController.m
//  Navigation
//
//  Created by Tammy Coron on 1/19/13.
//  Copyright (c) 2013 Tammy L Coron. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "MainViewController.h"
#import "TweetsViewController.h"
#import "MenuViewController.h"
#import "ProfileViewController.h"


#define CENTER_TAG 1
#define LEFT_PANEL_TAG 2
#define RIGHT_PANEL_TAG 3

#define CORNER_RADIUS 4

#define SLIDE_TIMING .25
#define PANEL_WIDTH 60

@interface MainViewController () <TweetsViewControllerDelegate, UIGestureRecognizerDelegate, ProfileViewControllerDelegate
>

@property (nonatomic, strong) TweetsViewController *TweetsViewController;
@property (nonatomic, strong) MenuViewController *MenuViewController;
@property (nonatomic, strong) ProfileViewController *profileViewController;
@property (nonatomic, assign) BOOL showingLeftPanel;
@property (nonatomic, assign) BOOL showPanel;
@property (nonatomic, assign) CGPoint preVelocity;

@end

@implementation MainViewController

#pragma mark -
#pragma mark View Did Load/Unload

-(void)viewDidLoad {
    [super viewDidLoad];
    [self setupView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
}

#pragma mark -
#pragma mark View Will/Did Appear

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

#pragma mark -
#pragma mark View Will/Did Disappear

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

#pragma mark -
#pragma mark Setup View

-(void)setupView {
    self.TweetsViewController = [[TweetsViewController alloc] initWithNibName:@"TweetsViewController" bundle:nil];
    self.TweetsViewController.view.tag = CENTER_TAG;
    self.TweetsViewController.delegate = self;
    
    self.profileViewController = [[ProfileViewController alloc] init];
    self.profileViewController.view.tag = CENTER_TAG;
     _profileViewController.view.frame = CGRectMake(300, 0, self.view.frame.size.width, self.view.frame.size.height);
    self.profileViewController.delegate = self;
    
    
    [self.view addSubview:self.TweetsViewController.view];
    [self addChildViewController:_TweetsViewController];
    [_TweetsViewController didMoveToParentViewController:self];
    
    [self setupGestures];
}

-(void)showTweetsViewWithShadow:(BOOL)value withOffset:(double)offset {
    if (value) {
        [_TweetsViewController.view.layer setCornerRadius:CORNER_RADIUS];
        [_TweetsViewController.view.layer setShadowColor:[UIColor blackColor].CGColor];
        [_TweetsViewController.view.layer setShadowOpacity:0.8];
        [_TweetsViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
        
    } else {
        [_TweetsViewController.view.layer setCornerRadius:0.0f];
        [_TweetsViewController.view.layer setShadowOffset:CGSizeMake(offset, offset)];
    }
}

-(void)resetMainView {
    // remove left and right views, and reset variables, if needed
    if (_MenuViewController != nil) {
        [self.MenuViewController.view removeFromSuperview];
        self.MenuViewController = nil;
       // _TweetsViewController.leftButton.tag = 1;
        self.showingLeftPanel = NO;
    }
    
    // remove view shadows
    [self showTweetsViewWithShadow:NO withOffset:0];
}

-(UIView *)getLeftView {
    // init view if it doesn't already exist
    if (_MenuViewController == nil)
    {
        // this is where you define the view for the left panel
        self.MenuViewController = [[MenuViewController alloc] initWithNibName:@"MenuViewController" bundle:nil];
        self.MenuViewController.delegate = self;
        self.MenuViewController.view.tag = LEFT_PANEL_TAG;
//        self.MenuViewController.delegate = _TweetsViewController;
        
        [self.view addSubview:self.MenuViewController.view];
        
        [self addChildViewController:_MenuViewController];
        [_MenuViewController didMoveToParentViewController:self];
        
        _MenuViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
    
    self.showingLeftPanel = YES;
    
    // setup view shadows
    [self showTweetsViewWithShadow:YES withOffset:-2];
    
    UIView *view = self.MenuViewController.view;
    return view;
}


-(void)setupGestures {
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer setMinimumNumberOfTouches:1];
    [panRecognizer setMaximumNumberOfTouches:1];
    [panRecognizer setDelegate:self];
    
    UIPanGestureRecognizer *panRecognizer2 = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(movePanel:)];
    [panRecognizer2 setMinimumNumberOfTouches:1];
    [panRecognizer2 setMaximumNumberOfTouches:1];
    [panRecognizer2 setDelegate:self];
    
    [_TweetsViewController.view addGestureRecognizer:panRecognizer];
    [_profileViewController.view addGestureRecognizer:panRecognizer2];
}

-(void)movePanel:(id)sender {
    [[[(UITapGestureRecognizer*)sender view] layer] removeAllAnimations];
    
    CGPoint translatedPoint = [(UIPanGestureRecognizer*)sender translationInView:self.view];
    CGPoint velocity = [(UIPanGestureRecognizer*)sender velocityInView:[sender view]];
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateBegan) {
        UIView *childView = nil;
        
        if(velocity.x > 0) {
                childView = [self getLeftView];
        }

        [self.view sendSubviewToBack:childView];
        [[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateEnded) {

        if (!_showPanel) {
            [self movePanelToOriginalPosition];
        } else {
            if (_showingLeftPanel) {
                [self movePanelRight];
            }
        }
    }
    
    if([(UIPanGestureRecognizer*)sender state] == UIGestureRecognizerStateChanged) {

        _showPanel = abs([sender view].center.x - _TweetsViewController.view.frame.size.width/2) > _TweetsViewController.view.frame.size.width/2;
        

        [sender view].center = CGPointMake([sender view].center.x + translatedPoint.x, [sender view].center.y);
        [(UIPanGestureRecognizer*)sender setTranslation:CGPointMake(0,0) inView:self.view];

        
        _preVelocity = velocity;
    }
}

-(void)movePanelRight {
    UIView *childView = [self getLeftView];
    [self.view sendSubviewToBack:childView];
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _TweetsViewController.view.frame = CGRectMake(self.view.frame.size.width - PANEL_WIDTH, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
                     completion:^(BOOL finished) {
                         if (finished) {
                       //      _TweetsViewController.leftButton.tag = 0;
                         }
                     }];
}

-(void)movePanelToProfilePosition {
    [self.TweetsViewController.view removeFromSuperview];
    [self resetMainView];
    [self.view addSubview:self.profileViewController.view];
    [self addChildViewController:_profileViewController];
    [_profileViewController didMoveToParentViewController:self];
    
    [self.view bringSubviewToFront:self.profileViewController.view];
    
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _profileViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self resetMainView];
                         }
                     }];


}
-(void)movePanelToOriginalPosition {
    [UIView animateWithDuration:SLIDE_TIMING delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
        _TweetsViewController.view.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }
                     completion:^(BOOL finished) {
                         if (finished) {
                             [self resetMainView];
                         }
                     }];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

-(void)newViewSelected:(NSString *)vc {
    NSLog(@"time to change the view from the menu! %@", vc);
    if ([vc isEqualToString:@"profile"]) {
        [self movePanelToProfilePosition];

                //[[sender view] bringSubviewToFront:[(UIPanGestureRecognizer*)sender view]];
    } else {
        [self.profileViewController.view removeFromSuperview];
        [self resetMainView];
        [self.view addSubview:self.TweetsViewController.view];
        [self addChildViewController:_TweetsViewController];
        [_TweetsViewController didMoveToParentViewController:self];
        
        [self.view bringSubviewToFront:self.TweetsViewController.view];

        [self movePanelToOriginalPosition];
    }
}
@end
