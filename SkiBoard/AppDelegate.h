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
#import "DownhillAlgorithm.h"

#define accelUpdateFrequency 60.0	
#define locWarningTime 20.0

@interface AppDelegate : UIResponder <UIApplicationDelegate, CLLocationManagerDelegate>{
    bool motionState;
    bool gpsState;
    CMMotionManager *motionManager;
    CLLocationManager *locationManager;
    CLLocation *lastLoc;
    BOOL tracking;
    BOOL downhill;

    NSUserDefaults *userDefaults;
    NSInteger countDown;
    NSInteger countUp;
    NSInteger countLines;
    double altForView;
    
    
    DownhillAlgorithm *downhillAlgorithm;
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
@property (nonatomic) NSInteger countDown;
@property (nonatomic) double altForView;
@property (nonatomic) NSInteger countUp;



@end
