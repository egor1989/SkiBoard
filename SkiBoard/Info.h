//
//  Info.h
//  SkiBoard
//
//  Created by Mike on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Info : NSObject{
    int userID;
    NSString *userName;
    double time;
    double speed;
    double longitude;
    double latitude;
    double altitude;
}

- (id)initWithUserID:(int)userID 
        UserName:(NSString*)userName 
            Time:(double)time 
           Speed:(double)speed 
       Longitude:(double)longitude 
        Latitude:(double)latitude 
        Altitude:(double)altitude;

-(double) getSpeed;
-(double) getTime;


@end
