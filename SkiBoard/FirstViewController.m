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
    
  /*  [[NSNotificationCenter defaultCenter]	
     addObserver: self
     selector: @selector(showStat)
     name: @"locateNotification"
     object: nil]; */
    
    [[NSNotificationCenter defaultCenter]	
     addObserver: self
     selector: @selector(showStat)
     name: @"addCountLines"
     object: nil];
     databaseAction = [[DatabaseActions alloc] initDataBase];
    
    countLines = 0; 
    [self showTmp];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)accelerometer{
    
}

- (void)showStat{
    NSLog(@"showStat"); 
    countLines++;
    lines.text=[NSString stringWithFormat:@"%i", countLines];
  //  userLocation = [myAppDelegate getLastLocation];
  //  avSpeed.text = [NSString stringWithFormat:@"%.2f", [userLocation speed]];
       
    
}

- (IBAction) addRecord{
    
    [databaseAction addRecord];
    
}

- (IBAction) clearDataBase{
    [databaseAction clearDatabase];
}

- (IBAction) takeMax{
    avAlt.text = [NSString stringWithFormat:@"%.1f", [databaseAction takeAvgAlt]];
    maxAlt.text = [NSString stringWithFormat:@"%.1f",[databaseAction takeMaxAlt]];
    maxSpeed.text = [NSString stringWithFormat:@"%.1f",[databaseAction takeMaxSpeed]];
    avSpeed.text = [NSString stringWithFormat:@"%.1f",[databaseAction takeAvgSpeed]];
}

- (IBAction) startTracking{
    NSString *title = trackButton.titleLabel.text;
    NSLog(@"title= %@", title);
    if ([title isEqualToString:@"Stop"]){
        NSLog(@"%@", trackButton.titleLabel.text);
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:NO forKey:@"tracking"];
        [myAppDelegate stopGPSDetect];
        
        [trackButton setTitle:@"Start" forState:UIControlStateNormal];
    }
    else {
        NSLog(@"%@", trackButton.titleLabel.text);
        NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
        [userDefaults setBool:YES forKey:@"tracking"];
        [myAppDelegate startGPSDetect];
        
        [trackButton setTitle:@"Stop" forState:UIControlStateNormal];
    }
    
    NSLog(@"change");
}

- (void) showTmp{
    lines.text=[NSString stringWithFormat:@"%i", countLines];
    avAlt.text = [NSString stringWithFormat:@"%.1f", [databaseAction takeAvgAlt]];
    maxAlt.text = [NSString stringWithFormat:@"%.1f",[databaseAction takeMaxAlt]];
    maxSpeed.text = [NSString stringWithFormat:@"%.1f",[databaseAction takeMaxSpeed]];
    avSpeed.text = [NSString stringWithFormat:@"%.1f",[databaseAction takeAvgSpeed]];
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
    [super dealloc];
    
    [[NSNotificationCenter defaultCenter]	
     removeObserver: self
     name:  @"accelNotification"
     object: nil];
}
@end
