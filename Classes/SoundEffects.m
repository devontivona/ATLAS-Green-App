//
//  SoundEffects.m
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

#import "SoundEffects.h"

static struct SoundEffect soundEffectTable[] = {
	{ Sound_AxeThrow,		  "axe_throw",		0 },
	{ Sound_Laser,			  "laser_1",		0 },
	{ Sound_Click,		      "click",		    0 },
	{ Sound_Mechanical,		  "mechanical_1",	0 },
	{ Sound_Hit,		      "hit_2",		    0 },
	{ Sound_Alien,			  "alien2",			0 }
};

static SoundEffects* g_instance;

void InitializeSoundEffects()
{
	[SoundEffects sharedInstance];
}

void PlaySoundEffect(GameSoundEffects soundID)
{
	[[SoundEffects sharedInstance] playSoundEffect:soundID];
}

@implementation SoundEffects 

+ (SoundEffects*)sharedInstance {
	if (g_instance == nil) {
		g_instance = [SoundEffects new];
		[g_instance initializeSoundEffects];
	}
	return g_instance;
}

void AudioInterruptionListener(void *inClientData, UInt32 inInterruptionState) {
}

- (BOOL)createSoundWithName:(NSString*)name idPtr:(SystemSoundID*)idPtr {
	NSString* path = [[NSBundle mainBundle] pathForResource:name ofType:@"wav"];

	NSURL* url = [NSURL fileURLWithPath:path];
	OSStatus status = AudioServicesCreateSystemSoundID((__bridge_retained CFURLRef)url, idPtr);
	return (status == 0);
}

- (void)initializeSoundEffects {
	
	for (unsigned int i = 0; i < sizeof(soundEffectTable)/sizeof(struct SoundEffect); i++) {
		NSString* soundName = [NSString stringWithUTF8String:soundEffectTable[i].soundResourceName];
		[self createSoundWithName:soundName idPtr:&soundEffectTable[i].systemSoundID];
	}
}

- (void)playSoundEffect:(GameSoundEffects)soundID {
	if (soundID >= 0 && soundID < Sound_COUNT) {
		AudioServicesPlaySystemSound(soundEffectTable[soundID].systemSoundID);
	}
}


@end
