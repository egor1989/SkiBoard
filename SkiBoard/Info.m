//
//  Info.m
//  SkiBoard
//
//  Created by Mike on 06.01.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "Info.h"

@implementation Info

- (id)initWithUserID:(int)userIDTemp UserName:(NSString*)userNameTemp Time:(double)timeTemp Speed:(double)speedTemp Longitude:(double)longitudeTemp Latitude:(double)latitudeTemp Altitude:(double)altitudeTemp{
    self = [super init];
    userID = userIDTemp;
    userName = userNameTemp;
    time = timeTemp;
    speed = speedTemp;
    longitude = longitudeTemp;
    latitude = latitudeTemp;
    altitude = altitudeTemp;
    return self;
}

-(double) getSpeed{
    return speed;
}

-(double) getTime{
    return time;
}

@end
