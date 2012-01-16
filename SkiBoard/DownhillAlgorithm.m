//
//  DownhillAlgorithm.m
//  SkiBoard
//
//  Created by Елена on 14.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "DownhillAlgorithm.h"

@implementation DownhillAlgorithm
@synthesize resTime;

#define NEWDOWNHILL 10
#define BORDER 3

-(id) init{
    [super init];
    countDown=0;
    countUp=0;
    countLines=0;
    return self;
    timerRun=NO;
    rSec=0, rMin=0, rSec=0;
    resTime = @"0:0:0";
}


- (void) timer: (NSString *)action{
    
    if ([action isEqualToString:@"start"]){
    NSDate *startTime = [NSDate date];
    sTime = startTime.timeIntervalSince1970;
    }
    
    if ([action isEqualToString:@"stop"]) {
        NSDate *endTime = [NSDate date];
        double eTime = endTime.timeIntervalSince1970;
        
        double res = eTime-sTime;
        
        NSLog(@"%f - %f = %f", sTime, eTime, res);
        [self convertTime:res];
    }
}

- (void) convertTime: (double) result{
    NSLog(@"res=%f",result);
    NSInteger sec=0, min=0, hour=0;
    sec = (int) round(result);
    if (sec/3600>0) {
        hour = (int) sec/3600;
        sec = sec - hour*3600;
    }
    if (sec/60>0) {
        min = (int) sec/60;
        sec = sec - min*60;
    }
    NSLog(@"%ih:%im:%is",hour,min,sec);
    [self resultTime:hour min:min sec:sec];
}

- (void) resultTime: (NSInteger) hour min:(NSInteger) min sec:(NSInteger) sec{
    rSec+=sec;
    if (rSec>60) {
        rSec-=60; 
        rMin++;
    }
    rMin+=min;
    if (rMin>60) {
        rMin-=60;
        rHour++;
    }
    rHour+=hour;
    
    NSLog(@"%ih:%im:%is",rHour,rMin,rSec);
    resTime = [NSString stringWithFormat:@"%ih:%im:%is",rHour,rMin,rSec]; 
    
}




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
        timerRun = YES;
        [self timer:@"start"];
        
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
        
        if (timerRun) [self timer:@"stop"]; 
        
        NSLog(@"!!!Uphill!!!");
    }
    
    lastAlt = tmpAltitude;
    NSLog(@"COUNTUP=%i",countUp);
    return countUp; 
}



@end
