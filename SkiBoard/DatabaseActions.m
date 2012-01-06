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

static sqlite3 *database = nil;
static sqlite3_stmt *deleteStmt = nil;
static sqlite3_stmt *addStmt = nil;


@implementation DatabaseActions


-(id) initDataBase{
    [super init];
    //Database
	databaseName = @"skiboard.sqlite";
	
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
    [self checkAndCreateDatabase];
    if (sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) NSLog(@"open");
    else NSLog(@"error! base not open");
    
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
   	if(addStmt == nil) {
        
		const char *sql = "INSERT INTO skiboard(id, name, time, speed, alt, lat, lon) VALUES(?, ?, ?, ?, ?, ?, ?)";
		if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
            
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
	
    sqlite3_bind_int(addStmt, 1, userID);
    sqlite3_bind_text(addStmt, 2, [userName UTF8String], -1, SQLITE_TRANSIENT);
	//sqlite3_bind_text(addStmt, 1, [coffeeName UTF8String], -1, SQLITE_TRANSIENT);
	//sqlite3_bind_double(addStmt, 2, [price doubleValue]);
    //sqlite3_bind_double(statement, index, [dateObject timeIntervalSince1970]);
    sqlite3_bind_double(addStmt, 3, [time timeIntervalSince1970]);
    sqlite3_bind_double(addStmt, 4, speed);
    sqlite3_bind_double(addStmt, 5, altitude);
    sqlite3_bind_double(addStmt, 6, latitude);
    sqlite3_bind_double(addStmt, 7, longitude);
    
	if(SQLITE_DONE != sqlite3_step(addStmt))
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	else {
		//SQLite provides a method to get the last primary key inserted by using sqlite3_last_insert_rowid
		pk = sqlite3_last_insert_rowid(database);
        NSLog(@"%i",pk);
        NSLog(@"add record!");
	}
	//Reset the add statement.
	sqlite3_reset(addStmt); 
    
    NSLog(@"test"); 
           
}

+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
	if(deleteStmt) sqlite3_finalize(deleteStmt);
	if(addStmt) sqlite3_finalize(addStmt);
}


@end
