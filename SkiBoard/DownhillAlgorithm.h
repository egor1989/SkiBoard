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
    
    

}

- (NSInteger) isUphill: (double) tmpAltitude;
- (NSInteger) isDownhill: (double) tmpAltitude;

@end
