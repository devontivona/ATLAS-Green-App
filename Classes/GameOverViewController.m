//
//  GameOverViewController.m
//  SpaceBubble
//
//  Created by Nicholas Vellios on 5/13/10.
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

#import "GameOverViewController.h"
#import "SoundEffects.h"

@implementation GameOverViewController

@synthesize scoreLabel, highScore;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	//NSString *gameOverPath = [[NSBundle mainBundle] pathForResource:@"gameover" ofType:@"png"];
	//UIImage *gameOver = [[UIImage alloc] initWithContentsOfFile: gameOverPath];
	
// ***** Had to change initWithContentsOfFile to imageNamed to support High Resolution Images on the iPhone 4 **** //
	UIImage *gameOver = [UIImage imageNamed:@"gameover.png"];
	UIImageView *gameOverViewTemp = [[UIImageView alloc] initWithImage:gameOver];
	[self.view addSubview:gameOverViewTemp];
	
	gameOverText = [SpriteHelpers setupAnimatedSprite:self.view numFrames:3 withFilePrefix:@"gameovertext" withDuration:0.4 ofType:@"png" withValue:0];
	gameOverText.center = CGPointMake(160, 90);
	
	scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 200, 320, 70)];
	scoreLabel.text = [NSString stringWithFormat:@"%d points", highScore];
	[self.view addSubview:scoreLabel];
	scoreLabel.textColor = [UIColor whiteColor];
	scoreLabel.backgroundColor = [UIColor clearColor];
	scoreLabel.font = [UIFont boldSystemFontOfSize:42];
	scoreLabel.textAlignment = UITextAlignmentCenter;
	
	//[gameOver release];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
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
