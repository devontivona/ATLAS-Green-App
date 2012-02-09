//
//  GAFormViewController.m
//  ATLAS Green App
//
//  Created by Devon Tivona on 2/6/12.
//  Copyright (c) 2012 mousebird consulting. All rights reserved.
//

#import "GAFormViewController.h"
#import "GAAppDelegate.h"

@interface GAFormViewController()

- (void)doneButtonPressed:(id)sender;

@end

@implementation GAFormViewController

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
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"GABackgroundNoise"]];
    
    // BEGIN: SETUP FOR NAVIGATION BAR
    // ---------------------------------------------------------------------------------
    
    [[UINavigationBar appearance] setTitleTextAttributes:
     [NSDictionary dictionaryWithObjectsAndKeys:
      [UIColor whiteColor], UITextAttributeTextColor,
      [UIColor blackColor], UITextAttributeTextShadowColor,
      [NSValue valueWithUIOffset:UIOffsetMake(0, -1)], UITextAttributeTextShadowOffset,
      nil
      ]
     ];
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] init];
    [self.view addSubview:navigationBar];
    navigationBar.frame = CGRectMake(0, 0, 540, 44);
    
    navigationItem = [[UINavigationItem alloc] init];
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"GAGreenNavigationBar"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *backButton = [GAAppDelegate texturedButtonWithTitle:@"Done"];
    [backButton addTarget:self action:@selector(doneButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backButton];
    navigationItem.rightBarButtonItem = backBarButtonItem;
    
    
    // END: SETUP FOR NAVIGATION BAR
    // ---------------------------------------------------------------------------------
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
	return YES;
}

- (void)doneButtonPressed:(id)sender 
{
    NSLog(@"%@", NSStringFromCGRect(self.view.frame));
	[self dismissModalViewControllerAnimated:YES];
}


@end
