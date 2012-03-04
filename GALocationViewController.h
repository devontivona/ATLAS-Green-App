//
//  GALocationViewController.h
//  ATLAS Green App
//
//  Created by Devon Tivona on 2/19/12.
//  Copyright (c) 2012 mousebird consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAFormViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@class GALocation;

@interface GALocationViewController : GAFormViewController {
    MPMoviePlayerController *moviePlayer;
}

@property(strong, nonatomic) GALocation *location;

@end
