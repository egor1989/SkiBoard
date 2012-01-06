//
//  FirstViewController.h
//  SkiBoard
//
//  Created by Елена on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "DatabaseActions.h"



@interface FirstViewController : UIViewController{
    
    NSInteger userID;
    NSString *userName;
    NSData *time;
    double speed;
    double longitude;
    double latitude;
    double altitude;
    
    IBOutlet UILabel *alt;
    IBOutlet UILabel *lon;
    IBOutlet UILabel *lat;
    IBOutlet UILabel *maxSpeed;
    DatabaseActions *databaseAction;
    
    CLLocation *userLocation;
    
    IBOutlet UILabel *avSpeed;
    IBOutlet UILabel *distance;
    IBOutlet UIView *graphView;
}
- (void)accelerometer;
- (void)showGPS;
- (IBAction) clearDataBase;
- (IBAction) addRecord;
- (IBAction) takeMax;


    



@end
