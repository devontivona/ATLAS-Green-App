//
//  UIView+Screenshot.m
//  Erudio
//
//  created by Eric Horacek & Devon Tivona on 11/6/11.
//  Copyright (c) 2011 University of Colorado Boulder. All rights reserved.
//

#import "UIView+Screenshot.h"
#import <QuartzCore/QuartzCore.h>

@implementation UIView (Screenshot)

- (UIImage *)screenshot
{
    UIGraphicsBeginImageContextWithOptions(self.frame.size, NO, 0.0);
	[self.layer renderInContext:UIGraphicsGetCurrentContext()];
	UIImage *returnImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
    
    return returnImage;
}

@end
