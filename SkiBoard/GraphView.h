/*
     File: GraphView.h

 
 Copyright (C) 2010 Apple Inc. All Rights Reserved.
 
*/

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@class GraphViewSegment;
@class GraphTextView;
@interface GraphView : UIView
{
    
	NSMutableArray *segments;
	GraphViewSegment *current; // weak reference
	GraphTextView *text; // weak reference
}


-(void)addX:(UIAccelerationValue)x y:(UIAccelerationValue)y z:(UIAccelerationValue)z;

@end
