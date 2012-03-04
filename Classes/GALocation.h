//
//  GALocation.h
//  ATLAS Green App
//
//  Created by Devon Tivona on 2/28/12.
//  Copyright (c) 2012 mousebird consulting. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface GALocation : NSManagedObject

@property (nonatomic, retain) NSNumber * latitude;
@property (nonatomic, retain) NSNumber * longitude;
@property (nonatomic, retain) NSString * name;
@property (nonatomic, retain) NSString * videoTitle;
@property (nonatomic, retain) NSString * narrative;
@property (nonatomic, retain) NSString * subtitle;

@end
