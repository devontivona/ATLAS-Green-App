//
//  GADeparturesViewController.m
//  ATLAS Green App
//
//  Created by Devon Tivona on 2/6/12.
//  Copyright (c) 2012 mousebird consulting. All rights reserved.
//

#import "GADeparturesViewController.h"
#import "GABaseViewController.h"
#import "GALocation.h"
#import "InteractionLayer.h"

@implementation GADeparturesViewController

@synthesize tableView;

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
    navigationItem.title = @"Available Departures";
    tableView.backgroundColor = [UIColor clearColor];
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

#pragma mark - TableView Datasource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"SimpleTableIdentifier";
        
    UILabel *dayLabel, *monthLabel, *departuresLabel;
    UIImage *mechanicalboardImage = [UIImage imageNamed:@"mechanicalboard3.png"];
    UIImage *departuresButtonImage = [UIImage imageNamed:@"GADepartureIcon.png"];
    UIButton *departuresButton;
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    } 
    
    for (UIView *currentView in cell.subviews) {
        [currentView removeFromSuperview];
    }
    
    dayLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 0.0, 30.0, 21.0)];
    dayLabel.backgroundColor=[UIColor clearColor];
    dayLabel.font = [UIFont systemFontOfSize:30.0];
    dayLabel.textAlignment = UITextAlignmentCenter;
    dayLabel.textColor = [UIColor whiteColor];
    dayLabel.text = ((GALocation *)[self.baseViewController.locations objectAtIndex:indexPath.row]).name;
    [cell addSubview:dayLabel];
    
    monthLabel = [[UILabel alloc] initWithFrame:CGRectMake(5.0, 0.0, 40.0, 22.0)];
    monthLabel.backgroundColor=[UIColor clearColor];
    monthLabel.font = [UIFont systemFontOfSize:16.0];
    monthLabel.textAlignment = UITextAlignmentCenter;
    monthLabel.textColor = [UIColor whiteColor];
    monthLabel.text = ((GALocation *)[self.baseViewController.locations objectAtIndex:indexPath.row]).name;
    [cell addSubview:monthLabel];
    
    departuresLabel = [[UILabel alloc] initWithFrame:CGRectMake(100.0, 0.0, 442.0, 59.0)];
    departuresLabel.backgroundColor=[UIColor clearColor];
    departuresLabel.font = [UIFont systemFontOfSize:30.0];
    departuresLabel.textAlignment = UITextAlignmentLeft;
    departuresLabel.textColor = [UIColor whiteColor];
    departuresLabel.text = ((GALocation *)[self.baseViewController.locations objectAtIndex:indexPath.row]).name;
    
    [cell addSubview:departuresLabel];
    
    UIImageView *mechanicalboard = [[UIImageView alloc] initWithImage:mechanicalboardImage];
    mechanicalboard.frame = CGRectMake(0.0, 0.0, 540.0, 60.0);
    [cell addSubview:mechanicalboard];
    
    departuresButton = [[UIButton alloc]initWithFrame:CGRectMake(500.0, 0.0, 32, 27)];
    [departuresButton setBackgroundColor:[UIColor darkGrayColor]];
    
//    //listen for clicks
//    [departuresButton addTarget:self action:@selector(goToDestination:) 
//               forControlEvents:UIControlEventTouchUpInside];
    [departuresButton setBackgroundImage:departuresButtonImage forState:UIControlStateNormal];
    
    [cell addSubview:departuresButton];
    
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseViewController.locations.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60.0;
}

#pragma mark - TableView Delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [self.baseViewController.glView startAnimation];
    [self dismissModalViewControllerAnimated:YES];
    [self.baseViewController.interactLayer rotateToLocation:[self.baseViewController.locations objectAtIndex:indexPath.row]];
}

@end
