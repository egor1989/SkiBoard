//
//  DatabaseActions.m
//  SkiBoard
//
//  Created by Елена on 05.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DatabaseActions.h"
#import "AppDelegate.h"
#define myAppDelegate (AppDelegate*) [[UIApplication sharedApplication] delegate]

@implementation DatabaseActions

-(id) initDataBase{
    [super init];
    //Database
	databaseName = @"skiboard.sqlite";
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    [self checkAndCreateDatabase];
    
    NSLog(@"download");
    return self;
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

-(void) addRecord{
    

           
    userLocation = [myAppDelegate getLastLocation];
    
    //visualize
    NSLog(@"SPEED = %@, ALTITUDE = %@, LONGITUDE = %@, LATITUDE = %@, TIME = %@,",[NSString stringWithFormat:@"%.2f", [userLocation speed]], [NSString stringWithFormat:@"%.3f", [userLocation altitude]], [NSString stringWithFormat:@"%.3f", userLocation.coordinate.latitude],[NSString stringWithFormat:@"%.3f", userLocation.coordinate.longitude], userLocation.timestamp);
    
    userID = 1;
    userName = @"test";
    time = [userLocation timestamp];
    speed = [[NSString stringWithFormat:@"%.2f", [userLocation speed]] doubleValue];
    longitude = [[NSString stringWithFormat:@"%.6f", userLocation.coordinate.longitude] doubleValue];
    latitude = [[NSString stringWithFormat:@"%.6f", userLocation.coordinate.latitude] doubleValue];
    altitude = [[NSString stringWithFormat:@"%.6f", [userLocation altitude]] doubleValue];
    
    NSLog(@"speed = %f", speed);
    
    //date to string
 /*   NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    
    time = [dateFormatter stringFromDate:[userLocation timestamp]];
    [dateFormatter release];
    
 */   

    
   
    
    NSLog(@"test"); 
           
}


@end
