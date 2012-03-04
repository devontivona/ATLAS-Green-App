//
//  GAWelcomeViewController.m
//  ATLAS Green App
//
//  Created by Devon Tivona on 3/3/12.
//  Copyright (c) 2012 mousebird consulting. All rights reserved.
//

#import "GAWelcomeViewController.h"

@interface GAWelcomeViewController ()

@end

@implementation GAWelcomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    navigationItem.title = @"Welcome";

    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
	return YES;
}

@end
