    //
//  GetHotelModel.m
//  imvr
//
//  Created by Yaseen Mansuri on 26/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "GetHotelModel.h"
#import "BusinessCard.h"

@implementation GetHotelModel

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
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	//[self Call_WebService:@"1"];
}


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

-(void)Call_WebService:(NSString*)HotelId {
	//[self performSelectorInBackground:@selector(ShowAlert) withObject:nil];
		NSURL *url = nil;
	
		url = [[NSURL alloc] initWithString:[NSString stringWithFormat:@"http://www.imvr.net/iphonexml/gethotels.php?id=%@",HotelId]];
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
		
	}
	else if([elementName isEqualToString:@"Hotel"]) {
		
		HotelsDic = [[NSMutableDictionary alloc] init];
		
	}
	//	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string { 
	
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
			}	
	else if([elementName isEqualToString:@"HotelID"]||[elementName isEqualToString:@"HotelName"]||[elementName isEqualToString:@"Address"]||[elementName isEqualToString:@"Phone"]||[elementName isEqualToString:@"Area"] ||[elementName isEqualToString:@"AreaID"]||[elementName isEqualToString:@"HotelUrl"] ||[elementName isEqualToString:@"LogoUrl"]||[elementName isEqualToString:@"Fax"] ||[elementName isEqualToString:@"Email"] ){
		
		[HotelsDic setObject:currentElementValue forKey:elementName];
		
			}
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
	[((imvrAppDelegate*)[[UIApplication sharedApplication] delegate]).HotelDataArray release];
	((imvrAppDelegate*)[[UIApplication sharedApplication] delegate]).HotelDataArray = HotelsArray;
	//[av dismissWithClickedButtonIndex:0 animated:YES];	
	
	//NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	//NSUserDefaults *defaults=[[NSUserDefaults alloc]init];
//	[NSUserDefaults resetStandardUserDefaults];
//	[defaults setObject:[HotelsArray valueForKey:@"HotelID"] forKey:@"HotelID"]; 
//	// [defaults setObject:stringFromData forKey:kDefaultsUserData];
//	//[defaults setObject:[content objectForKey:@"id"] forKey:kDefaultsUserID]; 
//	//[defaults synchronize]; 
//	NSLog(@"HotelID: %@", [defaults objectForKey:@"HotelID"]); 

	NSLog(@"HotelDataArray:%@",[((imvrAppDelegate*)[[UIApplication sharedApplication] delegate]).HotelDataArray description]);
	
	
	
}
-(NSMutableArray *) getHotelArray{
	
	return HotelsArray;
	
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


- (void)dealloc {
    [super dealloc];
}


@end
