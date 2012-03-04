//
//  SpriteHelpers.m
//  SpaceBubble
//
//  Created by Nicholas Vellios on 5/13/10.
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

#import "SpriteHelpers.h"

@implementation SpriteHelpers

// This returns an animated 'Sprite' with the given set of images, duration, and assigns an optional integer value to the sprite for later use
// To create an animated sprite from a series of png images, just name the frames something like frm1.png frm2.png frm3.png frm4.png and pass
// 'frm' as the prefix, 'png' as the extension, and '4' for the number of frames.  A Sprite will be returned with the following frames:
// frm1 frm2 frm3 frm4 frm3 frm2 and it will be looping infinitely.  'sender' is the view to add the sprite to.

+ (Sprite *)setupAnimatedSprite:(id)sender numFrames:(NSInteger)frames withFilePrefix:(NSString *)filePrefix withDuration:(CGFloat)duration ofType:(NSString *)ext withValue:(NSInteger)val {
	// Create an array for for holding the frames of the animation
	NSMutableArray *spriteArray = [[NSMutableArray alloc] initWithCapacity:0];
	
	// Loop through the number of frames and add them to the spriteArray
	for(int i = 1; i < frames + 1; i++) {
		// Create a string with the path to the image
		// NSString *spritePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%d", filePrefix, i] ofType:ext];
		// Create a new UIImage with the image located at spritePath
		
// ***** Had to change initWithContentsOfFile to imageNamed to support High Resolution Images on the iPhone 4 **** //
		UIImage *sprite = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.%@", filePrefix, i, ext]];
		// UIImage *sprite = [[UIImage alloc] initWithContentsOfFile: spritePath];
		// Add UIImage to our spriteArray
		[spriteArray addObject:sprite];
		// Clean up
		//[sprite release];
	}
	
	// Just like above but instead loop back down and add the images in reverse except drop the first and last frames
	for(int i = frames - 1; i > 1; i--) {
		// NSString *spritePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"%@%d", filePrefix, i] ofType:ext];
		
// ***** Had to change initWithContentsOfFile to imageNamed to support High Resolution Images on the iPhone 4 **** //
		UIImage *sprite = [UIImage imageNamed:[NSString stringWithFormat:@"%@%d.%@", filePrefix, i, ext]];
		//UIImage *sprite = [[UIImage alloc] initWithContentsOfFile: spritePath];
		
		[spriteArray addObject:sprite];
		//[sprite release];
	}
	
	// Create a new Sprite and init with the first image of our spriteArray (doesn't matter what image)
	Sprite *spriteViewTemp = [[Sprite alloc] initWithImage:[spriteArray objectAtIndex:0]];
	
	// This nullifies what image we added above and instead sets up an animated Sprite with the contents of our spriteArray
	[spriteViewTemp setAnimationImages:spriteArray];
	// Set the duration, or animation speed of our Sprite
	[spriteViewTemp setAnimationDuration:duration];
	// Without this, the animation would be stuck on frame1
	[spriteViewTemp startAnimating];
	
	Sprite *tempImageView = spriteViewTemp;
	
	// Set the position of our Sprite
	spriteViewTemp.center = CGPointMake((arc4random()%(NSUInteger)(320 - tempImageView.image.size.width)) + (tempImageView.image.size.width / 2), -tempImageView.image.size.height);
	spriteViewTemp.userInteractionEnabled = YES;
	// Add the Sprite to the view sent in 'sender'
	[sender addSubview:spriteViewTemp];
	
	// Clean up

	// Set the integer value of the Sprite (this is optional, depends if your app needs it)
	[tempImageView setIValue:val];
	
	// Finally, return the new animated Sprite
	return tempImageView;
}

@end