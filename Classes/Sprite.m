//
//  Sprite.m
//  SpaceBubble
//
//  Created by Nicholas Vellios on 5/16/10.
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

#import "Sprite.h"


@implementation Sprite

@synthesize iValue, uiValue, fValue;

- (id)initWithImage:(UIImage *)image {
    if ((self = [super initWithImage:image])) {
        // Initialization code
    }
    return self;
}

@end
