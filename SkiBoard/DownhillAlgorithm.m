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
#define BORDER 2

-(id) init{
    [super init];
    countDown=0;
    countUp=0;
    countLines=0;
    return self;
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
    else countDown=1;
    
    
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
    else countUp = 1;
    
    if(countUp>BORDER) {
        
       
        NSLog(@"!!!Uphill!!!");
    }
    
    lastAlt = tmpAltitude;
    NSLog(@"COUNTUP=%i",countUp);
    return countUp; 
}



@end
