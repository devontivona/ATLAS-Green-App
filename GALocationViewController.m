//
//  GALocationViewController.m
//  ATLAS Green App
//
//  Created by Devon Tivona on 2/19/12.
//  Copyright (c) 2012 mousebird consulting. All rights reserved.
//

#import "GALocationViewController.h"
#import "GALocation.h"
#import "GAAppDelegate.h"
#import <MediaPlayer/MediaPlayer.h>
#import "UIView+Screenshot.h"
#import <QuartzCore/QuartzCore.h>

@interface GALocationViewController()

- (void)moviePlayerWillEnterFullScreen:(NSNotification*)notification;
- (void)moviePlayerWillExitFullScreen:(NSNotification*)notification;

@end

@implementation GALocationViewController

@synthesize location;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{    
    
    // Setup the movie player
    NSURL *videoURL = [[NSBundle mainBundle] URLForResource:location.videoTitle withExtension:@"m4v"];
    
    moviePlayer = [[MPMoviePlayerController alloc] initWithContentURL:videoURL];
    moviePlayer.controlStyle = MPMovieControlStyleEmbedded;
    moviePlayer.allowsAirPlay = YES;
    moviePlayer.shouldAutoplay = NO;
    
    [moviePlayer.view setFrame: CGRectMake(56, 100, self.view.frame.size.width - 56*2, 400)];

    moviePlayer.view.layer.shadowOpacity = 0.6;
    moviePlayer.view.layer.shadowPath = [[UIBezierPath bezierPathWithRect:moviePlayer.view.bounds] CGPath];
    moviePlayer.view.layer.shadowRadius = 15;
    moviePlayer.view.layer.masksToBounds = NO;
    
    [moviePlayer  prepareToPlay];
    [self.view addSubview: moviePlayer.view];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerWillEnterFullScreen:) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(moviePlayerWillExitFullScreen:) name:MPMoviePlayerWillExitFullscreenNotification object:nil];

    
    // Set up the narrative text field
    UILabel *narrativeLabel = [[UILabel alloc] init];
    narrativeLabel.numberOfLines = 0;
    narrativeLabel.text = location.narrative;
    narrativeLabel.backgroundColor = [UIColor clearColor];
    narrativeLabel.textColor = [UIColor blackColor];
    narrativeLabel.shadowColor = [UIColor whiteColor];
    narrativeLabel.shadowOffset = CGSizeMake(0.0, -1.0);

    CGSize narrativeLabelSize = [narrativeLabel sizeThatFits:CGSizeMake(self.view.frame.size.width - 60*2, 5000)];
    narrativeLabel.frame = CGRectMake(60, 556, narrativeLabelSize.width, narrativeLabelSize.height);
    
    [self.view addSubview: narrativeLabel];
    
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];

    navigationItem.title = location.name;
}

- (void)viewWillDisappear:(BOOL)animated
{
    UIImageView *moviePlayerImageView = [[UIImageView alloc] initWithImage:[moviePlayer.view screenshot]];
    moviePlayerImageView.frame = moviePlayer.view.frame;
    [self.view addSubview:moviePlayerImageView];
    [moviePlayer.view removeFromSuperview];
    [super viewWillDisappear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
 }

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

#pragma mark - GALocationViewController Methods


- (void)moviePlayerWillEnterFullScreen:(NSNotification*)notification
{
}

- (void)moviePlayerWillExitFullScreen:(NSNotification*)notification
{
}

@end
