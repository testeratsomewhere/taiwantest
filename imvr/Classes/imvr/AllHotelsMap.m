//
//  AllHotelsMap.m
//  imvr
//
//  Created by Ashwin Jumani on 04/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AllHotelsMap.h"
#import "DisplayMap.h"
#import "BusinessCard.h"

@implementation AllHotelsMap
@synthesize coordinate;
@synthesize mapView;
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

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
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
	
	url = [[NSURL alloc] initWithString:@"http://www.imvr.net/iphonexml/gethotels.php"];
	
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
-(void) connectionDidFinishLoading:(NSURLConnection *) connection 
{
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
		
		
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{ 
	currentElementValue = [[NSMutableString alloc] init];
	[currentElementValue appendString:string];
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:@"HotelTable"])
		return;
	
	else if([elementName isEqualToString:@"Hotel"]) {
		[HotelsArray addObject:HotelsDic];
		NSLog(@"HotelsArray :%@",[HotelsArray description]);
		[HotelsDic release];
		
		[locArray addObject:locCategory];
		
		[locCategory release];
	}	
	else if([elementName isEqualToString:@"HotelID"]||[elementName isEqualToString:@"HotelName"]||[elementName isEqualToString:@"Address"] ||[elementName isEqualToString:@"Phone"] ||[elementName isEqualToString:@"HotelUrl"] ||[elementName isEqualToString:@"Email"] || [elementName isEqualToString:@"LogoUrl"]||[elementName isEqualToString:@"Fax"] ){
		[HotelsDic setObject:currentElementValue forKey:elementName];
		
	}
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
	
	[av dismissWithClickedButtonIndex:0 animated:YES];
	NSLog(@"HotelsArray :%@",[HotelsArray description]);
	[self showMyAddress];
		
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	[self ShowAlert];
	[self Call_WebService];
	[mapView setMapType:MKMapTypeStandard];
	[mapView setScrollEnabled:YES];
	[mapView setDelegate:self];
	appDelegate = (imvrAppDelegate *)[UIApplication sharedApplication].delegate; 
	mapView.showsUserLocation=TRUE;

}






-(void) showMyAddress{
	
	currentLoc=0;
	mylocations = [[NSMutableArray alloc] init];
	//MKCoordinateRegion region;
	MKCoordinateSpan span;
	span.latitudeDelta=0.2;
	span.longitudeDelta=0.2;
	CLLocationCoordinate2D location;
	
	MKCoordinateRegion region;
	int totalhotel = [HotelsArray count];
	NSLog(@"Total Hotel %d", totalhotel );
	for (int i=0; i< totalhotel; i++) 
	{
		location = [self addressLocation:[[HotelsArray objectAtIndex:i] valueForKey:@"Address"]];
		region.span=span;
		region.center=location;
		DisplayMap *addAnnotation = [[DisplayMap alloc] initWithCoordinate:location];
		addAnnotation.title = [[HotelsArray objectAtIndex:i] valueForKey:@"HotelName"];
		addAnnotation.subtitle = [[HotelsArray objectAtIndex:i] valueForKey:@"Address"];
		addAnnotation.HotelId = [[HotelsArray objectAtIndex:i] valueForKey:@"HotelID"];
		addAnnotation.PhoneNumber = [[HotelsArray objectAtIndex:i] valueForKey:@"Phone"];
		addAnnotation.HotelUrl = [[HotelsArray objectAtIndex:i] valueForKey:@"HotelUrl"];
		addAnnotation.Logo = [[HotelsArray objectAtIndex:i] valueForKey:@"LogoUrl"];
		addAnnotation.Fax = [[HotelsArray objectAtIndex:i] valueForKey:@"Fax"];
		addAnnotation.Email = [[HotelsArray objectAtIndex:i] valueForKey:@"Email"];
		//addAnnotation.hotelID = [[HotelsArray objectAtIndex:i] valueForKey:@"HotelID"];
		[mylocations addObject:addAnnotation];
		
		location.latitude=0.0;
		location.longitude=0.0;
		
		[addAnnotation release];
		
	}
	
	//NSLog(@" location : %@",mylocations);
	[mapView addAnnotations:mylocations];
	//[mapView addAnnotation:<#(id <MKAnnotation>)annotation#>
	
	[mapView setRegion:region animated:TRUE];
	[mapView regionThatFits:region];
	
	mapView.showsUserLocation=TRUE;

	
}


-(CLLocationCoordinate2D) addressLocation:(NSString *) address1 
{
    NSString *urlString = [NSString stringWithFormat:@"http://maps.google.com/maps/geo?q=%@&output=csv", [address1 stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    NSString *locationString = [NSString stringWithContentsOfURL:[NSURL URLWithString:urlString]];
    NSArray *listItems = [locationString componentsSeparatedByString:@","];
	
    double latitude = 0.0;
    double longitude = 0.0;
	
    if([listItems count] >= 4 && [[listItems objectAtIndex:0] isEqualToString:@"200"]) 
	{
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



-(MKAnnotationView *)mapView:(MKMapView *)mV viewForAnnotation:(id <MKAnnotation>)annotation 
{
	
	if(currentLoc == [mylocations count]){
		currentLoc = 0;
	}
	//NSLog(@"%@",[annotation description]);
	MKPinAnnotationView *pinView = nil; 
	if(annotation != mapView.userLocation) 
	{
		//static NSString *defaultPinID = @"net.imvr.pin";
		NSString *defaultPinID = [NSString stringWithFormat:@"%i",currentLoc];
	
		pinView = (MKPinAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:defaultPinID];
		
		if ( pinView == nil )
		{
			DisplayMap *addAnnotation = (DisplayMap *) [mylocations objectAtIndex:currentLoc];
			
			
			//pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:defaultPinID] autorelease];
			pinView = [[[MKPinAnnotationView alloc] initWithAnnotation:addAnnotation reuseIdentifier:defaultPinID] autorelease];
		}
		UIButton *rightButton = [UIButton buttonWithType:UIButtonTypeDetailDisclosure];
		//[rightButton addTarget:self action:@selector(annotationViewClick:) forControlEvents:UIControlEventTouchUpInside];
		
	
		pinView.tag = currentLoc;
		pinView.rightCalloutAccessoryView = rightButton;
		//[pinView addSubview:rightButton];
		
		pinView.pinColor = MKPinAnnotationColorRed; 
		pinView.canShowCallout = YES;
		pinView.animatesDrop = YES;
		NSLog(@"Print current location: %i",currentLoc);
		
		currentLoc++;
	} 
	else 
	{
		[mapView.userLocation setTitle:@"I am here"];
		NSLog(@"Inside else Print current location: %i",currentLoc);
		//currentLoc++;
	}
	
	return pinView;
}

//------ new addition

- (void)mapView:(MKMapView *)eMapView annotationView:(MKAnnotationView *)view calloutAccessoryControlTapped:(UIControl *)control {
	
	   if (view.annotation == eMapView.userLocation)
        return;
	
	NSLog(@"tag value from control: %d", [view tag]);
	//int myLoc = [view tag];
	DisplayMap *disp = (DisplayMap *)view.annotation;
	NSLog(@"annotation: %@ hotel id %@", view.annotation.title,disp.HotelId);
	
   	NSLog(@"reuse identifier : %@",view.reuseIdentifier);
	int myLoc = [view.reuseIdentifier intValue];
	NSLog(@"ttaagg :- %d", myLoc);
	
	[self.navigationController popViewControllerAnimated:NO];
	
	ObjBusinessCard = [[BusinessCard alloc] initWithNibName:@"BusinessCard" bundle:nil];
	// ...
	// Pass the selected object to the new view controller.HotelId,Address,PhoneNumber
	ObjBusinessCard.HotelId= disp.HotelId;
	ObjBusinessCard.Address= disp.subtitle;
	ObjBusinessCard.PhoneNumber=disp.PhoneNumber;
	ObjBusinessCard.HotelName= disp.title;
	ObjBusinessCard.HotelURL= disp.HotelUrl;
	ObjBusinessCard.Fax= disp.Fax;
	ObjBusinessCard.Logo= disp.Logo;
	ObjBusinessCard.Email= disp.Email;
	
	appDelegate.mapFlag = YES;
	appDelegate.segmentIndex = 3;
	[self.navigationController pushViewController:ObjBusinessCard animated:YES];
	//[ObjBusinessCard release];
	 
	
}


/*

-(IBAction)annotationViewClick:(id)sender{
	NSLog(@"Click annot : %d",[sender tag]);
	
	//int myLoc = [sender tag];
	UIButton *a = (UIButton *)sender;
	int myLoc = [a tag];
	//int myLoc = currentloc;
	DisplayMap *currentAnnotation;
	
	currentAnnotation = (DisplayMap *) [mylocations objectAtIndex:myLoc];
	NSLog(@"valueee :- %@", [mylocations objectAtIndex:myLoc]);
	//DisplayMap *dMap = (DisplayMap *) sender;
	
	[self.navigationController popViewControllerAnimated:NO];
	
	BusinessCard *ObjBusinessCard = [[BusinessCard alloc] initWithNibName:@"BusinessCard" bundle:nil];
	// ...
	// Pass the selected object to the new view controller.HotelId,Address,PhoneNumber
	ObjBusinessCard.HotelId= currentAnnotation.HotelId;
	ObjBusinessCard.Address= currentAnnotation.subtitle;
	ObjBusinessCard.PhoneNumber=currentAnnotation.PhoneNumber;
	ObjBusinessCard.HotelName= currentAnnotation.title;
	ObjBusinessCard.HotelURL= currentAnnotation.HotelUrl;
	ObjBusinessCard.Fax= currentAnnotation.Fax;
	ObjBusinessCard.Logo= currentAnnotation.Logo;
	ObjBusinessCard.Email= currentAnnotation.Email;
	
	appDelegate.mapFlag = YES;
	appDelegate.segmentIndex = 3;
	[self.navigationController pushViewController:ObjBusinessCard animated:YES];
	//[ObjBusinessCard release];
}
*/
 
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	
	[mapView release];
	[address release];
	
	
	[_mapView  release];
	[_locationManager release];
	[_lat release];
	[_long release];
	
	[HotelsArray release];
	[HotelsDic release];
	[locCategory release],
	[locCategoryAll release];
	[locArray release];
	[currentElementValue release];
	[av release];
	[actInd release];
	[mKey release];
	[tempKey release];
	[tempArea release];
	[conn release];
	[xmlParser release];
	[webData release];

	[mylocations release];
	
	[appDelegate release];
	[ObjBusinessCard release];
	
    [super dealloc];
}


@end
