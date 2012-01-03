//
//  FirstViewController.h
//  SkiBoard
//
//  Created by Елена on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "AppDelegate.h"


@interface FirstViewController : UIViewController{
    
    IBOutlet UILabel *alt;
    IBOutlet UILabel *lon;
    IBOutlet UILabel *lat;
    IBOutlet UILabel *maxSpeed;
    CLLocation *userLocation;
    
    IBOutlet UILabel *avSpeed;
    
    IBOutlet UILabel *distance;
    
    IBOutlet UIView *graphView;
}
- (void)accelerometer;
- (void)showGPS;
    



@end
