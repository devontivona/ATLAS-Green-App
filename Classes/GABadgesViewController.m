//
//  GABadgesViewController.m
//  ATLAS Green App
//
//  Created by Devon Tivona on 2/6/12.
//  Copyright (c) 2012 mousebird consulting. All rights reserved.
//

#import "GABadgesViewController.h"
#import "GAAppDelegate.h"
#import <SSToolkit/SSCollectionView.h>
#import "SpaceBubbleViewController.h"

@implementation GABadgesViewController

@synthesize collectionView;

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
    navigationItem.title = @"Activities";
    
    collectionView = [[SSCollectionView alloc] init];
    collectionView.frame = CGRectMake(0.0, 44.0, self.view.frame.size.width, self.view.frame.size.height - 24.0);
    collectionView.delegate = self;
    collectionView.dataSource = self;
    collectionView.rowSpacing = 18;
    collectionView.minimumColumnSpacing = 18;
    collectionView.extremitiesStyle = SSCollectionViewExtremitiesStyleFixed;
    collectionView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:collectionView];
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

#pragma mark - SSCollectionViewDelegate

#pragma mark - SSCollectionViewDataSource

- (NSUInteger)collectionView:(SSCollectionView *)aCollectionView numberOfItemsInSection:(NSUInteger)section
{
    return 100;
}

- (SSCollectionViewItem *)collectionView:(SSCollectionView *)aCollectionView itemForIndexPath:(NSIndexPath *)indexPath
{
	static NSString *const itemIdentifier = @"itemIdentifier";
	
	SSCollectionViewItem *item = (SSCollectionViewItem *)[aCollectionView dequeueReusableItemWithIdentifier:itemIdentifier];
	if (item == nil) {
		item = [[SSCollectionViewItem alloc] initWithStyle:SSCollectionViewItemStyleImage reuseIdentifier:itemIdentifier];
	}
    
    [item.imageView setImage:[UIImage imageNamed:@"GABadge"]];

	return item;
}

- (CGSize)collectionView:(SSCollectionView *)aCollectionView itemSizeForSection:(NSUInteger)section {
    return CGSizeMake(100.0, 100.0);
}

- (CGFloat)collectionView:(SSCollectionView *)aCollectionView heightForHeaderInSection:(NSUInteger)section
{
    return 24.0;
}

- (CGFloat)collectionView:(SSCollectionView *)aCollectionView heightForFooterInSection:(NSUInteger)section
{
    return 18.0;
}

- (UIView *)collectionView:(SSCollectionView *)aCollectionView viewForHeaderInSection:(NSUInteger)section 
{
    return [[UIView alloc] init];
}

- (UIView *)collectionView:(SSCollectionView *)aCollectionView viewForFooterInSection:(NSUInteger)section 
{
    return [[UIView alloc] init];
}

- (void)collectionView:(SSCollectionView *)aCollectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SpaceBubbleViewController *gameViewController = [[SpaceBubbleViewController alloc] init];    
    gameViewController.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentModalViewController:gameViewController animated:YES];
}


@end
