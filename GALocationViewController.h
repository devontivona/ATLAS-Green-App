//
//  GALocationViewController.h
//  ATLAS Green App
//
//  Created by Devon Tivona on 2/19/12.
//  Copyright (c) 2012 mousebird consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAFormViewController.h"

@class GALocation;

@interface GALocationViewController : GAFormViewController

@property(strong, nonatomic) GALocation *location;

@end
