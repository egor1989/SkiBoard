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
//for timer - delete later
#import "DownhillAlgorithm.h"



@interface FirstViewController : UIViewController{
    
    NSInteger userID;
    NSString *userName;
   
    double speed;
    double longitude;
    double latitude;
    double altitude;
    
    NSInteger countLines;
    
    
    NSDateComponents *dateComponents;
    NSInteger sHour;
    NSInteger sMinute;
    NSInteger sSecond;
    
    
    //
    BOOL aTimer;
    //DownhillAlgorithm *downhillAlgorithm;
    
    DatabaseActions *databaseAction;
    
    CLLocation *userLocation;
    
    IBOutlet UILabel *maxAlt;
    IBOutlet UILabel *avAlt;
    IBOutlet UILabel *maxSpeed;
    IBOutlet UILabel *avSpeed;
    IBOutlet UILabel *distance;
    IBOutlet UILabel *lines;
    IBOutlet UIView *graphView;
    IBOutlet UIButton *trackButton;
    IBOutlet UILabel *aTime;
    
    IBOutlet UILabel *alt;
    IBOutlet UILabel *record;
    IBOutlet UILabel *up;
    
}
- (void)accelerometer;
- (void)showStat;
- (IBAction) clearDataBase;
- (IBAction) addRecord;
- (IBAction) takeMax;
- (IBAction) startTracking;
- (IBAction) actionTimer; //for timer
- (void) showTmp;
- (void)addDownhill;
- (void) timer: (NSString *)action;

@property (nonatomic, retain) DownhillAlgorithm *downhillAlgorithm;
    



@end
