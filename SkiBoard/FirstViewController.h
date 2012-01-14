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
    
    NSInteger countLines;
    
    double startTime;
    
    
    
    
    DatabaseActions *databaseAction;
    
    CLLocation *userLocation;
    
    IBOutlet UILabel *maxAlt;
    IBOutlet UILabel *avAlt;
    IBOutlet UILabel *maxSpeed;
    IBOutlet UILabel *avSpeed;
    IBOutlet UILabel *usefulTime;
    IBOutlet UILabel *distance;
    IBOutlet UILabel *lines;
    IBOutlet UIView *graphView;
    IBOutlet UIButton *trackButton;
    
    IBOutlet UILabel *alt;
    IBOutlet UILabel *record;
    
}
- (void)accelerometer;
- (void)showStat;
- (IBAction) clearDataBase;
- (IBAction) addRecord;
- (IBAction) takeMax;
- (IBAction) startTracking;
- (void) showTmp;
- (void)addDownhill;
- (void) timer: (NSString *)action;

    



@end
