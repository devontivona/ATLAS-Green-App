//
//  SettingsWindow.m
//  SpaceBubble
//
//  Created by Nicholas Vellios on 5/14/10.
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

#import "SettingsWindow.h"
#import "SpaceBubbleViewController.h"

@implementation SettingsWindow

@synthesize myCreator;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	SpaceBubbleViewController *creatorController = myCreator;
	
	backgroundSwitch.on = creatorController.backgroundMusic;
	effectsSwitch.on = creatorController.soundEffects;
}

-(IBAction)onButtonClick:(id)sender {
	[UIView transitionWithView:self.view duration:0.2 options:UIViewAnimationOptionTransitionFlipFromLeft animations:^{
		self.view.frame = CGRectOffset(self.view.frame, 0, -self.view.frame.size.height);
	} completion:^(BOOL finished) {
		[self.view removeFromSuperview];
	}];
}

-(IBAction)onBackgroundSwitch:(id)sender {
	UISwitch *mySwitch = sender;
	BOOL state = mySwitch.on;
	SpaceBubbleViewController *creatorController = myCreator;
	
	creatorController.backgroundMusic = state;
	
	if(state) {
		[creatorController.player play];
	} else {
		[creatorController.player stop];
	}
}

-(IBAction)onEffectsSwitch:(id)sender {
	UISwitch *mySwitch = sender;
	BOOL state = mySwitch.on;
	SpaceBubbleViewController *creatorController = myCreator;

	creatorController.soundEffects = state;
	
	if(state) {
		// ON
	} else {
		// OFF
	}
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
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
