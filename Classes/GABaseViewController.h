/*
 *  GABaseViewController.h
 *
 *  Created by Devon Tivona on 1/30/2012.
 *
 *  Derived from WhirlyGlobe by Stephen Gifford and Mousebird Consulting.
 *  Copyright 2011 mousebird consulting
 *
 *  Licensed under the Apache License, Version 2.0 (the "License");
 *  you may not use this file except in compliance with the License.
 *
 *  Unless required by applicable law or agreed to in writing, software
 *  distributed under the License is distributed on an "AS IS" BASIS,
 *  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 *  See the License for the specific language governing permissions and
 *  limitations under the License.
 *
 */

#import <UIKit/UIKit.h>
#import <WhirlyGlobe/WhirlyGlobe.h>
#import "InteractionLayer.h"
#import "PanDelegate.h"

// If set, we'll turn on a grid layer
static const bool UseGridLayer = true;

@interface GABaseViewController : UIViewController <InteractionLayerDelegate>
{
	EAGLView *glView;
	SceneRendererES1 *sceneRenderer;
	
	UILabel *fpsLabel;
	UILabel *drawLabel;

	// Various interaction delegates when this view controller is up
	WhirlyGlobePinchDelegate *pinchDelegate;
	WhirlyGlobeSwipeDelegate *swipeDelegate;
	PanDelegate *panDelegate;
	WhirlyGlobeTapDelegate *tapDelegate;
    WhirlyGlobeLongPressDelegate *pressDelegate;
    WhirlyGlobeRotateDelegate *rotateDelegate;

	// Scene, view, and associated data created when controller is up
	WhirlyGlobe::GlobeScene *theScene;
	WhirlyGlobeView *theView;
	TextureGroup *texGroup;
	
	// Thread used to control Whirly Globe layers
	WhirlyGlobeLayerThread *layerThread;
	
	// Data layers, readers, and loaders
	SphericalEarthLayer *earthLayer;
	VectorLayer *vectorLayer;
	LabelLayer *labelLayer;
    GridLayer *gridLayer;
	InteractionLayer *interactLayer;
    WGSelectionLayer *selectionLayer;
}

@end

