//
//  AppDelegate.m
//  SkiBoard
//
//  Created by Елена on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

@synthesize window = _window, countDown, altForView;

#define NEWDOWNHILL 10
#define BORDER 3

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setBool:NO forKey:@"tracking"];
    
    motionState=NO;
    motionManager = [[CMMotionManager alloc] init];
    motionManager.accelerometerUpdateInterval = 1.0 / accelUpdateFrequency;
    
    gpsState=NO;
    locationManager=[[CLLocationManager alloc] init];
    locationManager.delegate=self;
    locationManager.desiredAccuracy=kCLLocationAccuracyNearestTenMeters;
    //[self startGPSDetect];
    
    lastLoc = [[CLLocation alloc] init];
   
    databaseActions = [[DatabaseActions alloc] initDataBase];
    countDown = 0;
    countUp = 0;
    
    
    downhillAlgorithm = [[DownhillAlgorithm alloc] init];
        
    // Override point for customization after application launch.
    return YES;
}


- (NSArray*) readDatabase{
    return [databaseActions readDatabase];
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
    

    [self startMotionDetect];
    
    tracking = [userDefaults boolForKey:@"tracking"];
    if (tracking) {
        NSLog(@"tracking init");
    }

    lastLoc = [[CLLocation alloc] initWithCoordinate:newLocation.coordinate altitude:newLocation.altitude horizontalAccuracy:newLocation.horizontalAccuracy verticalAccuracy:newLocation.verticalAccuracy course:newLocation.course speed:newLocation.speed timestamp:newLocation.timestamp];
    
    NSLog(@"countDown = %i, countUp = %i", countDown, countUp);
   
    if (countDown<=BORDER+1) {
       countDown=[downhillAlgorithm isDownhill:[[NSString stringWithFormat:@"%.2f", [lastLoc altitude]] doubleValue]]; 
        
    }
   
    if (countDown>BORDER) {
        countUp=[downhillAlgorithm isUphill:[[NSString stringWithFormat:@"%.2f", [lastLoc altitude]] doubleValue]];
        if (countUp>BORDER) countDown=0;
        
        
    }
    
    if (countDown>NEWDOWNHILL){
        [[NSNotificationCenter defaultCenter]	postNotificationName:	@"addCountLines" object:  nil];
    }
    
    if (countDown>=BORDER) {
        
        [databaseActions addRecord];
    }
    
    altForView = [[NSString stringWithFormat:@"%.2f", [lastLoc altitude]] doubleValue];

    
    [[NSNotificationCenter defaultCenter]	postNotificationName:	@"locateNotification" object:  nil];


    
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
    [DatabaseActions finalizeStatements];
    
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
