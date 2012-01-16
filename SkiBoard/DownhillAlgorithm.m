//
//  DownhillAlgorithm.m
//  SkiBoard
//
//  Created by Елена on 14.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DownhillAlgorithm.h"

@implementation DownhillAlgorithm

#define NEWDOWNHILL 10
#define BORDER 3

-(id) init{
    [super init];
    countDown=0;
    countUp=0;
    countLines=0;
    return self;
    timerRun=NO;
}


- (void) timer: (NSString *)action{
    
    if ([action isEqualToString:@"start"]){
    NSDate *startTime = [NSDate dateWithTimeIntervalSinceNow:0];
    sTime = startTime.timeIntervalSinceNow;
       // NSLog(@"%f",sTime);
    }
    if ([action isEqualToString:@"stop"]) {
        NSDate *endTime = [NSDate dateWithTimeIntervalSinceNow:0];
        double eTime = endTime.timeIntervalSinceNow;
        
        double res = eTime-sTime;
        NSLog(@"%f - %f = %f", sTime, eTime, res);
    }
    
    
}


/*
 - (void) timer: (NSString *)action{
 	
     userLocation = [myAppDelegate getLastLocation];
 	
     double result;
 	
     if ([action isEqualToString:@"start"]) {
 	
         startTime = [userLocation.timestamp timeIntervalSince1970];
 	
         NSLog(@"start-time = %.5f", startTime);
 	
 
 	
    }
 	
     if ([action isEqualToString:@"end"]) {
	
          NSLog(@"tmp-time = %.5f", [userLocation.timestamp timeIntervalSince1970]);
 	
         result = [userLocation.timestamp timeIntervalSince1970] - startTime;
 	
         NSLog(@"time = %.5f", result);
 	
    }
}
 */

- (NSInteger) isDownhill: (double) tmpAltitude{
    
    NSLog(@"altitude = %.2f", tmpAltitude);
    
    if (countDown == 0) {
        lastAlt = tmpAltitude;
        countDown++;
    }
    else if (lastAlt > tmpAltitude) {
        NSLog(@"%.2f > %.2f", lastAlt, tmpAltitude);    
        countDown++;
    }
   // else countDown=1;
    
    
    if(countDown>BORDER) {
        
        NSLog(@"!!!Downhill!!!");
    }
    NSLog(@"COUNTDOWN=%i",countDown);
    lastAlt = tmpAltitude;
    return countDown;
}


- (NSInteger) isUphill: (double) tmpAltitude{
    
    NSLog(@"altitude = %.2f", tmpAltitude);
    
    if (countUp == 0) {
        lastAlt = tmpAltitude;
        countUp++;
    }
    
    
    else if (lastAlt<tmpAltitude) {
        NSLog(@"%.2f < %.2f", lastAlt, tmpAltitude); 
        countUp++;
    }
    //else countUp = 1;
    
    if(countUp>BORDER) {
        
        
        NSLog(@"!!!Uphill!!!");
    }
    
    lastAlt = tmpAltitude;
    NSLog(@"COUNTUP=%i",countUp);
    return countUp; 
}



@end
