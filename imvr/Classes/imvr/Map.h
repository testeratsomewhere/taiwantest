//
//  Map.h
//  imvr
//
//  Created by Yaseen Mansuri on 16/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <MapKit/MapKit.h>

//new code by ashwin
#import "GMapDirectionsViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "imvrAppDelegate.h"
#define kPOILat 35.115403
#define kPOILong -89.9045614724

@class Annotation;

@interface AddressAnnotation : NSObject<MKAnnotation> {
	CLLocationCoordinate2D coordinate;
	
	NSString *mTitle;
	NSString *mSubTitle;
	NSString *mhotelID;
	//new code by ashwin
	
}

@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *hotelID;
- (NSString *)subtitle;
- (NSString *)title;
@end
@interface Map : UIViewController <MKMapViewDelegate,CLLocationManagerDelegate, MKMapViewDelegate, CLLocationManagerDelegate,NSXMLParserDelegate,UIAlertViewDelegate>{
	IBOutlet MKMapView *mapView;
	NSString *address;

	AddressAnnotation *addAnnotation;
	
	//new code by ashwin
	MKMapView *_mapView;
	Annotation *_newAnnotation;
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
	imvrAppDelegate *appDelegate;
	
	NSMutableArray *mylocations;
	
	NSString *mapTitle;
	
	IBOutlet UILabel *lblTitle;
}

-(CLLocationCoordinate2D) addressLocation;
- (IBAction) showAddress;
@property(nonatomic,retain)NSString *address;
//new code by ashwin
@property(nonatomic, retain) IBOutlet MKMapView *mapView;
@property(nonatomic, retain) Annotation *newAnnotation;
@property(nonatomic, retain) CLLocationManager *locationManager;
@property(nonatomic, retain) NSString *_lat;
@property(nonatomic, retain) NSString *_long;
@property(nonatomic,retain) NSMutableArray *HotelArray;

@property(nonatomic, retain) NSString *mapTitle;

- (void)setCurrentLocation:(CLLocation *)location;
+(NSString *) getCurrentAddress;
-(void) getAllHotels;
-(CLLocationCoordinate2D) addressLocation:(NSString *) address;
-(void)Call_WebService;
-(void)ShowAlert;
-(void) setAllHotelPins;
-(IBAction)back_click;

@end
