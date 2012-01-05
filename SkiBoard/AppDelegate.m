//
//  AppDelegate.m
//  SkiBoard
//
//  Created by Елена on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    motionState=NO;
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 1.0 / accelUpdateFrequency;
    
    gpsState=NO;
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
    [self startGPSDetect];
    
    lastLoc = [[CLLocation alloc] init];
   
    //Database
	databaseName = @"skiboard.sqlite";
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    [self checkAndCreateDatabase];
    NSLog(@"download");
    // Override point for customization after application launch.
    return YES;
}

-(void) checkAndCreateDatabase{
	// Check if the SQL database has already been saved to the users phone, if not then copy it over
	BOOL success;
	
	// Create a FileManager object, we will use this to check the status
	// of the database and to copy it over if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
	
	// If the database already exists then return without doing anything
    if (success) {
        NSLog(@"success");
    }
	if(success) return;
	
	// If not then proceed to copy the database from the application to the users filesystem
	
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	
	[fileManager release];
}


-(bool)getMotionState{
    return motionState;
}

-(bool)getGPSState{
    return gpsState;
}

-(void)stopGPSDetect{
    [locationManager stopUpdatingLocation];
    gpsState=NO;
}

-(void)startGPSDetect{
    [locationManager startUpdatingLocation];
    gpsState=YES;
}

- (void)stopMotionDetect {
    [motionManager stopAccelerometerUpdates];
    motionState = NO;
}


- (void)startMotionDetect
{
    [motionManager startAccelerometerUpdatesToQueue:[[NSOperationQueue alloc] init]
                                        withHandler:^(CMAccelerometerData *data, NSError *error) {
                                            dispatch_async(dispatch_get_main_queue(), ^{
                                                NSDictionary* accDict = [NSDictionary dictionaryWithObject: data                                                                                                    forKey: @"accel"];
                                                [[NSNotificationCenter defaultCenter]	postNotificationName:	@"accelNotification" 
                                                                            object:  nil
                                                                            userInfo:accDict];
                                            });
                                        }
     ];
    motionState = YES;
}



- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    [[NSNotificationCenter defaultCenter]	postNotificationName:	@"locationWarningOFF" object:  nil];
    [self startMotionDetect];
    if ([locTimer isValid]){
        [locTimer invalidate];
        locTimer=nil;
    }
    lastLoc = [[CLLocation alloc] initWithCoordinate:newLocation.coordinate altitude:newLocation.altitude horizontalAccuracy:newLocation.horizontalAccuracy verticalAccuracy:newLocation.verticalAccuracy course:newLocation.course speed:newLocation.speed timestamp:newLocation.timestamp];
    [[NSNotificationCenter defaultCenter]	postNotificationName:	@"locateNotification" object:  nil];
  //  NSLog(@"loc not send");
    locTimer = [NSTimer scheduledTimerWithTimeInterval:locWarningTime
                                                target:self
                                              selector:@selector(warningButton)
                                              userInfo:nil
                                               repeats:YES];
}

-(void)warningButton{
    [[NSNotificationCenter defaultCenter]	postNotificationName:	@"locationWarning" object:  nil];
    [self stopMotionDetect];
}


- (CLLocation *)getLastLocation {
    return lastLoc;
}



							
- (void)applicationWillResignActive:(UIApplication *)application
{
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
