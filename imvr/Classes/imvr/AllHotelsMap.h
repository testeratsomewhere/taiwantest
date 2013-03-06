//
//  AllHotelsMap.h
//  imvr
//
//  Created by Ashwin Jumani on 04/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>
#import "imvrAppDelegate.h"

@class DisplayMap;
@class BusinessCard;
@interface AllHotelsMap : UIViewController<MKMapViewDelegate,MKAnnotation,UIAlertViewDelegate> {

	IBOutlet MKMapView *mapView;
	CLLocationCoordinate2D coordinate;
	NSString *address;
	
	//AddressAnnotation *addAnnotation;
	
	//new code by ashwin
	MKMapView *_mapView;
	//Annotation *_newAnnotation;
	CLLocationManager *_locationManager;
	NSString *_lat;
	NSString *_long;
	
	//new variables
	NSMutableArray *HotelsArray;
	NSMutableDictionary *HotelsDic;
	NSMutableDictionary *locCategory,*locCategoryAll;
	NSMutableArray *locArray;
	NSMutableString *currentElementValue;
	UIAlertView *av;
	UIActivityIndicatorView *actInd;
	NSString *mKey,*tempKey,*tempArea;
	NSURLConnection *conn;
	NSXMLParser *xmlParser;
	NSMutableData *webData;
	int currentLoc;
	NSMutableArray *mylocations;
	
	imvrAppDelegate *appDelegate;
	BusinessCard *ObjBusinessCard;
	
}
@property (nonatomic, retain) IBOutlet MKMapView *mapView;
-(CLLocationCoordinate2D) addressLocation:(NSString *) address1;
-(void) showMyAddress;
-(void)Call_WebService;
//-(IBAction)annotationViewClick:(id)sender;
-(IBAction)annotationViewClick:(id)sender;
//-(IBAction) annotationViewClick:(DisplayMap *) sender;
-(id)initWithCoordinate:(CLLocationCoordinate2D) c;
@end
