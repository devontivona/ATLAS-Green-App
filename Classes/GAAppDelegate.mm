/*
 *  GAAppDelegate.m
 *
 *  Created by Devon Tivona on 1/30/2012.
 *
 *  Derived from WhirlyGlobe by Stephen Gifford and Mousebird Consulting.
 *  Copyright 2011 mousebird consulting
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

#import "GAAppDelegate.h"
#import "GABaseViewController.h"
#import "UIImage+Darken.h"

@implementation GAAppDelegate

@synthesize window;
@synthesize viewController;


#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    [self.window addSubview:viewController.view];
    [self.window makeKeyAndVisible];
    
    return YES;
}


- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


#pragma mark - Toolbar Button Methods

+ (UIButton *)texturedBackButtonWithTitle:(NSString*)title {
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    button.titleLabel.shadowColor = [UIColor blackColor];
    button.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    button.contentMode = UIViewContentModeLeft;
    
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setTitle:title forState:UIControlStateNormal];
    button.contentEdgeInsets = UIEdgeInsetsMake(7.0, 12.0, 8.0, 7.0);
    [button sizeToFit];
    
    UIImage *backButtonImage = [[UIImage imageNamed:@"GANavigationButtonBack.png"]
                                stretchableImageWithLeftCapWidth:13.0 topCapHeight:2.0];
    [button setBackgroundImage:backButtonImage forState:UIControlStateNormal];
    
    UIImage *backButtonImagePressed = [[UIImage imageNamed:@"GANavigationButtonBackPressed.png"]
                                       stretchableImageWithLeftCapWidth:13.0 topCapHeight:2.0];
    [button setBackgroundImage:backButtonImagePressed forState:UIControlStateHighlighted];
    
    return button;
}

+ (UIButton *)texturedButtonWithTitle:(NSString*)title {

    UIButton* button = [self texturedButton];
    button.adjustsImageWhenHighlighted = NO;
    
    button.titleLabel.font = [UIFont boldSystemFontOfSize:12];
    button.titleLabel.shadowColor = [UIColor blackColor];
    button.titleLabel.shadowOffset = CGSizeMake(0.0, -1.0);
    button.contentMode = UIViewContentModeCenter;
    
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [button setTitle:title forState:UIControlStateNormal];
    button.contentEdgeInsets = UIEdgeInsetsMake(0.0, 9.0, 0.0, 9.0);
    [button sizeToFit];
    
    return button;
}

+ (UIButton *)texturedButtonWithImage:(UIImage*)image {
    
    UIButton* button = [self texturedButton];
    
    [button setImage:image forState:UIControlStateNormal];
    [button setImage:[image darkenedImageWithOverlayAlpha:0.3] forState:UIControlStateSelected];
    
    button.contentMode = UIViewContentModeCenter;
    button.contentEdgeInsets = UIEdgeInsetsMake(0.0, 9.0, 0.0, 9.0);
    [button sizeToFit];
    
    return button;
}

+ (UIButton *)texturedButton {
    
    UIButton* button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.adjustsImageWhenHighlighted = YES;
    [GAAppDelegate texturizeButton:button];
    return button;
}

+ (void)texturizeButton:(UIButton *)button
{
    UIImage *buttonImage;
    UIImage *buttonImagePressed;
    
    UIEdgeInsets buttonEdgeInsets = UIEdgeInsetsMake(0.0, 5.0, 0.0, 5.0);
    buttonImage = [[UIImage imageNamed:@"GANavigationButtonSquare.png"] resizableImageWithCapInsets:buttonEdgeInsets];
    buttonImagePressed = [[UIImage imageNamed:@"GANavigationButtonSquarePressed.png"] resizableImageWithCapInsets:buttonEdgeInsets];
    
    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImagePressed forState:UIControlStateSelected];
}

@end
