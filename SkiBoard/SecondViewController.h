//
//  SecondViewController.h
//  SkiBoard
//
//  Created by Елена on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CorePlot-CocoaTouch.h"
#import "TUTSimpleScatterPlot.h"
#import "AppDelegate.h"

#define myAppDelegate (AppDelegate*) [[UIApplication sharedApplication] delegate]

@interface SecondViewController : UIViewController{
    IBOutlet CPTGraphHostingView *_graphHostingView;
    TUTSimpleScatterPlot *_scatterPlot;
}

@property (nonatomic, retain) TUTSimpleScatterPlot *scatterPlot;

@end