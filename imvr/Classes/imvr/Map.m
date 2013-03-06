//
//  Map.m
//  imvr
//
//  Created by Yaseen Mansuri on 16/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Map.h"
#import "imvrAppDelegate.h"

//new code by ashwin
#import "Annotation.h"

@implementation AddressAnnotation

@synthesize coordinate,title,subtitle,hotelID;

//- (NSString *)subtitle{
//	return @"Sub Title";
//}
//- (NSString *)title{
//	return @"Title";
//}

-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	//NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

@end


@implementation Map
@synthesize address;
@synthesize mapView         = _mapView;
@synthesize newAnnotation   = _newAnnotation;
@synthesize locationManager = _locationManager;
@synthesize _lat;
@synthesize _long;
@synthesize HotelArray = _HotelArray;

@synthesize mapTitle;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	lblTitle.text = self.mapTitle;
	
		if ([((imvrAppDelegate*)[[UIApplication sharedApplication]delegate]).flagstr isEqualToString:@"YES"])
    {
		NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
		//NSString *hotelAddress = nil;
		
		if (standardUserDefaults) 
			address = [standardUserDefaults objectForKey:@"currentaddress"];
		
		
	}
	
	else
	{
		//Here we need to load web services for all pin
				NSLog(@"ViewDidLoad");
		[self getAllHotels];
			address=@"Taipei";
		
	}
	
	//mapView.showsUserLocation=TRUE;

	
	//[mapView setShowsUserLocation:YES];
	
	//[self showAddress];
}

//Start ashwin code
-(void) getAllHotels{
	[self performSelectorInBackground:@selector(ShowAlert) withObject:nil];
	[self Call_WebService];
	//[self setAllHotelPins];
	
}

-(void) setAllHotelPins{
	
	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	
	self.locationManager.delegate        = self;
	self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	
	[self.locationManager startUpdatingLocation];
	
	
	
	[mapView setMapType:MKMapTypeStandard];
	[mapView setZoomEnabled:YES];
	[mapView setScrollEnabled:YES];
	MKCoordinateRegion region = { {0.0, 0.0 }, { 0.0, 0.0 } }; 
	
	region.center.latitude = 22.569722 ;
	region.center.longitude = 88.369722;
	region.span.longitudeDelta = 0.01f;
	region.span.latitudeDelta = 0.01f;
	
	[mapView setRegion:region animated:YES]; 
	
	[mapView setDelegate:self];
	
	
	
	
	
	mylocations = [[NSMutableArray alloc] init];
	//MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=0.2;
	span.longitudeDelta=0.2;
	CLLocationCoordinate2D location;
	//address = @"Testing";
	
	int totalhotel = [HotelsArray count];
	for (int i=0; i< 5; i++) {
		location = [self addressLocation:[[HotelsArray objectAtIndex:i] valueForKey:@"Address"]];
		region.span=span;
		region.center=location;
		addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
		addAnnotation.title = [[HotelsArray objectAtIndex:i] valueForKey:@"HotelName"];
		addAnnotation.subtitle = [[HotelsArray objectAtIndex:i] valueForKey:@"Address"];
		
		
		//addAnnotation.hotelID = [[HotelsArray objectAtIndex:i] valueForKey:@"HotelID"];
		[mylocations addObject:addAnnotation];
	}
	
	//NSLog(@" location : %@",mylocations);
	[mapView addAnnotations:mylocations];
	
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];
	
	
	
	//new code
	/* 
		CLLocation* currentLocation = [[[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude] autorelease];
		
		
		
		self.newAnnotation = [Annotation annotationWithCoordinate:currentLocation.coordinate];
		self.newAnnotation.title    = address;
		self.newAnnotation.subtitle = address;
		
		if (nil != self.newAnnotation) {
			
			[self.mapView addAnnotation:self.newAnnotation];
			
			self.newAnnotation = nil;
		}
		
		[self setCurrentLocation:currentLocation];
	 */	


}


-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:
(id <MKAnnotation>)annotation {
	MKPinAnnotationView *pinView = nil; 
	if(annotation != mapView.userLocation) 
	{
		static NSString *defaultPinID = @"com.invasivecode.pin";
		pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
										  initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
		
		pinView.pinColor = MKPinAnnotationColorRed; 
		pinView.canShowCallout = YES;
		pinView.animatesDrop = YES;
		
		UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		[rightButton addTarget:self action:@selector(annotationViewClick:) forControlEvents:UIControlEventTouchUpInside];
		pinView.rightCalloutAccessoryView = rightButton;
		//[pinView addSubview:rightButton];
	} 
	else {
		[mapView.userLocation setTitle:@"I am here"];
	}
	return pinView;
}

-(IBAction)back_click{
	//[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
	//	NSLog(@"click on back");
	[self.navigationController popViewControllerAnimated:YES];
	
}
-(void)ShowAlert{
	//[alertmessage ShowAlert];
	NSAutoreleasePool *pool = [ [ NSAutoreleasePool alloc] init];
	av=[[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	[av show];
	actInd=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	
	[actInd setFrame:CGRectMake(120, 50, 37, 37)];
	[actInd startAnimating];
	[av addSubview:actInd];
	[pool release];
}
-(void)Call_WebService{
	
	NSURL *url = nil;

	//if ([txtLocation.text isEqualToString:@"All"] || [txtLocation.text isEqualToString:@""]) {
		
		
		url = [[NSURL alloc] initWithString:@"http://www.imvr.net/iphonexml/gethotels.php"];
	//}
	//else {
	//	NSString *newurl = [NSString stringWithFormat:@"http://www.imvr.net/iphonexml/hotelbylocation.php?areaid=%@",
							//[mKey stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
		//url = [[NSURL alloc] initWithString:url];
	//}
	
	NSMutableURLRequest *req =[NSMutableURLRequest requestWithURL:url];
	conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	if (conn) {
		webData =[[NSMutableData alloc]  initWithLength:0];
	}    
	
		
}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
	[webData setLength: 0];
}

-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data {
	
	[webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	UIAlertView *connectionError = [[UIAlertView alloc] initWithTitle:@"Connection error" message:@"Error connecting to page.  Please check your 3G and/or Wifi settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
    [connectionError show];
	
	[av dismissWithClickedButtonIndex:0 animated:YES];	
	
	
	[webData release];
    [connection release];
	
}
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
	// NSLog(@"DONE. Received Bytes: %d", [webData length]);
	// NSString *theXML = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] 
	//										  encoding:NSUTF8StringEncoding];
    //---shows the XML---
	// NSLog(theXML);
	// [theXML release];    
    
	if (xmlParser)
    {
        [xmlParser release];
    }    
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
    [connection release];
	[webData release];	
}
- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	
	if([elementName isEqualToString:@"HotelTable"]) {
		//Initialize the array.
		HotelsArray = [[NSMutableArray alloc] init];
		locArray = [[NSMutableArray alloc] init];
		
	}
	else if([elementName isEqualToString:@"Hotel"]) {
		
		//Initialize the book.
		HotelsDic = [[NSMutableDictionary alloc] init];
		locCategory = [[NSMutableDictionary alloc] init];
		
		//		//Extract the attribute here.
		//		aBook.bookID = [[attributeDict objectForKey:@"id"] integerValue];
		//		
		//		NSLog(@"Reading id value :%i", aBook.bookID);
	}
	//	
	//	NSLog(@"Processing Element: %@", elementName);
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string { 
	//	
	//if(!currentElementValue)
	
	
	currentElementValue = [[NSMutableString alloc] init];
	
	[currentElementValue appendString:string];
	
	// else	
	
	//[currentElementValue appendString:string];
	//[currentElementValue release];
	//	NSLog(@"Processing Value: %@", currentElementValue);
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:@"HotelTable"])
		return;
	
	else if([elementName isEqualToString:@"Hotel"]) {
		[HotelsArray addObject:HotelsDic];
		//NSLog(@"HotelsArray :%@",[HotelsArray description]);
		[HotelsDic release];
		
		[locArray addObject:locCategory];
		
		[locCategory release];
	}	
	else if([elementName isEqualToString:@"HotelID"]||[elementName isEqualToString:@"HotelName"]||[elementName isEqualToString:@"Address"] ){
		[HotelsDic setObject:currentElementValue forKey:elementName];
	
	}
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{

	[av dismissWithClickedButtonIndex:0 animated:YES];
	[self setAllHotelPins];
	//[locArray addObject:locCategoryAll];
	((imvrAppDelegate*)[[UIApplication sharedApplication]delegate]).tabBarController.selectedIndex=2;
	
}
-(CLLocationCoordinate2D) addressLocation:(NSString *) address1 {
    NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv", 
						   [address1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]];
    NSArray *listItems = [locationString componentsSeparatedByString:@","];
	
    double latitude = 0.0;
    double longitude = 0.0;
	
    if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) {
        latitude = [[listItems objectAtIndex:2] doubleValue];
        longitude = [[listItems objectAtIndex:3] doubleValue];
    }
    else {
		//Show error
    }
    CLLocationCoordinate2D location;
    location.latitude = latitude;
    location.longitude = longitude;
	
    return location;
}



//#End of ashwin code
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
- (IBAction) showAddress {
	//Hide the keypad
	//[addressField resignFirstResponder];
	MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=0.2;
	span.longitudeDelta=0.2;
	
	CLLocationCoordinate2D location = [self addressLocation];
	region.span=span;
	region.center=location;
	
	if(addAnnotation != nil) {
		[mapView removeAnnotation:addAnnotation];
		[addAnnotation release];
		addAnnotation = nil;
	}
	
	addAnnotation = [[AddressAnnotation alloc] initWithCoordinate:location];
	addAnnotation.title=address;
	[mapView addAnnotation:addAnnotation];
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];
	//[mapView selectAnnotation:mLodgeAnnotation animated:YES];
	
	//self.mapView.showsUserLocation=YES;

}

+(NSString *) getCurrentAddress{
	NSString *address = nil;
    if (address == nil) {
		//Here we can add all hotels
		//isCallWebService = YES;
		return @"Taipei";
	}
	return address;
}

-(CLLocationCoordinate2D) addressLocation {
	
	NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv", 
						   [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]];
	NSArray *listItems = [locationString componentsSeparatedByString:@","];
	
	double latitude = 25.06233;
	double longitude = 121.55238;
	
		if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) {
			latitude = [[listItems objectAtIndex:2] doubleValue];
			longitude = [[listItems objectAtIndex:3] doubleValue];
		}
		else {
			//Show error
		}
	

	
	CLLocationCoordinate2D location;
	location.latitude = latitude;
	location.longitude = longitude;
	return location;
}
#pragma mark MapView delegate/datasourec methods
//- (MKAnnotationView *) mapView:(MKMapView *)mapView1 viewForAnnotation:(id <MKAnnotation>) annotation{
//	/*MKPinAnnotationView *annView=[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"currentloc"];
//	annView.pinColor = MKPinAnnotationColorGreen;
//	annView.animatesDrop=TRUE;
//	annView.canShowCallout = YES;
//	annView.calloutOffset = CGPointMake(-5, 5);
//	
//	UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//	 [rightButton addTarget:self action:@selector(annotationViewClick:) forControlEvents:UIControlEventTouchUpInside];
//    annView.rightCalloutAccessoryView = rightButton;
//	//[annView addSubview:rightButton];
//	return annView;*/
//	
//	//new code by ashwin
//	 MKPinAnnotationView *view = nil; // return nil for the current user location
//		
//		if (annotation != mapView1.userLocation) {
//			
//			view = (MKPinAnnotationView *)[mapView1 dequeueReusableAnnotationViewWithIdentifier:@"identifier"];
//			
//			if (nil == view) {
//				view = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:@"identifier"] autorelease];
//				view.rightCalloutAccessoryView = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
//			}
//			
//			[view setPinColor:MKPinAnnotationColorPurple];
//			[view setCanShowCallout:YES];
//			[view setAnimatesDrop:YES];
//			
//		} else {
//			
//			CLLocation *location = [[CLLocation alloc] initWithLatitude:mapView1.userLocation.coordinate.latitude 
//															  longitude:mapView1.userLocation.coordinate.longitude];
//			[self setCurrentLocation:location];
//		}
//		return view; 
//	
//	/* MKPinAnnotationView *pinView = nil; 
//		if(annotation != mapView.userLocation) 
//		{
//			static NSString *defaultPinID = @"Taiwan";
//			pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
//			if ( pinView == nil ) pinView = [[[MKPinAnnotationView alloc]
//											  initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
//			
//			pinView.pinColor = MKPinAnnotationColorRed; 
//			
//			pinView.canShowCallout = YES;
//			pinView.animatesDrop = YES;
//		} 
//		else {
//			[mapView.userLocation setTitle:@"I am here"];
//		}
//		return pinView;
//		
//	 */	
//}
/*
- (void)mapView:(MKMapView *)mapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	
	GMapDirectionsViewController *gmd = [[GMapDirectionsViewController alloc] initWithNibName:@"GMapDirectionsView" bundle:nil];
		
		gmd.latitude  = self._lat;
		gmd.longitude = self._long;
		
		[self.navigationController pushViewController:gmd animated:YES];
		
		[gmd release];
}
*/
#pragma mark -
#pragma mark CoreLocation Delegate Methods
- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
	
	//NSLog(@"lat/long: %f. %f", [newLocation coordinate].latitude, [newLocation coordinate].longitude);
	
	CLLocationDegrees latitude = newLocation.coordinate.latitude;
	CLLocationDegrees longitude = newLocation.coordinate.longitude;
	
	self._lat  = [[NSNumber numberWithDouble:latitude] stringValue];
	self._long = [[NSNumber numberWithDouble:longitude] stringValue];
	[self.locationManager stopUpdatingLocation];
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
	[self.locationManager stopUpdatingLocation];
	//NSLog(@"Error: %@", [error description]);
}

-(IBAction)annotationViewClick:(id)sender{
	
	//[self.navigationController popViewControllerAnimated:NO];
	
	GMapDirectionsViewController *gmd = [[GMapDirectionsViewController alloc] initWithNibName:@"GMapDirectionsView" bundle:nil];
	
	gmd.latitude  = self._lat;
	gmd.longitude = self._long;
	
	[self.navigationController pushViewController:gmd animated:YES];
	
	[gmd release];
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidAppear:(BOOL)animated {
	
	[super viewDidAppear:animated];
	
	
	
	if ([((imvrAppDelegate*)[[UIApplication sharedApplication]delegate]).flagstr isEqualToString:@"YES"]){
		
	
		
	
	NSLog(@"viewDidAppear");

	self.locationManager = [[[CLLocationManager alloc] init] autorelease];
	
	self.locationManager.delegate        = self;
	self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	
	[self.locationManager startUpdatingLocation];
	
	CLLocationDegrees latitude  = kPOILat;
	CLLocationDegrees longitude = kPOILong;
	
	
	NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv", 
						   [address stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]];
	NSArray *listItems = [locationString componentsSeparatedByString:@","];
	
	
	
	if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) {
		latitude = [[listItems objectAtIndex:2] doubleValue];
		longitude = [[listItems objectAtIndex:3] doubleValue];
	}
	else {
		//Show error
	}
	
	
	//Save address to userdefault
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	if (standardUserDefaults) {
		[standardUserDefaults setObject:address forKey:@"currentaddress"];
		[standardUserDefaults synchronize];
	}
	
	
	//CLLocationCoordinate2D location = [self addressLocation];
	//NSLog(@"Location : %@",location);
	//CLLocation* currentLocation = [[[CLLocation alloc] initWithLatitude:location.latitude longitude:location.longitude] autorelease];
	CLLocation* currentLocation = [[[CLLocation alloc] initWithLatitude:latitude longitude:longitude] autorelease];
    
	
	
	self.newAnnotation = [Annotation annotationWithCoordinate:currentLocation.coordinate];
	self.newAnnotation.title    = address;
	self.newAnnotation.subtitle = address;
	
	if (nil != self.newAnnotation) {
		
		[self.mapView addAnnotation:self.newAnnotation];
		
		self.newAnnotation = nil;
	}
	
	[self setCurrentLocation:currentLocation];
		
	}
	else {
		//here is our code for add all hotels
		
	}
	
	
	self.mapView.showsUserLocation=YES;


}


- (void)viewDidUnload {
	
	self.mapView         = nil;
	self.newAnnotation   = nil;
	self.locationManager = nil;
}

/*- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}*/

//new code by ashwin
- (void)setCurrentLocation:(CLLocation *)location {
	
	MKCoordinateRegion region = {{0.0f, 0.0f}, {0.0f, 0.0f}};
	
	region.center = location.coordinate;
	
	region.span.longitudeDelta = 0.05f;
	region.span.latitudeDelta  = 0.05f;
	
	[self.mapView setRegion:region animated:YES];
	[self.mapView regionThatFits:region];
}


- (void)dealloc {
	//new code by ashwin
	[_mapView release];
	[_newAnnotation release];
	_locationManager.delegate = nil;
	[_locationManager release];
	[_lat release];
	[_long release];
	
    [super dealloc];
}


@end
