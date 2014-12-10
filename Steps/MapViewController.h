//
//  MapViewController.h
//  Steps
//
//  Created by Katherine Aurora Habeck on 12/9/14.
//  Copyright (c) 2014 Katherine Habeck. All rights reserved.
//

#import <UIKit/UIKit.h>
 #import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
@interface MapViewController : UIViewController  <MKMapViewDelegate>
@property (weak, nonatomic) IBOutlet MKMapView *mapView;



@end
