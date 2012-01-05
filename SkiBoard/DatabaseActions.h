//
//  DatabaseActions.h
//  SkiBoard
//
//  Created by Елена on 05.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
//#import "AppDelegate.h"

@interface DatabaseActions : NSObject{
    // Database variables
	NSString *databaseName;
	NSString *databasePath;
    CLLocation *userLocation;
    
    //data for table
    NSInteger userID;
    NSString *userName;
    NSDate *time;
    double speed;
    double longitude;
    double latitude;
    double altitude;
    
}

-(id) initDataBase;
-(void) checkAndCreateDatabase;
-(void) addRecord;

@end
