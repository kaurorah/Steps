//
//  MapViewController.m
//  Steps
//
//  Created by Katherine Aurora Habeck on 12/9/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import "MapViewController.h"

@implementation MapViewController

- (void) viewDidLoad{
    [super viewDidLoad];
    
    CLLocationCoordinate2D location = CLLocationCoordinate2DMake(51.50007773, -0.1246402);
    
     
     MKCoordinateSpan span;
     span.latitudeDelta = 0.002;
     span.longitudeDelta = 0.002;
    MKCoordinateRegion region;
    region.center=location;
    region.span =  span;;

    [self.mapView setRegion:region animated:YES];
    
    MKPointAnnotation *annotation;
}


@end
