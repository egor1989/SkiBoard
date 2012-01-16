//
//  DownhillAlgorithm.h
//  SkiBoard
//
//  Created by Елена on 14.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DownhillAlgorithm : NSObject{
    NSInteger countDown;
    NSInteger countUp;
    NSInteger countLines;
    double lastAlt;
    
    //timer
    BOOL timerRun;
    double sTime;
    NSInteger rSec, rMin, rHour;
    NSString *resTime;
    
    
}

- (NSInteger) isUphill: (double)tmpAltitude;
- (NSInteger) isDownhill: (double)tmpAltitude;
- (void)timer: (NSString *)action;
- (void)convertTime: (double)result;
- (void)resultTime: (NSInteger)hour min:(NSInteger)min sec:(NSInteger)sec;

@property (nonatomic, retain) NSString *resTime;

@end
