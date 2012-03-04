//
//  GAStatisticsViewController.m
//  ATLAS Green App
//
//  Created by Devon Tivona on 2/6/12.
//  Copyright (c) 2012 mousebird consulting. All rights reserved.
//

#import "GAStatisticsViewController.h"
#import "GAConstants.h"


@implementation GAStatisticsViewController
@synthesize coinCountLabel;
@synthesize countriesVisitedLabel;
@synthesize typeOfTravelerLabel;


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
-(void) viewWillAppear:(BOOL)animated
{
    NSInteger points = [[NSUserDefaults standardUserDefaults] integerForKey:GAUserDefaultsCoinCount];
    NSInteger countriesVisited = [[NSUserDefaults standardUserDefaults] integerForKey:GAUserDefaultsPlacesVisited];
    
    if (points <= 5) 
    {
        typeOfTravelerLabel.text = @"Sightseer";
    }
    else if (points > 5 && points <=10)
    {
        typeOfTravelerLabel.text = @"Traveler";
    }
    else if (points > 10 && points <=15)
    {
        typeOfTravelerLabel.text = @"Adventurer";
    }
    else if(points > 15 && points <= 20)
    {
        typeOfTravelerLabel.text = @"Explorer";
    }
    else
    {
        typeOfTravelerLabel.text = @"Voyager";
    }
    
    coinCountLabel.text = [NSString stringWithFormat:@"%d Eco Coins", points];
    countriesVisitedLabel.text = [NSString stringWithFormat:@"%d Countries Visited", countriesVisited];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    navigationItem.title = @"Player Statistics";
}

- (void)viewDidUnload
{
    [self setCoinCountLabel:nil];
    [self setCountriesVisitedLabel:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

@end
