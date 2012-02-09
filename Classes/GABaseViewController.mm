/*
 *  GABaseViewController.m
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
#import "GABaseViewController.h"
#import "PanDelegate.h"
#import "GAAppDelegate.h"

#import "GABadgesViewController.h"
#import "GADeparturesViewController.h"
#import "GAStatisticsViewController.h"

using namespace WhirlyGlobe;

@interface GABaseViewController()

@property (nonatomic,strong) EAGLView *glView;
@property (nonatomic,strong) SceneRendererES1 *sceneRenderer;
@property (nonatomic,strong) WhirlyGlobePinchDelegate *pinchDelegate;
@property (nonatomic,strong) WhirlyGlobeSwipeDelegate *swipeDelegate;
@property (nonatomic,strong) WhirlyGlobeRotateDelegate *rotateDelegate;
@property (nonatomic,strong) PanDelegate *panDelegate;
@property (nonatomic,strong) WhirlyGlobeTapDelegate *tapDelegate;
@property (nonatomic,strong) WhirlyGlobeLongPressDelegate *pressDelegate;
@property (nonatomic,strong) WhirlyGlobeView *theView;
@property (nonatomic,strong) TextureGroup *texGroup;
@property (nonatomic,strong) WhirlyGlobeLayerThread *layerThread;
@property (nonatomic,strong) SphericalEarthLayer *earthLayer;
@property (nonatomic,strong) VectorLayer *vectorLayer;
@property (nonatomic,strong) LabelLayer *labelLayer;
@property (nonatomic,strong) GridLayer *gridLayer;
@property (nonatomic,strong) InteractionLayer *interactLayer;

- (void)showBadgesPopover:(id)sender;
- (void)showDeparturePopover:(id)sender;
- (void)showStatisticsPopover:(id)sender;

@end

@implementation GABaseViewController

@synthesize glView;
@synthesize sceneRenderer;
@synthesize pinchDelegate;
@synthesize swipeDelegate;
@synthesize rotateDelegate;
@synthesize panDelegate;
@synthesize tapDelegate;
@synthesize pressDelegate;
@synthesize theView;
@synthesize texGroup;
@synthesize layerThread;
@synthesize earthLayer;
@synthesize vectorLayer;
@synthesize labelLayer;
@synthesize gridLayer;
@synthesize interactLayer;

- (void)clear
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];

    if (self.layerThread)
    {
        [self.layerThread cancel];
        while (!self.layerThread.isFinished)
            [NSThread sleepForTimeInterval:0.001];
    }

    self.glView = nil;
    self.sceneRenderer = nil;
    self.pinchDelegate = nil;
    self.swipeDelegate = nil;
    self.rotateDelegate = nil;
    self.panDelegate = nil;
    self.tapDelegate = nil;
    self.pressDelegate = nil;
    
    if (theScene)
    {
        delete theScene;
        theScene = NULL;
    }
    self.theView = nil;
    self.texGroup = nil;
    
    self.layerThread = nil;
    self.earthLayer = nil;
    self.vectorLayer = nil;
    self.labelLayer = nil;
    self.gridLayer = nil;
    self.interactLayer = nil;
}

- (void)dealloc 
{
    [self clear];
    
}

// Get the structures together for a 
- (void)viewDidLoad 
{
    [super viewDidLoad];
    
    
    // BEGIN: SETUP FOR WHIRLYGLOBE
    // ---------------------------------------------------------------------------------
	
	// Set up an OpenGL ES view and renderer
	self.glView = [[EAGLView alloc] init];
	self.sceneRenderer = [[SceneRendererES1 alloc] init];
	glView.renderer = sceneRenderer;
	glView.frameInterval = 2;  // 60 fps
	[self.view addSubview:glView];
    self.view.backgroundColor = [UIColor blackColor];
    self.view.opaque = YES;
	self.view.autoresizesSubviews = YES;
//	glView.frame = self.view.bounds;
    glView.frame = CGRectMake(0, 44, 768, 916);
    glView.backgroundColor = [UIColor blackColor];
	
	// Create the textures and geometry, but in the right GL context
	[sceneRenderer useContext];
	
	// Set up a texture group for the world texture
	self.texGroup = [[TextureGroup alloc] initWithInfo:[[NSBundle mainBundle] pathForResource:@"big_wtb_info" ofType:@"plist"]];

	// Need an empty scene and view
	theScene = new WhirlyGlobe::GlobeScene(4*texGroup.numX,4*texGroup.numY);
	self.theView = [[WhirlyGlobeView alloc] init];
	
	// Need a layer thread to manage the layers
	self.layerThread = [[WhirlyGlobeLayerThread alloc] initWithScene:theScene];
	
	// Earth layer on the bottom
    NSString *globeCache = @"GlobeCache";
    if (RenderCacheExists(globeCache))
    {
        self.earthLayer = [[SphericalEarthLayer alloc] initWithTexGroup:texGroup cacheName:globeCache];
    } else {
        self.earthLayer = [[SphericalEarthLayer alloc] initWithTexGroup:texGroup cacheName:nil];
        [self.earthLayer saveToCacheName:globeCache];
    }
	[self.layerThread addLayer:earthLayer];
    
    // Toss up an optional grid layer
    if (UseGridLayer)
    {
        self.gridLayer = [[GridLayer alloc] initWithX:10 Y:5];
        [self.layerThread addLayer:gridLayer];
    }

	// Set up the vector layer where all our outlines will go
	self.vectorLayer = [[VectorLayer alloc] init];
	[self.layerThread addLayer:vectorLayer];

	// General purpose label layer.
	self.labelLayer = [[LabelLayer alloc] init];
	[self.layerThread addLayer:labelLayer];

	// The interaction layer will handle label and geometry creation when something is tapped
    // Data is divided by countries, oceans, and regions (e.g. states/provinces)
	self.interactLayer = [[InteractionLayer alloc] initWithVectorLayer:self.vectorLayer labelLayer:labelLayer globeView:self.theView
                                                           countryShape:[[NSBundle mainBundle] pathForResource:@"10m_admin_0_map_subunits" ofType:@"shp"]
                                                             oceanShape:[[NSBundle mainBundle] pathForResource:@"10m_geography_marine_polys" ofType:@"shp"]
                                                            regionShape:[[NSBundle mainBundle] pathForResource:@"10m_admin_1_states_provinces_shp" ofType:@"shp"]]; 
    self.interactLayer.maxEdgeLen = [self.earthLayer smallestTesselation]/10.0;
	[self.layerThread addLayer:interactLayer];
			
	// Give the renderer what it needs
	sceneRenderer.scene = theScene;
	sceneRenderer.view = theView;
	
	// Wire up the gesture recognizers
	self.pinchDelegate = [WhirlyGlobePinchDelegate pinchDelegateForView:glView globeView:theView];
//	self.swipeDelegate = [WhirlyGlobeSwipeDelegate swipeDelegateForView:glView globeView:theView];
	self.panDelegate = [PanDelegate panDelegateForView:glView globeView:theView];
	self.tapDelegate = [WhirlyGlobeTapDelegate tapDelegateForView:glView globeView:theView];
    self.pressDelegate = [WhirlyGlobeLongPressDelegate longPressDelegateForView:glView globeView:theView];
    self.rotateDelegate = [WhirlyGlobeRotateDelegate rotateDelegateForView:glView globeView:theView];
	
	// Kick off the layer thread
	// This will start loading things
	[self.layerThread start];
    
    // END: SETUP FOR WHIRLYGLOBE
    // ---------------------------------------------------------------------------------
    
    // BEGIN: SETUP FOR TOOLBAR
    // ---------------------------------------------------------------------------------
    
    UIToolbar *toolBar = [[UIToolbar alloc] init];
    [self.view addSubview:toolBar];
    toolBar.frame = CGRectMake(0, 960, 768, 44);
    [toolBar setBackgroundImage:[UIImage imageNamed:@"GAGreenToolbar"] forToolbarPosition:UIToolbarPositionAny barMetrics:UIBarMetricsDefault];
        
    UIButton *badgesButton = [[UIButton alloc] init];
    [badgesButton setBackgroundImage:[UIImage imageNamed:@"GAActionButton"] forState:UIControlStateNormal];
    [badgesButton addTarget:self action:@selector(showBadgesPopover:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:badgesButton];
    CGRect tempFrame = CGRectMake(0, 0, 120, 90);
    tempFrame.origin.y = self.view.frame.size.height - tempFrame.size.height;
    tempFrame.origin.x = self.view.frame.size.width/2 - tempFrame.size.width/2;
    badgesButton.frame = tempFrame;
    badgesButton.adjustsImageWhenHighlighted = NO;
    
    // END: SETUP FOR TOOLBAR
    // ---------------------------------------------------------------------------------

    // BEGIN: SETUP FOR NAVIGATION BAR
    // ---------------------------------------------------------------------------------
    
    [[UINavigationBar appearance] setTitleTextAttributes:
        [NSDictionary dictionaryWithObjectsAndKeys:
            [UIColor whiteColor], UITextAttributeTextColor,
            [UIColor blackColor], UITextAttributeTextShadowColor,
            [NSValue valueWithUIOffset:UIOffsetMake(0, -1)], UITextAttributeTextShadowOffset,
            nil
         ]
    ];
    
    UINavigationBar *navigationBar = [[UINavigationBar alloc] init];
    [self.view addSubview:navigationBar];
    navigationBar.frame = CGRectMake(0, 0, 768, 44);
    
    UINavigationItem *navigationItem = [[UINavigationItem alloc] init];
    navigationItem.title = @"Climate Explorer";
    [navigationBar pushNavigationItem:navigationItem animated:NO];
    [navigationBar setBackgroundImage:[UIImage imageNamed:@"GAGreenNavigationBar"] forBarMetrics:UIBarMetricsDefault];
    
    UIButton *departuresButton = [GAAppDelegate texturedButtonWithImage:[UIImage imageNamed:@"GADepartureIcon"]];
    [departuresButton addTarget:self action:@selector(showDeparturesPopover:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *departuresBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:departuresButton];
    navigationItem.rightBarButtonItem = departuresBarButtonItem;
    
    UIButton *statisticsButton = [GAAppDelegate texturedButtonWithImage:[UIImage imageNamed:@"GAStatisticsIcon"]];
    [statisticsButton addTarget:self action:@selector(showStatisticsPopover:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *statisticsBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:statisticsButton];
    navigationItem.leftBarButtonItem = statisticsBarButtonItem;
    

    // END: SETUP FOR NAVIGATION BAR
    // ---------------------------------------------------------------------------------
}

- (void)viewDidUnload
{	
	[self clear];
	
	[super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated
{
	[self.glView startAnimation];
	
	[super viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[self.glView stopAnimation];
	
	[super viewWillDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
    return true;
}

- (void)didReceiveMemoryWarning 
{
    [super didReceiveMemoryWarning];
}


#pragma mark - GABaseViewController Methods 

- (void)showBadgesPopover:(id)sender
{
    GABadgesViewController *badgesViewController = [[GABadgesViewController alloc] initWithNibName:@"GABadgesViewController" bundle:[NSBundle mainBundle]];
    badgesViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:badgesViewController animated:YES];
}

- (void)showDeparturesPopover:(id)sender
{
    GADeparturesViewController *departuresViewController = [[GADeparturesViewController alloc] initWithNibName:@"GADeparturesViewController" bundle:[NSBundle mainBundle]];
    departuresViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:departuresViewController animated:YES];
}

- (void)showStatisticsPopover:(id)sender
{
    GAStatisticsViewController *statisticsViewController = [[GAStatisticsViewController alloc] initWithNibName:@"GAStatisticsViewController" bundle:[NSBundle mainBundle]];
    statisticsViewController.modalPresentationStyle = UIModalPresentationFormSheet;
    [self presentModalViewController:statisticsViewController animated:YES];
}

@end
