//
//  SpaceBubbleAppDelegate.m
//  SpaceBubble
//
//  Created by Nicholas Vellios on 5/11/10.
//  Copyright Nick Vellios 2010. All rights reserved.
//
//	http://www.Vellios.com
//	nick@vellios.com
//
//	This code is released under the "Take a kid fishing or hunting license"
//	In order to use any code in your project you must take a kid fishing or
//	hunting and give some sort of credit to the author of the code either
//	on your product's website, about box, or legal agreement.
//

#import "SpaceBubbleAppDelegate.h"
#import "SpaceBubbleViewController.h"
#import "SoundEffects.h"

@interface SpaceBubbleAppDelegate ()
- (NSString *)myFilePath:(NSString *)fileName;
@end

@implementation SpaceBubbleAppDelegate

@synthesize window;
@synthesize viewController;

+ (void)initialize {
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {  
	
	InitializeSoundEffects();

	// Prevent the screen from sleeping!  Important!!  (AngryBirds doesn't do this btw...annoying)
	[application setIdleTimerDisabled:YES];
	
	// Hide Status Bar and enter Full Screen
	[application setStatusBarHidden:YES animated:NO];

	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	NSString *filePath = [self myFilePath:@"HighScore.archive"];
	
	if([fileManager fileExistsAtPath:filePath]) {
		NSNumber *aNumber = [NSKeyedUnarchiver unarchiveObjectWithFile:[self myFilePath:@"HighScore.archive"]];
		viewController.highScore = [aNumber unsignedIntegerValue];
	}
	else {
		viewController.highScore = 0;
	}
	
	filePath = [self myFilePath:@"BackgroundMusic.archive"];

	if([fileManager fileExistsAtPath:filePath]) {
		NSNumber *aNumber = [NSKeyedUnarchiver unarchiveObjectWithFile:[self myFilePath:@"BackgroundMusic.archive"]];
		viewController.backgroundMusic = [aNumber boolValue];
	}
	else {
		viewController.backgroundMusic = YES;
	}

	filePath = [self myFilePath:@"SoundEffects.archive"];
	
	if([fileManager fileExistsAtPath:filePath]) {
		NSNumber *aNumber = [NSKeyedUnarchiver unarchiveObjectWithFile:[self myFilePath:@"SoundEffects.archive"]];
		viewController.soundEffects = [aNumber boolValue];
	}
	else {
		viewController.soundEffects = YES;
	}
	
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}

- (void)saveData {
	NSUInteger currentScore = viewController.highScore;
	NSNumber *countNumber = [NSNumber numberWithUnsignedInt:currentScore];
	
	[NSKeyedArchiver archiveRootObject:countNumber toFile:[self myFilePath:@"HighScore.archive"]];
	
	countNumber = [NSNumber numberWithBool:viewController.backgroundMusic];
	[NSKeyedArchiver archiveRootObject:countNumber toFile:[self myFilePath:@"BackgroundMusic.archive"]];
	
	countNumber = [NSNumber numberWithBool:viewController.soundEffects];
	[NSKeyedArchiver archiveRootObject:countNumber toFile:[self myFilePath:@"SoundEffects.archive"]];
}

// ***** Still need this to support iPhone OS 3 but is never actually called on iOS 4 **** //
- (void)applicationWillTerminate:(UIApplication *)application {
	[self saveData];
}

// ***** Had to add this to support multitasking in iOS 4 **** //
- (void)applicationDidEnterBackground:(UIApplication *)application {
	[self saveData];

}

- (NSString *)myFilePath:(NSString *)fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	return [documentsDirectory stringByAppendingPathComponent:fileName];
}


@end
