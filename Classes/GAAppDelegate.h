/*
 *  GAAppDelegate.h
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

#import <UIKit/UIKit.h>

@class GABaseViewController;

@interface GAAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    GABaseViewController *viewController;
}

@property (nonatomic, strong) IBOutlet UIWindow *window;
@property (nonatomic, strong) IBOutlet GABaseViewController *viewController;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

+ (UIButton *)texturedBackButtonWithTitle:(NSString*)title;
+ (UIButton *)texturedButtonWithTitle:(NSString*)title;
+ (UIButton *)texturedButtonWithImage:(UIImage*)image;
+ (UIButton *)texturedButton;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

+ (void)texturizeButton:(UIButton *)button;

@end

