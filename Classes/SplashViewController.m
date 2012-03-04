//
//  SplashViewController.m
//  SpaceBubble
//
//  Created by Nicholas Vellios on 5/16/10.
//  Copyright 2010 Nick Vellios. All rights reserved.
//
//	http://www.Vellios.com
//	nick@vellios.com
//
//	This code is released under the "Take a kid fishing or hunting license"
//	In order to use any code in your project you must take a kid fishing or
//	hunting and give some sort of credit to the author of the code either
//	on your product's website, about box, or legal agreement.
//

#import "SplashViewController.h"
#import "SpaceBubbleViewController.h"

@implementation SplashViewController

@synthesize myCreator;


 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Custom initialization
    }
    return self;
}


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

-(IBAction)buttonClicked:(id)sender {
	settingsWindow = [[SettingsWindow alloc] initWithNibName:@"SettingsWindow" bundle:nil];
	[settingsWindow setMyCreator:myCreator];
	settingsWindow.view.frame = CGRectOffset(settingsWindow.view.frame, 0, -settingsWindow.view.frame.size.height);
	[UIView beginAnimations:@"animateSettingsWindowOn"  context:NULL]; // Begin animation
	settingsWindow.view.frame = CGRectOffset(settingsWindow.view.frame, 0, settingsWindow.view.frame.size.height);
	[self.view addSubview:settingsWindow.view];
	[UIView commitAnimations]; // End animations	
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	[self dismiss];
}

- (void)dismiss {
	SpaceBubbleViewController *controller = myCreator;
	controller.gamePaused = NO;
	
	[self.view removeFromSuperview];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


@end
