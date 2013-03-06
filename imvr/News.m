//
//  News.m
//  imvr
//
//  Created by Yaseen Mansuri on 16/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "News.h"
#import "InfoReader.h"
#import "BusinessCard.h"
//#import "alertmessage.h"
@implementation News
@synthesize adBannerView = _adBannerView;
@synthesize adBannerViewIsVisible = _adBannerViewIsVisible;
@synthesize contentView = _contentView;
@synthesize HotelId;
@synthesize tableRowCount;

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
	
	appDelegate = (imvrAppDelegate *)[UIApplication sharedApplication].delegate;
	
	startwith =0;
	endwith = 9;
	
	tableRowCount = 9;
	count = 0;
	lastCount = 0;
	previousCount = 0;
	if(appDelegate.IscallWebservice)
	{
		//[self Hidealert];
		[self Call_WebService];
		[self fixTableAndButton];
	}
	
	moreFlag = NO;
	
}

-(void)viewWillAppear:(BOOL)animated 
{  
     /*[super viewWillAppear:animated];  
     for(UIView *view in self.tabBarController.tabBar.subviews) 
	 {  
         if([view isKindOfClass:[UIImageView class]]) {  
             [view removeFromSuperview];  
         }  
     }  
   
     [self.tabBarController.tabBar insertSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background_location.png"]] autorelease] atIndex:0];  
	  */
	  
}  



-(void)ShowAlert
{
	
	NSAutoreleasePool *pool = [[ NSAutoreleasePool alloc] init];
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
	
	[self ShowAlert];
	//[self performSelectorInBackground:@selector(ShowAlert) withObject:nil];
	NSURL *url;
	
		
	url = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.imvr.net/iphonexml/getnews.php?start=%d&end=%d",startwith,endwith]];
	//url = [NSURL URLWithString:@"http://www.imvr.net/iphonexml/getnews.php"];
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



- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict 
{
	
	if([elementName isEqualToString:@"HotelTable"]) 
	{
		//Initialize the array.
		if(NewsArray == nil)
			NewsArray = [[NSMutableArray alloc] init];
		
		HotelsArray = [[NSMutableArray alloc] init];

	}
	else if([elementName isEqualToString:@"HotelNews"]) {
		
		//Initialize the book.
		NewsDic = [[NSMutableDictionary alloc] init];
		
	}
	
	else if([elementName isEqualToString:@"Hotel"]) {
		
		HotelsDic = [[NSMutableDictionary alloc] init];
		
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{ 
	
	currentElementValue = [[NSMutableString alloc] init];
	[currentElementValue appendString:string];
	
	
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName 
{
	
	if([elementName isEqualToString:@"HotelTable"])
		return;
	
	else if([elementName isEqualToString:@"HotelNews"]) 
	{
		[NewsArray addObject:NewsDic];
		[NewsDic release];
		
	}
	
	else if([elementName isEqualToString:@"HotelID"]||[elementName isEqualToString:@"HotelName"]||[elementName isEqualToString:@"NewsID"]||[elementName isEqualToString:@"NewsTitle"]||[elementName isEqualToString:@"NewsContent"] )
	{
	  	[NewsDic setObject:currentElementValue forKey:elementName];
	}
	
	
	else if([elementName isEqualToString:@"Hotel"]) 
	{
		[HotelsArray addObject:HotelsDic];
		NSLog(@"HotelsArray :%@",[HotelsArray description]);
		[HotelsDic release];
	}	
}


- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	[self Hidealert];
	
	NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
	[dic setObject:@"" forKey:@"HotelID"];
	[dic setObject:@"" forKey:@"HotelName"];
	[dic setObject:@"" forKey:@"NewsContent"];
	[dic setObject:@"" forKey:@"NewsID"];
	[dic setObject:@"更多情報" forKey:@"NewsTitle"];
	[NewsArray addObject:dic];
	[dic release];
	
	
	
	NSLog(@"count %d", [NewsArray count]);
	NSLog(@"%@", [NewsArray description]);
	[Newstbl reloadData];

}
/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}
-(void) viewDidAppear:(BOOL)animated{
//	NSLog(@"didview");
	[super viewDidAppear:animated];
}
- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    /*NSString *CellIdentifier = [NSString stringWithFormat:@"Cell%d", indexPath.row];

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	// UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
	cell = nil;
	if (cell!=nil) {
		cell=nil;
	}
	*/
	UITableViewCell *cell  = [[[UITableViewCell alloc] initWithFrame:CGRectZero
														   reuseIdentifier:CellIdentifier] autorelease];
	if (cell == nil)
	{
		cell = [[[UITableViewCell alloc] initWithFrame:CGRectZero
									   reuseIdentifier:CellIdentifier] autorelease];
	}
	
    //if (cell == nil) {
    //    cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		//For right Arrow Button
		
	cell.backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_stripe.png"]];
	
	/*UIImageView *backview = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_stripe.png"]];
	if (backview == nil)
	{
		
		backview = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 320,70 )];
		[backview setTag:1];
		[cell addSubview:backview];
		[backview release];
	}*/
	
	
		if([NewsArray count] == indexPath.row+1)
		{
			cell.accessoryType = UITableViewCellAccessoryNone;
			
			UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(5, 2, 270, 50)];
			lbl.text=[[NewsArray objectAtIndex:indexPath.row] valueForKey:@"NewsTitle"];
			lbl.textColor=[UIColor whiteColor];
			lbl.textAlignment = UITextAlignmentCenter;
			lbl.backgroundColor = [UIColor redColor];
			[lbl setFont:[UIFont boldSystemFontOfSize:14]];
			lbl.numberOfLines=3;
			[lbl setBackgroundColor:[UIColor clearColor]];
			[cell addSubview:lbl];
			
			
		}
		else 
		{
			//cell.accessoryType = UITableViewCellAccessoryDetailDisclosureButton;
			
			UIButton *accessoryButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)]; 
			UIImage *accImage = [UIImage imageNamed:@"brown-arrow.png"];
			[accessoryButton setImage:accImage forState: UIControlStateNormal];
			//[accessoryButton addTarget:self action:@selector(yourMethodName) forControlEvents:UIControlEventTouchUpInside];
			[cell setAccessoryView:accessoryButton];
			[accImage release];
			
			UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(5, 2, 270, 50)];
			lbl.text=[[NewsArray objectAtIndex:indexPath.row] valueForKey:@"NewsTitle"];
			lbl.textColor=[UIColor whiteColor];
			[lbl setFont:[UIFont boldSystemFontOfSize:14]];
			lbl.numberOfLines=3;
			[lbl setBackgroundColor:[UIColor clearColor]];
			[cell addSubview:lbl];
		}
		
	//}
  
	
	    return cell;
}


/*
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section 
{
    //differ between your sections or if you
    //have only on section return a static value
    return 70;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section 
{
	
    if(footerView == nil) 
	{
        //allocate the view if it doesn't exist yet
        footerView  = [[UIView alloc] init];
		
        //we would like to show a gloosy red button, so get the image first
        UIImage *image = [[UIImage imageNamed:@"backimage.png"]  stretchableImageWithLeftCapWidth:8 topCapHeight:8];
		
        //create the button
        UIButton *button = [UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button setBackgroundImage:image forState:UIControlStateNormal];
		
        //the button should be as big as a table view cell
        [button setFrame:CGRectMake(10, 3, 300, 44)];
		
        //set title, font size and font color
        [button setTitle:@"More News" forState:UIControlStateNormal];
        [button.titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
		
        //set action of the button
        [button addTarget:self action:@selector(btnMoreClicked:) forControlEvents:UIControlEventTouchUpInside];
		
        //add the button to the view
        [footerView addSubview:button];
    }
	
    //return the view for the footer
    return footerView;
}
*/


/*
- (NSString *)tableView:(UITableView *)tableView titleForFooterInSection:(NSInteger)section 
{
	
	return @"Some footer text";
	
}
 
 */

#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath 
{
	appDelegate.segmentIndex = 2;
	
	if([appDelegate.imageNameArrary count] > 0)
	{
		[appDelegate.imageNameArrary removeAllObjects];
		[appDelegate.imageArray removeAllObjects];
	}
	NSLog(@"count %d", [NewsArray count]);
	NSLog(@"%d", indexPath.row);
	if([NewsArray count] == indexPath.row+1)
	{
		[self btnMoreClicked];
	}
	else
	{
		self.HotelId = [NSString stringWithFormat:@"%@",[[NewsArray  objectAtIndex:indexPath.row] valueForKey:@"HotelID"]];
		ObjBusinessCard =[[BusinessCard alloc]initWithNibName:@"BusinessCard" bundle:nil];
		ObjBusinessCard.HotelId = self.HotelId;
		[self.navigationController pushViewController:ObjBusinessCard animated:YES];
	}
	
}






#pragma mark Fix Table &  More Button

-(void)fixTableAndButton
{
	CGRect cgRct = CGRectMake(0, 44, 320, 364); 
	
	Newstbl = [[UITableView alloc] initWithFrame:cgRct style:UITableViewStylePlain];
	Newstbl.editing = NO;  
	Newstbl.dataSource = self;
	Newstbl.delegate = self; 
	Newstbl.backgroundColor = [UIColor clearColor];
	Newstbl.rowHeight=70;
	[Newstbl setSeparatorStyle:UITableViewCellSeparatorStyleNone];
	[self.view addSubview:Newstbl];
	
	
	//btnMore = [UIButton buttonWithType:UIButtonTypeCustom];
//	btnMore.frame = CGRectMake(0, 365, 320, 44);
//	[btnMore setTitle:@"More News" forState:UIControlStateNormal];
//	btnMore.backgroundColor = [UIColor clearColor];
//	btnMore.titleLabel.font = [UIFont fontWithName:@"Trebuchet MS" size: 18.0f];
//	[btnMore setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
//	[btnMore setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//	[btnMore addTarget:self action:@selector(btnMoreClicked:) forControlEvents:UIControlEventTouchUpInside];
//	[self.view addSubview:btnMore];
	
	
}

#pragma mark More Button Click

/*
-(void)btnMoreClicked
{
	if([NewsArray count] < 21)
	{
		endFlag = TRUE;
	}
	
	
	if(endFlag)
	{
		NSString *message = @"There are no more News Do you want to start from first";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
		[alert show];
		[alert release];
				
		endFlag = FALSE;
	}
	
	else
	{				  
		startwith = startwith +20;
		endwith = endwith +20;
		[self Call_WebService];
	}
}
*/

-(void)btnMoreClicked
{
	lastCount = [NewsArray count];
	if(lastCount == previousCount)
	{
		NSString *message = @"There are no more News Do you want to start from first";
		UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:message delegate:self cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
		[alert show];
		[alert release];
	}
	else 
	{
		
		previousCount = lastCount;
		[NewsArray removeLastObject];
		startwith = startwith +10;
		endwith = endwith + 10;
		[self Call_WebService];
		
	}
	
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		startwith = 0;
		endwith = 9;
		lastCount = 0;
		previousCount = 0;
		[NewsArray removeAllObjects];
		[self Call_WebService];	
	}
	else 
	{
		
		//moreFlag = YES;
		[NewsArray removeLastObject];
		NSMutableDictionary *dic = [[NSMutableDictionary alloc] init];
		[dic setObject:@"" forKey:@"HotelID"];
		[dic setObject:@"" forKey:@"HotelName"];
		[dic setObject:@"" forKey:@"NewsContent"];
		[dic setObject:@"" forKey:@"NewsID"];
		[dic setObject:@"No More News" forKey:@"NewsTitle"];
		[NewsArray addObject:dic];
		[dic release];
		
		
		[Newstbl reloadData];
	}

}



#pragma mark tabbar method
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
	
	for(UIView *view in tabBarController.tabBar.subviews) 
	{
		if([view isKindOfClass:[UIImageView class]]) 
		{
			[view removeFromSuperview];
		}
	}
	
	[tabBarController.tabBar addSubview:[[[UIImageView alloc] initWithImage:[UIImage imageNamed:[NSString stringWithFormat:@"ico_map_pin_address.png",tabBarController.selectedIndex+1]]] autorelease]];
	
}

/*
#pragma mark -
#pragma mark Banner view delegate

- (int)getBannerHeight:(UIDeviceOrientation)orientation {
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        return 32;
    } else {
        return 40;
    }
}

- (int)getBannerHeight {
    return [self getBannerHeight:[UIDevice currentDevice].orientation];
}

- (void)createAdBannerView {
    Class classAdBannerView = NSClassFromString(@"ADBannerView");
    if (classAdBannerView != nil) {
        self.adBannerView = [[[classAdBannerView alloc] initWithFrame:CGRectZero] autorelease];
        [_adBannerView setRequiredContentSizeIdentifiers:[NSSet setWithObjects: ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil]];
        if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierLandscape];
        } else {
            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];            
        }
        [_adBannerView setFrame:CGRectOffset([_adBannerView frame], 0, -[self getBannerHeight])];
        [_adBannerView setDelegate:self];
        
        [self.view addSubview:_adBannerView];        
    }
}

- (void)fixupAdView:(UIInterfaceOrientation)toInterfaceOrientation {
    if (_adBannerView != nil) {        
        if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierLandscape];
        } else {
            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];
        }          
        [UIView beginAnimations:@"fixupViews" context:nil];
        if (_adBannerViewIsVisible) {
            CGRect adBannerViewFrame = [_adBannerView frame];
            adBannerViewFrame.origin.x = 0;
            adBannerViewFrame.origin.y = 664;
            [_adBannerView setFrame:adBannerViewFrame];
            CGRect contentViewFrame = _contentView.frame;
            contentViewFrame.origin.y = [self getBannerHeight:toInterfaceOrientation];
            contentViewFrame.size.height = self.view.frame.size.height - [self getBannerHeight:toInterfaceOrientation];
            _contentView.frame = contentViewFrame;
        } else {
            CGRect adBannerViewFrame = [_adBannerView frame];
            adBannerViewFrame.origin.x = 0;
            adBannerViewFrame.origin.y = -[self getBannerHeight:toInterfaceOrientation];
            [_adBannerView setFrame:adBannerViewFrame];
            CGRect contentViewFrame = _contentView.frame;
            contentViewFrame.origin.y = 664;
            contentViewFrame.size.height = self.view.frame.size.height;
            _contentView.frame = contentViewFrame;            
        }
        [UIView commitAnimations];
    }   
}


#pragma mark ADBannerViewDelegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!_adBannerViewIsVisible) {                
        _adBannerViewIsVisible = YES;
        [self fixupAdView:[UIDevice currentDevice].orientation];
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (_adBannerViewIsVisible)
    {        
        _adBannerViewIsVisible = NO;
        [self fixupAdView:[UIDevice currentDevice].orientation];
    }
}
*/

- (void)dealloc 
{
	[Newstbl release];
	[NewsArray release];
	[NewsDic release];
	[currentElementValue release];
	[myWebData release];
	[myXMLParser release];
	[TmpStr release]; 
	[soapMssg release];
	[fileName  release];
	
	[TagDict release];
	[soapDic release];
	[innerDict release];
	[objGetHotelModel release];
	[dataArr release];
	[modelObj release];
	[levelData release];
	[innerArr release];
	[tempstr release];
	[av release];
	[actInd release];
	[conn release];
	[xmlParser release];
	[webData release];
	[SelectedCellStr release];
	[HotelId release];
	[HotelsArray release];
	[HotelsDic release];
	[_adBannerView release];
	[_contentView release];
	[btnMore release];
	
	[appDelegate release];
	[footerView  release];
	
	[ObjBusinessCard release];
	
	
	
    [super dealloc];
}


@end
