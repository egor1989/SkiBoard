//
//  AppDelegate.h
//  SkiBoard
//
//  Created by Елена on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <CoreMotion/CoreMotion.h>
#import <sqlite3.h> 
#import "DatabaseActions.h"

#define accelUpdateFrequency 60.0	
#define locWarningTime 20.0

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>{
    bool motionState;
    bool gpsState;
    CMMotionManager *motionManager;
    CLLocationManager *locationManager;
    CLLocation *lastLoc;
    NSTimer *locTimer;
    
    DatabaseActions *databaseActions;
    
    

}


- (CLLocation *)getLastLocation;
- (void)startMotionDetect;
- (void)stopMotionDetect;
- (void)startGPSDetect;
- (void)stopGPSDetect;
- (bool)getGPSState;
- (bool)getMotionState;
- (NSArray*) readDatabase;

@property (strong, nonatomic) UIWindow *window;

@end
