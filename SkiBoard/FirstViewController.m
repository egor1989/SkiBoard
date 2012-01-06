//
//  FirstViewController.m
//  SkiBoard
//
//  Created by Елена on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "FirstViewController.h"
#import "AppDelegate.h"
#define myAppDelegate (AppDelegate*) [[UIApplication sharedApplication] delegate]

@implementation FirstViewController



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter]	
     addObserver: self
     selector: @selector(accelerometer)
     name: @"accelNotification"
     object: nil];
    
    [[NSNotificationCenter defaultCenter]	
     addObserver: self
     selector: @selector(showGPS)
     name: @"locateNotification"
     object: nil];
     databaseAction = [[DatabaseActions alloc] initDataBase];
    
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)accelerometer{
    
}

- (void)showGPS{
    NSLog(@"showGPS");        
    userLocation = [myAppDelegate getLastLocation];
    avSpeed.text = [NSString stringWithFormat:@"%.2f", [userLocation speed]];
    alt.text = [NSString stringWithFormat:@"%.3f", [userLocation altitude]];
    lat.text = [NSString stringWithFormat:@"%.3f", userLocation.coordinate.latitude];
    lon.text = [NSString stringWithFormat:@"%.3f", userLocation.coordinate.longitude];
    
    
}

- (IBAction) addRecord{
    
    [databaseAction addRecord];
    
}

- (IBAction) clearDataBase{
    [databaseAction clearDatabase];
}

- (IBAction) takeMax{
    
    [databaseAction takeMax];
    [databaseAction takeAvg];
    
}

- (void)viewDidUnload
{
    NSLog(@"viewDidUnload");
    [maxSpeed release];
    maxSpeed = nil;
    [avSpeed release];
    avSpeed = nil;
    [distance release];
    distance = nil;
    [graphView release];
    graphView = nil;
    [lat release];
    lat = nil;
    [lon release];
    lon = nil;
    [alt release];
    alt = nil;
  
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)dealloc {
    [maxSpeed release];
    [maxSpeed release];
    [avSpeed release];
    [distance release];
    [graphView release];
    [lat release];
    [lon release];
    [alt release];
       [super dealloc];
    
    [[NSNotificationCenter defaultCenter]	
     removeObserver: self
     name:  @"accelNotification"
     object: nil];
}
@end
