//
//  GAStatisticsViewController.h
//  ATLAS Green App
//
//  Created by Devon Tivona on 2/6/12.
//  Copyright (c) 2012 mousebird consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAFormViewController.h"

@interface GAStatisticsViewController : GAFormViewController 

@property (nonatomic, retain) IBOutlet UILabel *typeOfTravelerLabel;
@property (weak, nonatomic) IBOutlet UILabel *coinCountLabel;
@property (weak, nonatomic) IBOutlet UILabel *countriesVisitedLabel;

@end


