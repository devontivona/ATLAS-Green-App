//
//  GABadgesViewController.h
//  ATLAS Green App
//
//  Created by Devon Tivona on 2/6/12.
//  Copyright (c) 2012 mousebird consulting. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GAFormViewController.h"
#import <SSToolkit/SSCollectionView.h>

@interface GABadgesViewController : GAFormViewController <SSCollectionViewDelegate, SSCollectionViewDataSource>

@property (strong, nonatomic) SSCollectionView *collectionView;

@end
