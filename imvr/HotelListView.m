//
//  HotelListView.m
//  imvr
//
//  Created by Yaseen Mansuri on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HotelListView.h"
#import "BusinessCard.h"
#import "AppRecord.h"



//s#import "alertmessage.h"
@implementation HotelListView
@synthesize HotelId, HotelsArray, imageDownloadsInProgress, entries, PickerHotelsArray;
@synthesize mKey;
@synthesize lastTitle;
@synthesize pickerRow;
@synthesize taipieList;
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

-(void)call_Scroll{
	int i;
	int x=10,y=14;
	svimg = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 20, 320,100)];
	[svimg setScrollEnabled:YES];
	//[svimg setContentSize:CGSizeMake(1000,0)];
	[svimg flashScrollIndicators];
	//imgArray=[[NSMutableArray alloc]init];
//	NSMutableDictionary *imgDic;//=[[NSMutableDictionary alloc]init];
	for (i=1; i<[AreaArray count]+1; i++) {
		
		
				
		
		//imgDic=[[NSMutableDictionary alloc]init];
		//btnimg=[buttons objectAtIndex:i-1];
		UIButton *btnimg =[[UIButton buttonWithType:UIButtonTypeCustom] retain];
		
		btnimg.frame=CGRectMake(x+10, y+10, 100, 50);
		UIImage *img = [UIImage  imageNamed:@"btn_location.png"];
		[btnimg setBackgroundImage:img forState:UIControlStateNormal];
	
		
		UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(5, 5, 100, 50)];
		lbl.text=[[AreaArray objectAtIndex:i-1] valueForKey:@"AreaName"];
		//[lbl setTextAlignment:UITextAlignment
		//[lbl setTextAlignment:UITextAlignmentCenter];
		lbl.textColor=[UIColor whiteColor];
		[lbl setFont:[UIFont boldSystemFontOfSize:11.0]];
		[lbl setBackgroundColor:[UIColor clearColor]];
		[btnimg addSubview:lbl];
		[lbl release];
		int AreaID;
		AreaID=[[[AreaArray objectAtIndex:i-1] valueForKey:@"AreaID"] intValue];
		btnimg.tag=AreaID;
		//[btnimg addTarget:self action:@selector(HotelRoom:) forControlEvents:UIControlEventTouchUpInside];
		//NSString *imgstr=[[RoomsArray objectAtIndex:i-1] valueForKey:@"RoomPic"];
//		//NSLog(@"%@",[NSString stringWithFormat:@"http://www.imvr.net%@",imgstr]);
//		//[imgview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"http://www.imvr.net%@",imgstr]]];
//		NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.imvr.net%@",imgstr]]];
//		UIImage *img = [UIImage  imageWithData:imageData];
//		if(imageData!=nil && [imageData retainCount]>0){
//			[imgDic setObject:[[RoomsArray objectAtIndex:i-1] valueForKey:@"RoomName"] forKey:@"RoomName"];
//			[imgDic setObject:[[RoomsArray objectAtIndex:i-1] valueForKey:@"RoomDesc"] forKey:@"RoomDesc"];
//			[imgDic setObject:imageData forKey:@"imageData"];
//		}
//		else {
//			[imgDic setObject:[[RoomsArray objectAtIndex:i-1] valueForKey:@"RoomName"] forKey:@"RoomName"];
//			[imgDic setObject:[[RoomsArray objectAtIndex:i-1] valueForKey:@"RoomDesc"] forKey:@"RoomDesc"];
//			[imgDic setObject:@"" forKey:@"imageData"];
//		}
		
		
		//[imgArray addObject:imgDic];
//		[imgDic release];
//		
//		
//		[btnimg setBackgroundImage:img forState:UIControlStateNormal] ;
//		//[img release];
//		[btnimg addTarget:self action:@selector(HotelRoom:) forControlEvents:UIControlEventTouchUpInside];
//		//btnimg.tag=i-1;
//		[btnimg setTag:i-1];
		[svimg addSubview:btnimg];
		[svimg setContentSize:CGSizeMake(x+100,0)];

		x=x+110;
		if (i%[AreaArray count]==0 && i!=0) {
			y=y+100;
			x=10;
		}
		[btnimg release];
	}
	
	[self.view addSubview:svimg];
	//[self performSelectorInBackground:@selector(Hidealert) withObject:nil];
	
}



-(IBAction) taipai_click{
	//NSLog(@"Taipai click");
	/*NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	if (standardUserDefaults) {
		[standardUserDefaults setObject:@"3" forKey:@"location"];
		[standardUserDefaults synchronize];
	}
	NSString *location = nil;
	
	if (standardUserDefaults) 
		location = [standardUserDefaults objectForKey:@"location"];
	if (![location isEqualToString:@"3"]) {
		[HotelsArray removeAllObjects];
		//[Hotellisttbl reloadData];
		
		[self Call_WebService];
		[Hotellisttbl beginUpdates];
	}*/
	//txtLocation.text = @"All";
//	[HotelsArray removeAllObjects];	
//	//[Hotellisttbl reloadData];
//	[self performSelectorInBackground:@selector(ShowAlert) withObject:nil];
//
//	[self Call_WebService];
	//[Hotellisttbl reloadData];
	
	//[Hotellisttbl setDataSource:HotelsArray];
//	NSLog(@"%@",[AreaArray description]);
	
	[self createLocationPickerView];
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	//NSLog(@"second view");
	self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
	entries = [[NSMutableArray alloc] init];
	AreaArray=[[NSMutableArray alloc]init];
	AreaArray=((imvrAppDelegate*)[[UIApplication sharedApplication]delegate]).AreaArray;
	
	Hotellisttbl.backgroundColor=[UIColor clearColor];
//	Hotellisttbl.separatorColor=[UIColor clearColor];
	//lblCity.text=@"台北市";
	lastTitle = [[AreaArray objectAtIndex:1] valueForKey:@"AreaName"];
	[lblCity setText:[[AreaArray objectAtIndex:1] valueForKey:@"AreaName"]];
	//[alertmessage ShowAlert];
	/*NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	if (standardUserDefaults) {
		[standardUserDefaults setObject:@"0" forKey:@"location"];
		[standardUserDefaults synchronize];
	}*/
	
	
	locCategoryAll = [[NSMutableDictionary alloc] init];
	[locCategoryAll setObject:@"0" forKey:@"AreaID"];
	[locCategoryAll setObject:@"All" forKey:@"Area"];
	
	[self performSelectorInBackground:@selector(ShowAlert) withObject:nil];

	
	//[self call_Scroll];
	[self Call_WebService];
	logoArray = [[NSMutableArray alloc]init];
	//calling thread for logo
	 //[NSThread detachNewThreadSelector:@selector(getLogo) toTarget:self withObject:nil];  
	
	//[self getData];
	
	appDelegate = (imvrAppDelegate *) [UIApplication sharedApplication].delegate;
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

-(void)Hidealert{
	//[alertmessage hideAlert];
}
-(void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult :(MFMailComposeResult)result error:(NSError*)error {
	[self dismissModalViewControllerAnimated:YES];
}
-(IBAction)back_click{
	[self.navigationController popViewControllerAnimated:YES];
}
-(IBAction) btnLogo_click{
	MFMailComposeViewController *controller = [[MFMailComposeViewController alloc] init];
    controller.mailComposeDelegate = self;
	NSArray *mailArr = [[NSArray alloc] initWithObjects:@"imvr.net@gmail.com",nil]; 
	//NSArray *toMail = [[NSArray alloc] initWithArray:[@"imvr@imvr.net",nil]];
	//toMail.
	[controller setToRecipients:mailArr];
    [controller setSubject:@"IMVR Inquiry"];
    [controller setMessageBody:@"Hi, " isHTML:NO];
	//[controller addAttachmentData:myData mimeType:@"image/png" fileName:@"a.png"];
	[self presentModalViewController:controller animated:YES];
}
-(void)Call_WebService{
	//NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	//NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	//NSString *location = nil;
	
	//if (standardUserDefaults) 
	//	location = [standardUserDefaults objectForKey:@"location"];
	NSURL *url = nil;
	//if ([location isEqualToString:@"0"] || location == nil) {
   
	
	
	
	
	//if ([txtLocation.text isEqualToString:@"All"] || [txtLocation.text isEqualToString:@""]) {
		
	
		url = [[NSURL alloc] initWithString:@"http://www.imvr.net/iphonexml/gethotels.php"];
	//}
	//else {
	//	NSString *newurl = [NSString stringWithFormat:@"http://www.imvr.net/iphonexml/hotelbylocation.php?areaid=%@",
		//				 [mKey stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	//	url = [[NSURL alloc] initWithString:newurl];
	//}
	
	NSMutableURLRequest *req =[NSMutableURLRequest requestWithURL:url];
	conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	if (conn) {
		webData =[[NSMutableData alloc]  initWithLength:0];
	}    

	//url = [[NSURL alloc] initWithString:@"http://www.imvr.net/iphonexml/gethotels.php"];
	//NSXMLParser *xmlParser = [[NSXMLParser alloc] initWithContentsOfURL:url];
//	
//	//Initialize the delegate.
//	//	XMLParser *parser = [[XMLParser alloc] initXMLParser];
//	
//		[xmlParser setDelegate:self];
//	
//	//Start parsing the XML file.
//	BOOL success = [xmlParser parse];
//	
//	if(success)
//		NSLog(@"No Errors");
//	else
//		NSLog(@"Error Error Error!!!");
	
	/*locCategory = [[NSMutableDictionary alloc] init];
	[locCategory setObject:@"0" forKey:@"AreaID"];
	[locCategory setObject:@"All" forKey:@"Area"];*/
	//[xmlParser release];
	
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



-(void) viewDidDisappear:(BOOL)animated{
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	if (standardUserDefaults) {
		[standardUserDefaults setObject:@"0" forKey:@"location"];
		[standardUserDefaults synchronize];
	}
}

-(void) viewDidAppear:(BOOL)animated{
	
	[super viewDidAppear:animated];
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
	{
		
		return;
	}
	else if([elementName isEqualToString:@"Hotel"]) {
		[HotelsArray addObject:HotelsDic];
	//	NSLog(@"HotelsArray :%@",[HotelsArray description]);
		[HotelsDic release];
		
		[locArray addObject:locCategory];
		
		[locCategory release];
	}	
	else if([elementName isEqualToString:@"HotelID"]||[elementName isEqualToString:@"HotelName"]||[elementName isEqualToString:@"Address"]||[elementName isEqualToString:@"Phone"]||[elementName isEqualToString:@"Area"] ||[elementName isEqualToString:@"AreaID"]||[elementName isEqualToString:@"HotelUrl"] ||[elementName isEqualToString:@"LogoUrl"]||[elementName isEqualToString:@"Fax"] ||[elementName isEqualToString:@"Email"] ){
		
		[HotelsDic setObject:currentElementValue forKey:elementName];
		
		if([elementName isEqualToString:@"AreaID"]){
			//mKey = currentElementValue;
			//if(![tempKey isEqualToString:currentElementValue]){
			[locCategory setObject:currentElementValue forKey:@"AreaID"];
			//tempKey = currentElementValue;
			//}
		}
		if([elementName isEqualToString:@"Area"]){
			//if( ![tempArea isEqualToString:currentElementValue]){
			//[locCategory set
			[locCategory setObject:currentElementValue forKey:@"Area"];
			//tempArea = currentElementValue;
			//}
		}
	}

}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	
	taipieList=[[NSMutableArray alloc]init];
	for (int i=0; i<[HotelsArray count]; i++) 
	{
		NSMutableDictionary *PickerHotelDic;//=[[NSMutableDictionary alloc]init];
		// area id for taipie is 3 .
		if ([@"3" isEqualToString:[NSString stringWithFormat:@"%@",[[HotelsArray objectAtIndex:i] valueForKey:@"AreaID"]]]) 
		{
			PickerHotelDic=[[NSMutableDictionary alloc]init];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"Address"] forKey:@"Address"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"Area"] forKey:@"Area"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"AreaID"] forKey:@"AreaID"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"Fax"] forKey:@"Fax"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"HotelID"] forKey:@"HotelID"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"HotelName"] forKey:@"HotelName"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"HotelUrl"] forKey:@"HotelUrl"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"LogoUrl"] forKey:@"LogoUrl"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"Phone"] forKey:@"Phone"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"Email"] forKey:@"Email"];
			
			NSLog(@"Add Email : %@",[[HotelsArray objectAtIndex:i] valueForKey:@"Email"]);
			[taipieList addObject:PickerHotelDic];
			
			[PickerHotelDic release];
		}
		
		
	}
	
	if(Hotellisttbl!=nil && [Hotellisttbl retainCount]>0)
	{ 
		[Hotellisttbl removeFromSuperview]; 
		Hotellisttbl=nil; 
	}

	CGRect cgRct = CGRectMake(0, 44, 320, 360);                
	Hotellisttbl = [[UITableView alloc] initWithFrame:cgRct style:UITableViewStylePlain];
	Hotellisttbl.editing = NO;  
	Hotellisttbl.dataSource = self;
	Hotellisttbl.delegate = self; 
	Hotellisttbl.backgroundColor = [UIColor clearColor];
	Hotellisttbl.rowHeight=60;
	
	
	[Hotellisttbl setSeparatorStyle: UITableViewCellSeparatorStyleNone];

	[self.view addSubview:Hotellisttbl];
	
	[Hotellisttbl release];
	
	[av dismissWithClickedButtonIndex:0 animated:YES];

	[locArray addObject:locCategoryAll];
	
	
	((imvrAppDelegate*)[[UIApplication sharedApplication]delegate]).tabBarController.selectedIndex=1;
	[self fillTheIconArray];

}
-(void)fixTableAgain
{
	if(Hotellisttbl!=nil && [Hotellisttbl retainCount]>0)
	{ 
		[Hotellisttbl removeFromSuperview]; 
		Hotellisttbl=nil; 
	}
	
	CGRect cgRct = CGRectMake(0, 44, 320, 360);                
	Hotellisttbl = [[UITableView alloc] initWithFrame:cgRct style:UITableViewStylePlain];
	Hotellisttbl.editing = NO;  
	Hotellisttbl.dataSource = self;
	Hotellisttbl.delegate = self; 
	Hotellisttbl.backgroundColor = [UIColor clearColor];
	Hotellisttbl.rowHeight=60;
	[Hotellisttbl setSeparatorStyle: UITableViewCellSeparatorStyleNone];
	[self.view addSubview:Hotellisttbl];
	
	[Hotellisttbl release];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
#pragma mark -
#pragma mark Table view data source

// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section 
{
	if ([pickerStr isEqualToString:@"YES"]) 
	{
		return [PickerHotelsArray count];
	}
	/*else 
	{
		return [HotelsArray count];

	}*/
	else 
	{
		return [taipieList count];
		
	}

}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	cell = nil;
	if (cell!=nil) {
		cell=nil;
	}
	if ([pickerStr isEqualToString:@"YES"]) 
	{
		
		if (cell == nil) {
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			//cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
			UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)]; 
			UIImage *accImage = [UIImage imageNamed:@"brown-arrow.png"];
			[accessoryButton setImage:accImage forState: UIControlStateNormal];
			//[accessoryButton addTarget:self action:@selector(yourMethodName) forControlEvents:UIControlEventTouchUpInside];
			[cell setAccessoryView:accessoryButton];
			[accImage release];
			
			
			UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(110, 10, 150, 40)];
			lbl.text=[[PickerHotelsArray objectAtIndex:indexPath.row] valueForKey:@"HotelName"];
			NSLog(@"hotel id %@", [[PickerHotelsArray objectAtIndex:indexPath.row] valueForKey:@"HotelID" ]);
			lbl.textColor=[UIColor whiteColor];
			[lbl setFont:[UIFont boldSystemFontOfSize:17.0]];
			lbl.numberOfLines=2;
			[lbl setBackgroundColor:[UIColor clearColor]];
			[cell addSubview:lbl];
						
			UIImageView *imgviewbg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100,60 )];
			UIImage *imgbg=[UIImage imageNamed:@"hotel_list_logo_background.png"];
			imgviewbg.image=imgbg;
			
			//UIImageView *imgviewlogo=[[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 80,50 )];
//			UIImage *imglogo=[UIImage imageNamed:@"_logo.png"];
//			imgviewlogo.image=imglogo;
//			[imgview addSubview:imgviewlogo];
//			[cell addSubview:imgview];
//			[imgview release];
						
			AppRecord *appRecord = [self.entries objectAtIndex:indexPath.row];
			// Only load cached images; defer new downloads until scrolling ends
			if (!appRecord.appIcon && appRecord.imageURLString!=nil && ((NSNull *)appRecord.imageURLString != [NSNull null]))
			{
				if (![appRecord.imageURLString isEqualToString:@""]) {
					if (Hotellisttbl.dragging == NO && Hotellisttbl.decelerating == NO)
					{
						[self startIconDownload:appRecord forIndexPath:indexPath];
					}
					// if a download is deferred or in progress, return a placeholder image
					//cell.imageView.image = [UIImage imageNamed:@"no_photo.png"];  
					UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100,60 )];
					
					[imgview setImage:[UIImage imageNamed:@"listlogo.png"]];
					[imgviewbg addSubview:imgview];
					[cell addSubview:imgviewbg];
					[imgviewbg release];
				}
			}
			else
			{
				if (appRecord.imageURLString!=nil && ((NSNull *)appRecord.imageURLString != [NSNull null])) {
					//cell.imageView.image = appRecord.appIcon;
					UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,100,60)];
					
					[imgview setImage:appRecord.appIcon];
					[imgviewbg addSubview:imgview];
					[cell addSubview:imgviewbg];
					[imgviewbg release];
				} else {
					UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,100,60 )];
					
					[imgview setImage:[UIImage imageNamed:@"listlogo.png"]];
					[imgviewbg addSubview:imgview];
					[cell addSubview:imgview];
					[imgviewbg release];
				}
				
				
			}
			
		}
		
		
		
	}
	/*else 
	{
		if (cell == nil) 
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;

			UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(110, 10, 150, 40)];
			lbl.text=[[HotelsArray objectAtIndex:indexPath.row] valueForKey:@"HotelName"];
			lbl.textColor=[UIColor whiteColor];
			[lbl setFont:[UIFont boldSystemFontOfSize:17.0]];
			lbl.numberOfLines=2;
			[lbl setBackgroundColor:[UIColor clearColor]];
			[cell addSubview:lbl];
						
			UIImageView *imgviewbg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100,60 )];
			UIImage *imgbg=[UIImage imageNamed:@"hotel_list_logo_background.png"];
			imgviewbg.image=imgbg;
			
			//UIImageView *imgviewlogo=[[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 80,50 )];
//			
//			UIImage *imglogo=[UIImage imageNamed:@"_logo.png"];
//			imgviewlogo.image=imglogo;
//			[imgviewbg addSubview:imgviewlogo];
//			[cell addSubview:imgview];
//			[imgview release];
			
			
			AppRecord *appRecord = [self.entries objectAtIndex:indexPath.row];
			// Only load cached images; defer new downloads until scrolling ends
			if (!appRecord.appIcon && appRecord.imageURLString!=nil && ((NSNull *)appRecord.imageURLString != [NSNull null]))
			{
				if (![appRecord.imageURLString isEqualToString:@""]) {
					if (Hotellisttbl.dragging == NO && Hotellisttbl.decelerating == NO)
					{
						[self startIconDownload:appRecord forIndexPath:indexPath];
					}
					// if a download is deferred or in progress, return a placeholder image
					//cell.imageView.image = [UIImage imageNamed:@"no_photo.png"];  
					UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100,60 )];
					
					[imgview setImage:[UIImage imageNamed:@"listlogo.png"]];
					[imgviewbg addSubview:imgview];
					[cell addSubview:imgviewbg];
					[imgviewbg release];
				}
			}
			else
			{
				if (appRecord.imageURLString!=nil && ((NSNull *)appRecord.imageURLString != [NSNull null])) {
					//cell.imageView.image = appRecord.appIcon;
					UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,100,60)];
					
					[imgview setImage:appRecord.appIcon];
					[imgviewbg addSubview:imgview];
					[cell addSubview:imgviewbg];
					[imgviewbg release];
				} else {
					UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,100,60 )];
					
					[imgview setImage:[UIImage imageNamed:@"listlogo.png"]];
					[imgviewbg addSubview:imgview];
					[cell addSubview:imgview];
					[imgviewbg release];
				}
				
				
			}
			
						
			
		}
	}*/
	else 
	{
				
		if (cell == nil) 
		{
			cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
			
			//cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
			UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)]; 
			UIImage *accImage = [UIImage imageNamed:@"brown-arrow.png"];
			[accessoryButton setImage:accImage forState: UIControlStateNormal];
			//[accessoryButton addTarget:self action:@selector(yourMethodName) forControlEvents:UIControlEventTouchUpInside];
			[cell setAccessoryView:accessoryButton];
			[accImage release];
			
			UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(110, 10, 150, 40)];
			lbl.text=[[taipieList objectAtIndex:indexPath.row] valueForKey:@"HotelName"];
			lbl.textColor=[UIColor whiteColor];
			[lbl setFont:[UIFont boldSystemFontOfSize:17.0]];
			lbl.numberOfLines=2;
			[lbl setBackgroundColor:[UIColor clearColor]];
			[cell addSubview:lbl];
			
			UIImageView *imgviewbg=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100,60 )];
			UIImage *imgbg=[UIImage imageNamed:@"hotel_list_logo_background.png"];
			imgviewbg.image=imgbg;
			
			//UIImageView *imgviewlogo=[[UIImageView alloc]initWithFrame:CGRectMake(10, 7, 80,50 )];
			//			
			//			UIImage *imglogo=[UIImage imageNamed:@"_logo.png"];
			//			imgviewlogo.image=imglogo;
			//			[imgviewbg addSubview:imgviewlogo];
			//			[cell addSubview:imgview];
			//			[imgview release];
			
			
			AppRecord *appRecord = [self.entries objectAtIndex:indexPath.row];
			// Only load cached images; defer new downloads until scrolling ends
			if (!appRecord.appIcon && appRecord.imageURLString!=nil && ((NSNull *)appRecord.imageURLString != [NSNull null]))
			{
				if (![appRecord.imageURLString isEqualToString:@""]) {
					if (Hotellisttbl.dragging == NO && Hotellisttbl.decelerating == NO)
					{
						[self startIconDownload:appRecord forIndexPath:indexPath];
					}
					// if a download is deferred or in progress, return a placeholder image
					//cell.imageView.image = [UIImage imageNamed:@"no_photo.png"];  
					UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100,60 )];
					
					[imgview setImage:[UIImage imageNamed:@"listlogo.png"]];
					[imgviewbg addSubview:imgview];
					[cell addSubview:imgviewbg];
					[imgviewbg release];
				}
			}
			else
			{
				if (appRecord.imageURLString!=nil && ((NSNull *)appRecord.imageURLString != [NSNull null])) {
					//cell.imageView.image = appRecord.appIcon;
					UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,100,60)];
					
					[imgview setImage:appRecord.appIcon];
					[imgviewbg addSubview:imgview];
					[cell addSubview:imgviewbg];
					[imgviewbg release];
				} else {
					UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0,0,100,60 )];
					
					[imgview setImage:[UIImage imageNamed:@"listlogo.png"]];
					[imgviewbg addSubview:imgview];
					[cell addSubview:imgview];
					[imgviewbg release];
				}
				
				
			}
			
			
			
		}
		
		
	}//end of else

	cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_stripe.png"]];
    	
	    return cell;
}

/*- (UITableViewCellAccessoryType)tableView:(UITableView *)tv accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath
{
	return UITableViewCellAccessoryDetailDisclosureButton;
}
/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
 
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source.
 [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }   
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
 }   
 }
 */


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */


/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */
- (void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath
{

	
}
#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	appDelegate.segmentIndex = 1;
	
	if([appDelegate.imageNameArrary count] > 0)
	{
		[appDelegate.imageNameArrary removeAllObjects];
		[appDelegate.imageArray removeAllObjects];
	}
	if([pickerStr isEqualToString:@"YES"])
	{
		self.HotelId = [NSString stringWithFormat:@"%@",[[PickerHotelsArray  objectAtIndex:indexPath.row] valueForKey:@"HotelID"]];
		ObjBusinessCard =[[BusinessCard alloc]initWithNibName:@"BusinessCard" bundle:nil];
		ObjBusinessCard.HotelId = self.HotelId;
		[self.navigationController pushViewController:ObjBusinessCard animated:YES];
		
	}
	/*else 
	{
		self.HotelId = [NSString stringWithFormat:@"%@",[[HotelsArray  objectAtIndex:indexPath.row] valueForKey:@"HotelID"]];
		BusinessCard *ObjBusinessCard =[[BusinessCard alloc]initWithNibName:@"BusinessCard" bundle:nil];
		ObjBusinessCard.HotelId = self.HotelId;
		[self.navigationController pushViewController:ObjBusinessCard animated:YES];
	}*/
	else 
	{
		self.HotelId = [NSString stringWithFormat:@"%@",[[taipieList  objectAtIndex:indexPath.row] valueForKey:@"HotelID"]];
		ObjBusinessCard =[[BusinessCard alloc]initWithNibName:@"BusinessCard" bundle:nil];
		ObjBusinessCard.HotelId = self.HotelId;
		[self.navigationController pushViewController:ObjBusinessCard animated:YES];
	}
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	if (standardUserDefaults) {
		[standardUserDefaults setObject:@"0" forKey:@"location"];
		[standardUserDefaults synchronize];
	}
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}
-(void) textFieldDidBeginEditing:(UITextField *)textField{
	[self createLocationPickerView];
	//return YES;
}
#pragma mark picker view
-(void)createLocationPickerView{
	actGender = [[UIActionSheet alloc] initWithTitle:@"Type"
											delegate:self
								   cancelButtonTitle:nil
							  destructiveButtonTitle:nil
								   otherButtonTitles:nil];
    pkrGender = [[UIPickerView alloc] initWithFrame:CGRectMake(0,44,0,0)];
    pkrGender.delegate=self;
    pkrGender.showsSelectionIndicator=YES;
    pkrGender.dataSource = self;
    pkrGender.hidden = NO;
    [actGender addSubview:pkrGender];
    [actGender showInView:self.view];
    [actGender setBounds:CGRectMake(0.0,0.0,320.0,460.0)];
    [actGender release];
    [pkrGender release];
	
    UIToolbar *pickerToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0,0,320,44)];
    pickerToolBar.barStyle = UIBarStyleBlackOpaque;
    NSMutableArray *barItems = [[NSMutableArray alloc] init];
	
    UIBarButtonItem *doneBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(SelectDone)];
    [barItems addObject:doneBtn];
	
    UIBarButtonItem *flexSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
    [barItems addObject:flexSpace];
	
    UIBarButtonItem *cancleBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(canclePicker)];
    [barItems addObject:cancleBtn];
	
    [pickerToolBar setItems:barItems animated:YES];   

    [actGender addSubview:pickerToolBar];

    [actGender addSubview:pkrGender];

    [actGender showInView:self.view];
	appDelegate = (imvrAppDelegate*)[UIApplication sharedApplication].delegate;
	[actGender showFromTabBar:appDelegate.tabBarController.tabBar];

    [actGender setBounds:CGRectMake(0.0,0.0,320.0,420.0)];
	
    [barItems release];
    [flexSpace release];
    [pickerToolBar release];
	
	
}
-(void)SelectDone{
	
	[actGender dismissWithClickedButtonIndex:0 animated:YES];
	PickerHotelsArray=[[NSMutableArray alloc]init];
	for (int i=0; i<[HotelsArray count]; i++) 
	{
		NSMutableDictionary *PickerHotelDic;//=[[NSMutableDictionary alloc]init];

		if ([self.mKey isEqualToString:[NSString stringWithFormat:@"%@",[[HotelsArray objectAtIndex:i] valueForKey:@"AreaID"]]]) 
		{
			 PickerHotelDic=[[NSMutableDictionary alloc]init];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"Address"] forKey:@"Address"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"Area"] forKey:@"Area"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"AreaID"] forKey:@"AreaID"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"Fax"] forKey:@"Fax"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"HotelID"] forKey:@"HotelID"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"HotelName"] forKey:@"HotelName"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"HotelUrl"] forKey:@"HotelUrl"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"LogoUrl"] forKey:@"LogoUrl"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"Phone"] forKey:@"Phone"];
			[PickerHotelDic setObject:[[HotelsArray objectAtIndex:i] valueForKey:@"Email"] forKey:@"Email"];
			
			NSLog(@"Add Email : %@",[[HotelsArray objectAtIndex:i] valueForKey:@"Email"]);
			[PickerHotelsArray addObject:PickerHotelDic];
			
			[PickerHotelDic release];
		}
		
		
	}
	if([mKey isEqualToString:@"0"])
	{
		PickerHotelsArray = HotelsArray;
	}
	pickerStr=@"YES";
	//cleaning up all the downloaded images and also stopping the downloading images
	[self cleanup];
	[self.entries removeAllObjects];
	[self fixTableAgain];
	[self fillTheIconArray];
	[Hotellisttbl reloadData];
	lblCity.text  = [[AreaArray objectAtIndex:pickerRow] valueForKey:@"AreaName"];
	lastTitle = [[AreaArray objectAtIndex:pickerRow] valueForKey:@"AreaName"];
	NSLog(@"ArrayY %@", [PickerHotelsArray description]);
}

-(void)canclePicker
{
    lblCity.text = lastTitle;
	[actGender dismissWithClickedButtonIndex:0 animated:YES];
}

//#pragma mark pickerView Method
//
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
       return 1;
	
	
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    //if(pickerView == pkrGender){
	
	return [AreaArray count];
    //    }
	
}
- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
	
	//return    [[HotelsArray objectAtIndex:row ] valueForKey:@"Area"];
	//NSLog(@"locArray : %@",locArray);
	return [[AreaArray objectAtIndex:row ] valueForKey:@"AreaName"];
	//return @"Test";
	
}
- (void)pickerView:(UIPickerView *)thePickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
	
	//txtLocation.text = [locArray objectAtIndex:row];
	pickerRow = row;
	lblCity.text  = [[AreaArray objectAtIndex:row] valueForKey:@"AreaName"];
	
	self.mKey = [[AreaArray objectAtIndex:row] valueForKey:@"AreaID"];
	//NSLog(@"locArray : %@",locArray);
	//NSLog(@"key for current selected field is : %@",[[locArray objectAtIndex:row] valueForKey:@"AreaID"]);
	
	
	
}

-(void) cleanup 
{
	//Pop back to main View
	NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
	//[imageDownloadsInProgress removeAllObjects];
	//imageDownloadsInProgress = nil;
	//[self.imageDownloadsInProgress release];
	//imageDownloadsInProgress= [NSMutableDictionary dictionary];
	[allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
	
}
- (void) fillTheIconArray 
{
	if ([pickerStr isEqualToString:@"YES"])
	{
		
		[self.imageDownloadsInProgress retain];
		self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
		for (int i = 0; i<[self.PickerHotelsArray count]; i++) 
		{
			AppRecord *appRecord = [[AppRecord alloc] init];
			NSLog(@">>>> %@", [[PickerHotelsArray objectAtIndex:i] valueForKey:@"LogoUrl"]);
			appRecord.imageURLString = [[self.PickerHotelsArray objectAtIndex:i] valueForKey:@"LogoUrl"];
			[self.entries addObject:appRecord];
			[appRecord release];
		}
	}
	/*else 
	{	
		for (int i = 0; i<[self.HotelsArray count]; i++) 
		{
			AppRecord *appRecord = [[AppRecord alloc] init];
			NSLog(@">>>> %@", [[self.HotelsArray objectAtIndex:i] valueForKey:@"LogoUrl"]);
			appRecord.imageURLString = [[self.HotelsArray objectAtIndex:i] valueForKey:@"LogoUrl"];
			[self.entries addObject:appRecord];
			[appRecord release];
		}
	}*/
	else 
	{	
		for (int i = 0; i<[self.taipieList count]; i++) 
		{
			AppRecord *appRecord = [[AppRecord alloc] init];
			NSLog(@">>>> %@", [[self.taipieList objectAtIndex:i] valueForKey:@"LogoUrl"]);
			appRecord.imageURLString = [[self.taipieList objectAtIndex:i] valueForKey:@"LogoUrl"];
			[self.entries addObject:appRecord];
			[appRecord release];
		}
	}
	//[Hotellisttbl reloadData];
	
}


#pragma mark Downloading logo
- (void)startIconDownload:(AppRecord *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
			NSLog(@"________indexpath.row=%d",indexPath.row);
			IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
			if (iconDownloader == nil) 
			{
				iconDownloader = [[IconDownloader alloc] init];
				iconDownloader.appRecord = appRecord;
				iconDownloader.indexPathInTableView = indexPath;
				iconDownloader.delegate = self;
				[imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
				[iconDownloader startDownload];
				[iconDownloader release];   
				[appRecord release];
			}
		
}
									
// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
			if ([self.entries count] > 0)
			{
				NSArray *visiblePaths = [Hotellisttbl indexPathsForVisibleRows];
				for (NSIndexPath *indexPath in visiblePaths)
				{
					AppRecord *appRecord = [self.entries objectAtIndex:indexPath.row];
					
					if (!appRecord.appIcon) // avoid the app icon download if the app already has an icon
					{
						if (appRecord.imageURLString==nil || ((NSNull *)appRecord.imageURLString == [NSNull null])) {
							//					UITableViewCell *cell = [SearchResultTbl cellForRowAtIndexPath:indexPath];
							//					UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(5, 15, 50,50 )];
							//					
							//					[imgview setImage:[UIImage imageNamed:@"no_photo.png"]];
							//					[cell addSubview:imgview];
							//					[imgview release];
						}else {
							[self startIconDownload:appRecord forIndexPath:indexPath];
						}                
					} else {
						UITableViewCell *cell = [Hotellisttbl cellForRowAtIndexPath:indexPath];
						cell.imageView.image = appRecord.appIcon;
					}
					
				}
			}
}
									
// called by our ImageDownloader when an icon is ready to be displayed
- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
			IconDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
			if (iconDownloader != nil)
			{
				UITableViewCell *cell = [Hotellisttbl cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
				
				// Display the newly loaded image
				//cell.imageView.image = iconDownloader.appRecord.appIcon;
				//-------
				//for hiding the previous default log
				UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 100,60)];
				[img setImage:[UIImage imageNamed:@"listlogoclear.png"]];
				[cell addSubview:img];
				[img release];
				
				//--------
				UIImageView *imgview=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 100,60 )];
				[imgview setImage:iconDownloader.appRecord.appIcon];
				[cell addSubview:imgview];
				[imgview release];
				
				//		AppRecord *appRecord = [self.entries objectAtIndex:indexPath.row];
				//		appRecord.appIcon = iconDownloader.appRecord.appIcon;
				//		[appRecord release];
			}
}
								
									
#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)
									
// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
	if (!decelerate)
	{
		[self loadImagesForOnscreenRows];
	}
}
									
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
	[self loadImagesForOnscreenRows];
}
									




- (void)dealloc 
{
	NSLog(@"HotellistView's dealloc...?");
	
	[Hotellisttbl release];
	[HotelsArray release];
	[HotelsDic release];
	[locCategory release];
	[locCategoryAll release];
	[locArray release];
	[currentElementValue release];
	[av release];
	[actInd release];
	[txtLocation release];
	[actGender release];
	[pkrGender release];
	[arrayGender release];
	[mKey release];
	[tempKey release];
	[tempArea release];
	[conn release];
	[xmlParser release];
	[webData release];
	[appDelegate release];
	[svimg release];
	[btnLogo release];
	[AreaArray release];
	[DataArray release];
	[lblCity release];
	[pickerStr release];
	[PickerHotelsArray release];
	
	[logoArray release];
	[imageDownloadsInProgress release];
	[HotelId release];
	
	[entries release]; 
	[lastTitle release];
	[taipieList release];
	
	[ObjBusinessCard release];
	
	
	
    [super dealloc];
}


@end
