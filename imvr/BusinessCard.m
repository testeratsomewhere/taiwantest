//
//  BusinessCard.m
//  imvr
//
//  Created by Yaseen Mansuri on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "BusinessCard.h"
#import "HotelRoom.h"
#import "Price.h"
//#import "alertmessage.h"
#import "Website.h"
#import "Map.h"
#import "Price.h"
#import "imvrAppDelegate.h"
#import "RoomCoverFlow.h"

#import "DataCache.h"
#import "FlowCoverView.h"

@implementation BusinessCard
@synthesize adBannerView = _adBannerView;
@synthesize adBannerViewIsVisible = _adBannerViewIsVisible;
@synthesize contentView = _contentView;
@synthesize HotelId,Address,PhoneNumber,HotelName,Fax,Logo,HotelURL,Email;
@synthesize segmentedControl;
@synthesize webServiceCount;
@synthesize imageName;
@synthesize imgName;
@synthesize PriceView;
@synthesize lastSelectedIndex;
@synthesize RoomsArray;
@synthesize NewCoverFlowview;
@synthesize LocationView;
@synthesize NewsView;
@synthesize orientationCall;
//@synthesize PriceView;
@synthesize priceWebView;

// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andArray:(NSMutableArray *)arr1{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
	mArr = arr1;
    if (self) 
	{
		//[NSString stringWithFormat:@"%@", [arr1 objectAtIndex:0]];
		//[self setImageName];

	}
    return self;
}

#pragma mark segmentedControlIndexChanged Methods

-(IBAction) segmentedControlIndexChanged
{
	NSLog(@" yes");
	switch (self.segmentedControl.selectedSegmentIndex) 
	{
		case 0:[self btnLocation_click];
			    break;
		case 1:[self btnNews_click];
				break;
		case 2:[self btnRooms_click];
				break;
		case 3:[self btnPrice_click];
				 break;
		default:break;
	}
		 
}

-(void)setImageName
{
	//self.imageName.text = @"TEST";
	//self.imgName.text = @"test";
	self.imageName.text = @"text";
	NSLog(@"label value %@", self.imgName.text);

}
#pragma mark buttons Methods


-(IBAction)btnPrice_click
{
	roomsImageFlag = NO;
	/*
	Price *ObjPrice=[[Price alloc]initWithNibName:@"Price" bundle:nil];
	ObjPrice.StrPrice=[NSString stringWithFormat:@"http://www.imvr.net/iphonexml/getpricetable.php?id=%@",HotelId];
	//ObjPrice.strTitle = [[hotelDetailArray objectAtIndex:0] valueForKey:@"HotelName"];
	[self.navigationController pushViewController:ObjPrice animated:YES];
	*/
	LocationView.hidden=YES;
	PriceView.hidden =YES;
	NewsView.hidden = YES;
	priceWebView.hidden = NO;
	NewCoverFlowview.hidden = YES;
	NSURL *test1 = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.imvr.net/iphonexml/getpricetable.php?id=%@",HotelId]];
	NSURLRequest *test = [NSURLRequest requestWithURL:test1];
	webview.backgroundColor = [UIColor blackColor];
	webview.scalesPageToFit = YES;
	[webview loadRequest:test];
	
}

-(IBAction)sendEmail
{
	/* code for keeping the selected tab*/
	navArrayMail = [appDelegate.tabBarController viewControllers];
	navControllerMail = (UINavigationController *)[appTabBar selectedViewController];
	for(int i=0; i<[navArrayMail count]; i++)
	{
		
		if([navArrayMail objectAtIndex:i] == navControllerMail)
		{
			selectedTabForMail = i;
			break;
		}
	}
	//----------------------
	
	MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
	NSString *mailId = lblEmail.text;
	NSArray *mailArr = [[NSArray alloc] initWithObjects:mailId,nil]; 
	
	[controller setToRecipients:mailArr];
    [controller setSubject:@"IMVR Inquiry"];
    [controller setMessageBody:@"Hi, " isHTML:NO];
	//[controller addAttachmentData:myData mimeType:@"image/png" fileName:@"a.png"];
	[self presentModalViewController:controller animated:YES];
		
	
}
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult :(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:NO];
	if(selectedTabForMail == 0)
	{
		[appTabBar.btn1 setSelected:YES];
		[appTabBar.btn2 setSelected:NO];
		[appTabBar.btn3 setSelected:NO];
	}
	else if (selectedTabForMail == 1)
	{
		[appTabBar.btn1 setSelected:NO];
		[appTabBar.btn2 setSelected:YES];
		[appTabBar.btn3 setSelected:NO];
	}
	else if(selectedTabForMail == 2)
	{
		[appTabBar.btn1 setSelected:NO];
		[appTabBar.btn2 setSelected:NO];
		[appTabBar.btn3 setSelected:YES];
	}
	
}

-(void)HotelRoom:(id)sender {
	HotelRoom *ObjHotelRoom=[[HotelRoom alloc]initWithNibName:@"HotelRoom" bundle:nil];
	ObjHotelRoom.RoomName=[[imgArray objectAtIndex:[sender tag]] valueForKey:@"RoomName"];
	ObjHotelRoom.RoomDesc=[[imgArray objectAtIndex:[sender tag]] valueForKey:@"RoomDesc"];
	ObjHotelRoom.imageData=[[imgArray objectAtIndex:[sender tag]] valueForKey:@"imageData"];
	
	[self.navigationController pushViewController:ObjHotelRoom animated:NO];
	[ObjHotelRoom release];
}

-(IBAction)btnAddress_click{
	((imvrAppDelegate*)[[UIApplication sharedApplication]delegate]).flagstr=@"YES";
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	if (standardUserDefaults) {
		[standardUserDefaults setObject:lblAddress.text forKey:@"currentaddress"];
		[standardUserDefaults synchronize];
	}
	
	Map *ObjMap=[[Map alloc]initWithNibName:@"Map" bundle:nil];
	ObjMap.address=lblAddress.text;
	ObjMap.mapTitle = [[hotelDetailArray objectAtIndex:0] valueForKey:@"HotelName"];
	[self.navigationController pushViewController:ObjMap animated:YES];
	[ObjMap release];
	//((imvrAppDelegate*)[[UIApplication sharedApplication]delegate]).tabBarController.selectedIndex=2;
}


-(IBAction)Phone
{
	
	
	NSString *newPhoneNumber =[NSString stringWithFormat:@"tel:%@",lblPhoneNumber.text];
	//NSLog(@"%@",newPhoneNumber);
	NSURL *url = [[NSURL alloc]initWithString:newPhoneNumber];
    [[UIApplication sharedApplication] openURL:url]; 
}

-(IBAction)Website
{
	Website *ObjWebsite=[[Website alloc]initWithNibName:@"Website" bundle:nil];
	ObjWebsite.strURL = [[hotelDetailArray objectAtIndex:0] valueForKey:@"HotelUrl"];
	ObjWebsite.webTitle = [[hotelDetailArray objectAtIndex:0] valueForKey:@"HotelName"];
	[self.navigationController pushViewController:ObjWebsite animated:NO];
	//[ObjWebsite release];
}


-(IBAction)btnLocation_click
{
	roomsImageFlag = NO;
	
	LocationView.hidden=NO;
	NewsView.hidden=YES;
	PriceView.hidden=YES;
	priceWebView.hidden = YES;
	NewCoverFlowview.hidden = YES;
	if([hotelDetailArray count] == 0)
	{
		webServiceCount = 1;
		[self Call_WebService];
	}
	else 
	{
		return;
	
	}

}
-(IBAction)btnNews_click
{
	roomsImageFlag = NO;
	
	LocationView.hidden=YES;
	NewsView.hidden=NO;
	PriceView.hidden=YES;
	priceWebView.hidden = YES;
	NewCoverFlowview.hidden = YES;
	if([NewsArray count] > 0)
	{
		[tblNews reloadData];
	}
	else 
	{
		CGRect cgRct = CGRectMake(0, 0, 320, 330);		
		tblNews = [[UITableView alloc] initWithFrame:cgRct style:UITableViewStylePlain];
		tblNews.editing = NO;  
		tblNews.dataSource = self;
		tblNews.delegate = self; 
		tblNews.backgroundColor = [UIColor clearColor];
		tblNews.rowHeight = 50;
		[tblNews setSeparatorStyle:UITableViewCellSeparatorStyleNone];
		[NewsView addSubview:tblNews];
		webServiceCount = 2;
		[self Call_WebService];
	}

	
	
}


-(IBAction)btnRooms_click
{
	roomsImageFlag = YES;
	
	LocationView.hidden=YES;
	NewsView.hidden=YES;
	PriceView.hidden=NO;
	priceWebView.hidden = YES;
	NewCoverFlowview.hidden = YES;
	if([RoomsArray count]  == 0)
	{
		webServiceCount = 3;
		[self Call_WebService];
	}
	else {
		return;
	}

}




#pragma mark viewDidLoad

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	appDelegate = (imvrAppDelegate *) [UIApplication sharedApplication].delegate;
	if(appDelegate.segmentIndex == 1)
	{
		LocationView.hidden=NO;
		PriceView.hidden =YES;
		NewsView.hidden = YES;
		priceWebView.hidden = YES;
		NewCoverFlowview.hidden = YES;
		segmentedControl.selectedSegmentIndex = 0;
		webServiceCount = 1;
		[self Call_WebService];
			
	}
	else if (appDelegate.segmentIndex == 2)
	{
		LocationView.hidden=YES;
		PriceView.hidden = YES;
		NewsView.hidden = NO;
		priceWebView.hidden = YES;
		NewCoverFlowview.hidden = YES;
		segmentedControl.selectedSegmentIndex = 1;
		
	}
	else if(appDelegate.segmentIndex == 3)
	{
		LocationView.hidden=NO;
		PriceView.hidden =YES;
		NewsView.hidden = YES;
		priceWebView.hidden = YES;
		NewCoverFlowview.hidden = YES;
		segmentedControl.selectedSegmentIndex = 0;
		webServiceCount = 1;
		[self Call_WebService];
		
	}
	else 
	{
		LocationView.hidden=NO;
		PriceView.hidden = YES;
		NewsView.hidden = YES;
		priceWebView.hidden = YES;
		NewCoverFlowview.hidden = YES;
		segmentedControl.selectedSegmentIndex = 0;
		webServiceCount = 1;
		[self Call_WebService];
			
	}


	[super viewDidLoad];
	
	orientationCall = 0;
	
	scr.scrollEnabled = YES;
	[scr setContentSize:CGSizeMake(0,540)];
	[self.view setBackgroundColor:[UIColor colorWithRed:28/255 green:38/255 blue:39/255 alpha:1.0f]];
	LocationView.backgroundColor=[UIColor clearColor];
	NewsView.backgroundColor=[UIColor clearColor];
	PriceView.backgroundColor=[UIColor clearColor];
	
	
	
	
	HotelDataArrrayFromDelegate=[[NSMutableArray alloc]init];
	HotelDataArrrayFromDelegate=((imvrAppDelegate*)[[UIApplication sharedApplication] delegate]).HotelDataArray;

	
	//webServiceCount = 1;
	//[self Call_WebService];	
	
	//| for orientation
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification" object:nil]; 
	addNotification = YES;
		
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(IBAction)back_click
{
	
	
	[self.navigationController popViewControllerAnimated:YES];
}
-(void) viewDidDisappear:(BOOL)animated{
	
	

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

-(void)Hidealert
{
	[av dismissWithClickedButtonIndex:0 animated:YES];

}




-(void)Call_WebService
{
	
	[self performSelectorInBackground:@selector(ShowAlert) withObject:nil];
	NSURL *url;
	
	if(webServiceCount == 1)
	{
		url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.imvr.net/iphonexml/gethotels.php?id=%@",self.HotelId]];
	}
	if(webServiceCount == 2)
	{
		url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.imvr.net/iphonexml/getnews.php?id=%@",self.HotelId]];
		NSLog(@"news url :- %@", url);
		
	}
	if(webServiceCount == 3)
	{
		url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.imvr.net/iphonexml/getrooms.php?id=%@",HotelId]];
		NSLog(@"URL :- %@", url );
 
	}
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
	[self Hidealert];
	
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
	
	if([elementName isEqualToString:@"HotelTable"]) 
	{
		if([RoomsArray count] == 0)
			RoomsArray = [[NSMutableArray alloc] init];
		
		if([NewsArray count] == 0)
			NewsArray = [[NSMutableArray alloc] init];
		
		if([hotelDetailArray count] == 0)
			hotelDetailArray = [[NSMutableArray alloc] init];

	}
	else if([elementName isEqualToString:@"HotelRooms"]) 
	{
		
		RoomsDic = [[NSMutableDictionary alloc] init];
		
	}
	else if([elementName isEqualToString:@"HotelNews"]) 
	{
		
	        NewsDic = [[NSMutableDictionary alloc] init];
		
	}
	
	else if([elementName isEqualToString:@"Hotel"]) 
	{
		
		DetailDic = [[NSMutableDictionary alloc] init];
		
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string { 
	
	currentElementValue = [[NSMutableString alloc] init];
	
	[currentElementValue appendString:string];
	NSLog(@"%@", currentElementValue);

	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:@"HotelTable"])
		return;

	if(webServiceCount == 3)
	{
		if([elementName isEqualToString:@"HotelRooms"]) 
		{
			[RoomsArray addObject:RoomsDic];
			[RoomsDic release];
		}
		else if([elementName isEqualToString:@"HotelID"]||[elementName isEqualToString:@"RoomID"]||[elementName isEqualToString:@"RoomName"]||[elementName isEqualToString:@"RoomDesc"] ||[elementName isEqualToString:@"RoomPic"])
		{
			[RoomsDic setObject:currentElementValue forKey:elementName];
		}
	}
	if(webServiceCount == 2)
	{
		if([elementName isEqualToString:@"HotelNews"]) 
		{
			[NewsArray addObject:NewsDic];
			[NewsDic release];
		}	
	
		else if([elementName isEqualToString:@"HotelID"]||[elementName isEqualToString:@"HotelName"]||[elementName isEqualToString:@"NewsID"]||[elementName isEqualToString:@"NewsTitle"] ||[elementName isEqualToString:@"NewsContent"] || [elementName isEqualToString:@"HotelUrl"] || [elementName isEqualToString:@"HotelLogo"])
		{
			[NewsDic setObject:currentElementValue forKey:elementName];
		}
	}
	if(webServiceCount == 1)
	{
		if([elementName isEqualToString:@"Hotel"]) 
		{
			[hotelDetailArray addObject:DetailDic];
			[DetailDic release];
		}
		else if([elementName isEqualToString:@"HotelID"]||[elementName isEqualToString:@"AreaID"]||[elementName isEqualToString:@"Area"]||[elementName isEqualToString:@"HotelName"] ||[elementName isEqualToString:@"HotelUrl"] ||[elementName isEqualToString:@"LogoUrl"] ||[elementName isEqualToString:@"Address"] ||[elementName isEqualToString:@"Phone"] ||[elementName isEqualToString:@"Fax"] ||[elementName isEqualToString:@"Email"] ||[elementName isEqualToString:@"PriceTable"])
		{
			[DetailDic setObject:currentElementValue forKey:elementName];
		}
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
	//[alertmessage hideAlert];
	
	[self Hidealert];
	if(webServiceCount == 1)
	{
		[self fixParticularHotelValue];
		 webServiceCount = 0;
	}
	if(webServiceCount == 2)
	{
		if([NewsArray count] > 0)
		{
			lblHotelName.text=[[NewsArray objectAtIndex:0] valueForKey:@"HotelName"];
		
		Logo=[[NewsArray objectAtIndex:0] valueForKey:@"HotelLogo"];
		
		NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:Logo]];
		[logoImageView setImage:[UIImage imageWithData: imageData]];
		
		[tblNews reloadData];
		 webServiceCount = 0;
		}
		else 
		{
			UIAlertView *NewsAlert =[[UIAlertView alloc] initWithTitle:@"Message" message:@"No News for this hotel at present" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[NewsAlert show];
			[NewsAlert release];
		}

	}
	if(webServiceCount == 3)
	{
		if([RoomsArray count] > 0)
		{
			[self fixRoomImages];
			webServiceCount = 0;
		}
		else 
		{
			UIAlertView *roomImagesAlert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No images for this hotel at present" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
			[roomImagesAlert show];
			[roomImagesAlert release];
		}

	}
	
	
}

#pragma mark fixing first segment Values
-(void)fixParticularHotelValue
{
	if([hotelDetailArray count] == 0)
	{
		
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"No Details For selected hotel" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
		[alert show];
		[alert release];
		
		lblAddress.text= @"";
		lblPhoneNumber.text= @"";
		lblHotelName.text= @"";
		lblFax.text= @"";
		lblHotelURL.text= @"";
		lblEmail.text= @"";
		//HotelId= self.HotelId;
		//Logo= self.Logo;
		
	}
	else 
	{

		NSLog(@"Array detail.. %@", [[hotelDetailArray objectAtIndex:0] description]);
		lblAddress.text= [[hotelDetailArray objectAtIndex:0] valueForKey:@"Address"];
		lblPhoneNumber.text=[[hotelDetailArray objectAtIndex:0] valueForKey:@"Phone"];
		lblHotelName.text=[[hotelDetailArray objectAtIndex:0] valueForKey:@"HotelName"];
		lblFax.text=[[hotelDetailArray objectAtIndex:0] valueForKey:@"Fax"];
		lblHotelURL.text=[[hotelDetailArray objectAtIndex:0] valueForKey:@"HotelUrl"];
		lblEmail.text=[[hotelDetailArray objectAtIndex:0] valueForKey:@"Email"];
		HotelId=[[hotelDetailArray objectAtIndex:0] valueForKey:@"HotelID"];
		Logo=[[hotelDetailArray objectAtIndex:0] valueForKey:@"LogoUrl"];
		
		NSData * imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:Logo]];
		[logoImageView setImage:[UIImage imageWithData: imageData]];
	}
}

#pragma mark fixing first segment Values
-(void)fixRoomImages
{
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification" object:nil]; 

	loadImagesOperationQueue = [[NSOperationQueue alloc] init];
	if([appDelegate.roomImagesArray count] != 0)
	{
		[appDelegate.roomImagesArray removeAllObjects];
	}
	for (int i=0; i < [RoomsArray count]; i++) 
	{
		
		NSString *imgstr=[[RoomsArray objectAtIndex:i] valueForKey:@"RoomPic"];
		NSString *imgNametemp = [[RoomsArray objectAtIndex:i] valueForKey:@"RoomName"];
		NSLog(@"%Image Name :- %@", imgNametemp);
		NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.imvr.net%@",imgstr]]];
		UIImage *img = [UIImage  imageWithData:imageData];
		
		//NSLog(@"WIDTH :- %f  HEIGHT :- %f", img.size.width, img.size.height);
		//imageName = [[NSString alloc] initWithFormat:@"cover_%d.jpg", i];
		if(img != nil)
		{
			[appDelegate.imageNameArrary addObject:[[RoomsArray objectAtIndex:i] valueForKey:@"RoomName"]];
			[appDelegate.roomIDArray addObject:[[RoomsArray objectAtIndex:i] valueForKey:@"RoomID"]];
			[appDelegate.imageArray addObject:img];
			[appDelegate.roomImagesArray addObject:img];
			if(i==0)
			{
				[(AFOpenFlowView *)PriceView setDefaultImage:img];
			}
			else 
			{
				[(AFOpenFlowView *)PriceView setImage:img forIndex:i];
			}
		}
		
	}
	
	[(AFOpenFlowView *)PriceView setNumberOfImages:[RoomsArray count]];
	
}

- (int)flowCoverNumberImages:(FlowCoverView *)view
{
	return [imgArr count];
	
}

- (UIImage *)flowCover:(FlowCoverView *)view cover:(int)image
{
		
	return [imgArr objectAtIndex:image];
}

- (void)flowCover:(FlowCoverView *)view didSelect:(int)image
{
	NSLog(@"Selected Index %d",image);
}

#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [NewsArray count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell = nil;
	if (cell!=nil) {
		cell=nil;
	}
	
    if (cell == nil)
	{
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		
		UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(10, 10, 200, 31)];
		lbl.text=[[NewsArray objectAtIndex:indexPath.row] valueForKey:@"NewsTitle"];
		lbl.textColor=[UIColor whiteColor];
		lbl.font = [UIFont fontWithName:@"Trebuchet MS" size: 15.0];
		//lbl.adjustsFontSizeToFitWidth = YES;
		lbl.numberOfLines = 2;
		[lbl setBackgroundColor:[UIColor clearColor]];
		[cell addSubview:lbl];
		[lbl release];
		
		//cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
		UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)]; 
		UIImage *accImage = [UIImage imageNamed:@"brown-arrow.png"];
		[accessoryButton setImage:accImage forState: UIControlStateNormal];
		//[accessoryButton addTarget:self action:@selector(yourMethodName) forControlEvents:UIControlEventTouchUpInside];
		[cell setAccessoryView:accessoryButton];
		[accImage release];
		
		cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_stripe.png"]];
		
	}
		return cell;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
    if(!newsObj)
	{
		newsObj = [[NewsWebview alloc] initWithNibName:@"NewsWebview" bundle:nil];
	}
	newsObj.strURL = [[NewsArray objectAtIndex:indexPath.row] valueForKey:@"HotelUrl"];
	newsObj.newsID = [[NewsArray objectAtIndex:indexPath.row] valueForKey:@"NewsID"];
	newsObj.hotelName = [[NewsArray objectAtIndex:indexPath.row] valueForKey:@"HotelName"];
	[self.navigationController pushViewController:newsObj animated:YES];
	
}



-(void) viewWillAppear:(BOOL)animated
{
	appDelegate.orientationCounter = 0;
	appTabBar = (CustomTabBar *)appDelegate.tabBarController;
	/*if (addNotification == YES) {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification" object:nil]; 	
	}
	*/
	//[[NSNotificationCenter defaultCenter] removeObserver:self];
	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification" object:nil]; 	

	//[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification" object:nil]; 

}
-(void)viewWillDisappear:(BOOL)animated
{
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index{
	
	
	NSLog(@"%d is selected",index);
	
}
- (void)openFlowView:(AFOpenFlowView *)openFlowView requestImageForIndex:(int)index{
}


- (UIImage *)defaultImage{
	
	return [UIImage imageNamed:@"cover_1.jpg"];
}


#pragma mark webview methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	[self ShowAlert];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	[self Hidealert];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to open the website" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];
}
/*
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
	
	
}*/



 // Override to allow orientations other than the default portrait orientation.
 - (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation 
{
	if((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) || (interfaceOrientation == UIInterfaceOrientationLandscapeRight))
	{
		//NSLog(@"Orientation changed");
		//imgLandView = [[imageLandscape alloc] initWithNibName:@"imageLandscape" bundle:nil];	
		//[self.navigationController presentModalViewController:imgLandView animated:YES];
		self.view.autoresizesSubviews = YES;
		self.view.autoresizingMask =UIViewAutoresizingFlexibleHeight|UIViewAutoresizingFlexibleWidth;
	} 
		
	NSLog(@"Orientation changed");
	
	return NO;
}

-(void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation 
{
	if((fromInterfaceOrientation == UIDeviceOrientationLandscapeLeft) || (fromInterfaceOrientation == UIDeviceOrientationLandscapeRight))
	{
	} 
	else if((fromInterfaceOrientation == UIDeviceOrientationPortrait) || (fromInterfaceOrientation == UIDeviceOrientationPortraitUpsideDown))
	{
		
	}
}




- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
	NSLog(@"Orientation changed");
}
- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation) interfaceOrientation duration:(NSTimeInterval)duration
{

	NSLog(@"Orientation changed");
}


#pragma mark  Orientation methods

 
- (void) didRotate:(NSNotification *)notification
{
	
	addNotification = NO;
 	UIDeviceOrientation orientation = [[UIDevice currentDevice] orientation];
	//imgLandView = [[imageLandscape alloc] initWithNibName:@"imageLandscape" bundle:nil];

	
		if(!orientationFlag)
		{
			navArray = [appDelegate.tabBarController viewControllers];
			navController = (UINavigationController *)[appTabBar selectedViewController];
			for(int i=0; i<[navArray count]; i++)
			{
		
				if([navArray objectAtIndex:i] == navController)
				{
					selectedTab = i;
					orientationFlag = YES;
					break;
				}
			}
		}
		if(appDelegate.imageFlag || appDelegate.specificImageFlag)
		{
			if(orientation == UIInterfaceOrientationPortrait) 
			{ 
					
				[self.navigationController dismissModalViewControllerAnimated:NO];
				//[imgLandView release];
				if(selectedTab == 0)
				{
					[appTabBar.btn1 setSelected:YES];
					[appTabBar.btn2 setSelected:NO];
					[appTabBar.btn3 setSelected:NO];
				} 
				else if (selectedTab == 1)
				{
					[appTabBar.btn1 setSelected:NO];
					[appTabBar.btn2 setSelected:YES];
					[appTabBar.btn3 setSelected:NO];
				}
				else if(selectedTab == 2)
				{
					[appTabBar.btn1 setSelected:NO];
					[appTabBar.btn2 setSelected:NO];
					[appTabBar.btn3 setSelected:YES];
				}
				orientationFlag = NO;
				appDelegate.imageFlag = NO;
				appDelegate.specificImageFlag = NO;
				appDelegate.orientationCounter = 0;

				
			} 
			else if (orientation == UIInterfaceOrientationLandscapeLeft) 
			{ 
				imgLandView = [[imageLandscape alloc] initWithNibName:@"imageLandscape" bundle:nil];
				imgLandView.imgNo = appDelegate.imageNo;
				imgLandView.count = appDelegate.imageCount;
				appDelegate.orientationCounter = 1;
				[self.navigationController presentModalViewController:imgLandView animated:NO];
				//[imgLandView release];
				[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification" object:nil]; 

				appDelegate.orientationCounter = 0;
			} 
			else if (orientation == UIInterfaceOrientationLandscapeRight) 
			{ 
				imgLandView = [[imageLandscape alloc] initWithNibName:@"imageLandscape" bundle:nil];
				imgLandView.imgNo = appDelegate.imageNo;
				imgLandView.count = appDelegate.imageCount;
				appDelegate.orientationCounter = 1;
				
				[self.navigationController presentModalViewController:imgLandView animated:NO];
				///[imgLandView release];
				[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRotate:) name:@"UIDeviceOrientationDidChangeNotification" object:nil]; 

				appDelegate.orientationCounter = 0;
				
			} 
			else if (orientation == UIInterfaceOrientationPortraitUpsideDown) 
			{ 
				[self.navigationController dismissModalViewControllerAnimated:NO];
				//[imgLandView release];
				if(selectedTab == 0)
				{
					[appTabBar.btn1 setSelected:YES];
					[appTabBar.btn2 setSelected:NO];
					[appTabBar.btn3 setSelected:NO];
				}
				else if (selectedTab == 1)
				{
					[appTabBar.btn1 setSelected:NO];
					[appTabBar.btn2 setSelected:YES];
					[appTabBar.btn3 setSelected:NO];
				}
				else if(selectedTab == 2)
				{
					[appTabBar.btn1 setSelected:NO];
					[appTabBar.btn2 setSelected:NO];
					[appTabBar.btn3 setSelected:YES];
				}
			
				orientationFlag = NO;
				appDelegate.imageFlag = NO;
				appDelegate.specificImageFlag = NO;
				appDelegate.orientationCounter = 0;

			}
		}
	
	}

-(void)pushImageController
{
	/*if(!imgLandView)
	{
		imgLandView = [[imageLandscape alloc] initWithNibName:@"imageLandscape" bundle:nil];
	}
	[self.navigationController presentModalViewController:imgLandView animated: NO];
	[imgLandView release];
	 */
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
	//[[NSNotificationCenter defaultCenter] removeObserver:self];

}


- (void)dealloc 
{
    self.contentView = nil;    
    self.adBannerView = nil; 
	
	//[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[scr release];
	[LocationView release];
	[NewsView release];
	[PriceView release];
	[priceWebView release];
	[NewCoverFlowview release];
	
	
	
	
	[_contentView release];
	
	[HotelId release];
	[Address release];
	[PhoneNumber release];
	[HotelName release];
	[Fax release];
	[Logo release];
	[HotelURL release];
	[Email release];

	[lblAddress release];
	[lblPhoneNumber release];
	[lblHotelName release];
	[lblHotelURL release];
	[lblFax release];
	[lblEmail release];
	
	[RoomsArray release];
	[RoomsDic release];
	[NewsArray release];
	[NewsDic release];
	[currentElementValue release];
    [tblNews release];
	[svimg release];
	[imgArray release];
	[av release];
	[actInd release];
	[segmentedControl release];
	[logoImageView release];
	[HotelDataArrrayFromDelegate release];
	
	[loadImagesOperationQueue release];
	
	[appDelegate release];
	
	[webData release];
	[xmlParser release];
	[conn release];
	[DetailDic release];
	[hotelDetailArray release];
	[imgArr release];
	
	[FlowCover release];
	[imageName release];
	
	[mArr release];
	
	[viw release];
	
	
	
	[webview release];
	[newsObj release];
	
	
	[imgLandView release];
	
	
	
	[appTabBar release];
	[navController release];
	[navArray release];
	
	[navArrayMail release];
	[navControllerMail release];
	
	
	
	[super dealloc];
	 
	
	
	//[ObjPrice release];
}


@end
