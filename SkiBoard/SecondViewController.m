//
//  SecondViewController.m
//  SkiBoard
//
//  Created by Елена on 29.12.11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import "SecondViewController.h"

@implementation SecondViewController

@synthesize scatterPlot = _scatterPlot;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    NSMutableArray *data = [NSMutableArray array];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-10, 100)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-8, 50)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-6, 20)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-4, 10)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(-2, 5)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(0, 0)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(2, 4)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(4, 16)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(6, 36)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(8, 64)]];
    [data addObject:[NSValue valueWithCGPoint:CGPointMake(10, 100)]];
    
    self.scatterPlot = [[TUTSimpleScatterPlot alloc] initWithHostingView:_graphHostingView andData:data];
    [self.scatterPlot initialisePlot];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

@end
