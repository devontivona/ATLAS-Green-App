//
//  GAFormViewController.h
//  ATLAS Green App
//
//  Created by Devon Tivona on 2/6/12.
//  Copyright (c) 2012 mousebird consulting. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GABaseViewController;

@interface GAFormViewController : UIViewController {
    UINavigationItem *navigationItem;
}

@property (weak, nonatomic) GABaseViewController *baseViewController;

@end
