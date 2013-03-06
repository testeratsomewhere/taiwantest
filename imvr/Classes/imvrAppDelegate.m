//
//  imvrAppDelegate.m
//  imvr
//
//  Created by Yaseen Mansuri on 16/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "imvrAppDelegate.h"
#import "RootViewController.h"
#import "AppConfig.h"
#import <AudioToolbox/AudioToolbox.h>

@implementation CustomTabbarController
@end
@implementation imvrAppDelegate

@synthesize window;
@synthesize navigationController;
@synthesize tabBarController,flagstr,IscallWebservice,AreaArray,HotelDataArray;
@synthesize mapFlag;
@synthesize segmentIndex;
@synthesize imageNameArrary;
@synthesize imageArray;
@synthesize roomIDArray;
@synthesize imageFlag;
@synthesize imageCount, imageNo;
@synthesize roomImagesArray;
@synthesize specificRoomImagesArray;
@synthesize roomImageFlag, specificRoomImageFlag;
@synthesize specificImageFlag;
@synthesize orientationCounter;

#pragma mark -
#pragma mark Application lifecycle

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    
    
    // Override point for customization after application launch.
    NSLog(@"a");
	IscallWebservice=NO;
	imageFlag = NO;
	
    // Add the navigation controller's view to the window and display.
    [self.window addSubview:navigationController.view];
    [self.window makeKeyAndVisible];
	//[self tabBarControllerView];
	
	[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
	//[[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
	//UIApplication *application = [UIApplication sharedApplication];
	application.applicationIconBadgeNumber = 0;
	
	imageNameArrary = [[NSMutableArray alloc] init];
	imageArray = [[NSMutableArray alloc] init];
	roomIDArray =[[NSMutableArray alloc] init];
	roomImagesArray = [[NSMutableArray alloc] init];
	specificRoomImagesArray	= [[NSMutableArray	alloc] init];
	[self Call_WebService];
	
	orientationCounter = 0;
	
    return YES;
}

-(void)tabBarControllerView{
	NSLog(@"b");
	IscallWebservice=YES;
	tabBarController.navigationController.navigationBarHidden = YES;
	tabBarController.selectedIndex = 0;
	tabBarController.delegate=self;
	
	 
	[window addSubview:tabBarController.view];
	[window makeKeyAndVisible];
}	
- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
	application.applicationIconBadgeNumber = 0;
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, called instead of applicationWillTerminate: when the user quits.
     */
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of  transition from the background to the inactive state: here you can undo many of the changes made on entering the background.
     */
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}


- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     See also applicationDidEnterBackground:.
     */
}


#pragma mark -
#pragma mark Memory management

- (void)applicationDidReceiveMemoryWarning:(UIApplication *)application {
    /*
     Free up as much memory as possible by purging cached data objects that can be recreated (or reloaded from disk) later.
     */
}


#pragma mark -
#pragma mark Parse xml for location category
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
	
	url = [[NSURL alloc] initWithString:@"http://www.imvr.net/iphonexml/locationcategory.php"];
		
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
	
	if([elementName isEqualToString:@"AreaTable"]) 
	{
		//Initialize the array.
		AreaArray = [[NSMutableArray alloc] init];
		
	}
	else if([elementName isEqualToString:@"Area"]) 
	{
		AreaDic = [[NSMutableDictionary alloc] init];
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{ 
		
	currentElementValue = [[NSMutableString alloc] init];
	
	[currentElementValue appendString:string];
	
	
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:@"AreaTable"])
	{
		AreaDic = [[NSMutableDictionary alloc] init];
		[AreaDic setObject:@"0" forKey:@"AreaID"];
		[AreaDic setObject:@"All" forKey:@"AreaName"];
		[AreaArray addObject:AreaDic];
		[AreaDic release];
		return;
	}
	else if([elementName isEqualToString:@"Area"]) 
	{
		[AreaArray addObject:AreaDic];
		[AreaDic release];
		
	}	
	else if([elementName isEqualToString:@"AreaID"]||[elementName isEqualToString:@"AreaName"] ){
		[AreaDic setObject:currentElementValue forKey:elementName];
		
	}
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser{
	//[alertmessage hideAlert];
	//[self performSelectorInBackground:@selector(Hidealert) withObject:nil];
	
	//NSLog(@"End Parsing Array : %@",[AreaArray description]);
	
	
	//[av dismissWithClickedButtonIndex:0 animated:YES];
	
	//[locArray addObject:locCategoryAll];
	//((imvrAppDelegate*)[[UIApplication sharedApplication]delegate]).tabBarController.selectedIndex=1;
	
}


/*
 * ------------------------------------------------------------------------------------------
 *  BEGIN APNS CODE
 * ------------------------------------------------------------------------------------------
 */

/**
 * Fetch and Format Device Token and Register Important Information to Remote Server
 */
- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)devToken {
	
#if !TARGET_IPHONE_SIMULATOR
	
	// Get Bundle Info for Remote Registration (handy if you have more than one app)
	NSString *appName = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"];
	NSString *appVersion = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"];
	
	// Check what Notifications the user has turned on.  We registered for all three, but they may have manually disabled some or all of them.
	NSUInteger rntypes = [[UIApplication sharedApplication] enabledRemoteNotificationTypes];
	
	// Set the defaults to disabled unless we find otherwise...
	NSString *pushBadge = @"disabled";
	NSString *pushAlert = @"disabled";
	NSString *pushSound = @"disabled";
	
	// Check what Registered Types are turned on. This is a bit tricky since if two are enabled, and one is off, it will return a number 2... not telling you which
	// one is actually disabled. So we are literally checking to see if rnTypes matches what is turned on, instead of by number. The "tricky" part is that the
	// single notification types will only match if they are the ONLY one enabled.  Likewise, when we are checking for a pair of notifications, it will only be
	// true if those two notifications are on.  This is why the code is written this way
	if(rntypes == UIRemoteNotificationTypeBadge){
		pushBadge = @"enabled";
	}
	else if(rntypes == UIRemoteNotificationTypeAlert){
		pushAlert = @"enabled";
	}
	else if(rntypes == UIRemoteNotificationTypeSound){
		pushSound = @"enabled";
	}
	else if(rntypes == ( UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert)){
		pushBadge = @"enabled";
		pushAlert = @"enabled";
	}
	else if(rntypes == ( UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)){
		pushBadge = @"enabled";
		pushSound = @"enabled";
	}
	else if(rntypes == ( UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)){
		pushAlert = @"enabled";
		pushSound = @"enabled";
	}
	else if(rntypes == ( UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeSound)){
		pushBadge = @"enabled";
		pushAlert = @"enabled";
		pushSound = @"enabled";
	}
	
	// Get the users Device Model, Display Name, Unique ID, Token & Version Number
	UIDevice *dev = [UIDevice currentDevice];
	NSString *deviceUuid = dev.uniqueIdentifier;
    NSString *deviceName = dev.name;
	NSString *deviceModel = dev.model;
	NSString *deviceSystemVersion = dev.systemVersion;
	
	// Prepare the Device Token for Registration (remove spaces and < >)
	NSString *deviceToken = [[[[devToken description]
							   stringByReplacingOccurrencesOfString:@"<"withString:@""]
							  stringByReplacingOccurrencesOfString:@">" withString:@""]
							 stringByReplacingOccurrencesOfString: @" " withString: @""];
	
	// Build URL String for Registration
	// !!! CHANGE "www.mywebsite.com" TO YOUR WEBSITE. Leave out the http://
	// !!! SAMPLE: "secure.awesomeapp.com"
	NSString *host = @"apns.demo.complitech.net";
	
	// !!! CHANGE "/apns.php?" TO THE PATH TO WHERE apns.php IS INSTALLED
	// !!! ( MUST START WITH / AND END WITH ? ).
	// !!! SAMPLE: "/path/to/apns.php?"
	NSString *urlString = [@"/apns.php?" stringByAppendingString:@"task=register"];
	
	urlString = [urlString stringByAppendingString:@"&appname="];
	urlString = [urlString stringByAppendingString:appName];
	urlString = [urlString stringByAppendingString:@"&appversion="];
	urlString = [urlString stringByAppendingString:appVersion];
	urlString = [urlString stringByAppendingString:@"&deviceuid="];
	urlString = [urlString stringByAppendingString:deviceUuid];
	urlString = [urlString stringByAppendingString:@"&devicetoken="];
	urlString = [urlString stringByAppendingString:deviceToken];
	urlString = [urlString stringByAppendingString:@"&devicename="];
	urlString = [urlString stringByAppendingString:deviceName];
	urlString = [urlString stringByAppendingString:@"&devicemodel="];
	urlString = [urlString stringByAppendingString:deviceModel];
	urlString = [urlString stringByAppendingString:@"&deviceversion="];
	urlString = [urlString stringByAppendingString:deviceSystemVersion];
	urlString = [urlString stringByAppendingString:@"&pushbadge="];
	urlString = [urlString stringByAppendingString:pushBadge];
	urlString = [urlString stringByAppendingString:@"&pushalert="];
	urlString = [urlString stringByAppendingString:pushAlert];
	urlString = [urlString stringByAppendingString:@"&pushsound="];
	urlString = [urlString stringByAppendingString:pushSound];
	
	// Register the Device Data
	// !!! CHANGE "http" TO "https" IF YOU ARE USING HTTPS PROTOCOL
	NSURL *url = [[NSURL alloc] initWithScheme:@"http" host:host path:urlString];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
	NSData *returnData = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];
	NSLog(@"Register URL: %@", url);
	
	//NSString* aStr;
	
	//aStr = [[NSString alloc] initWithData:returnData encoding:NSASCIIStringEncoding];
	//[self alertNotice:@"" withMSG:aStr cancleButtonTitle:@"Ok" otherButtonTitle:@""];
	NSLog(@"Return Data: %@", returnData);
	
#endif
}

/**
 * Failed to Register for Remote Notifications
 */
- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error {
	
#if !TARGET_IPHONE_SIMULATOR
	
	NSLog(@"Error in registration. Error: %@", error);
	
#endif
}

/**
 * Remote Notification Received while application was open.
 */

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
	
#if !TARGET_IPHONE_SIMULATOR
	
	NSLog(@"remote notification: %@",[userInfo description]);
	NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];
	
	NSString *alert = [apsInfo objectForKey:@"alert"];
	NSLog(@"Received Push Alert: %@", alert);
	
	NSString *sound = [apsInfo objectForKey:@"sound"];
	NSLog(@"Received Push Sound: %@", sound);
	AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
	
	NSString *badge = [apsInfo objectForKey:@"badge"];
	NSLog(@"Received Push Badge: %@", badge);
	application.applicationIconBadgeNumber = [[apsInfo objectForKey:@"badge"] integerValue];
	
#endif
}

/*
 * ------------------------------------------------------------------------------------------
 *  END APNS CODE
 * ------------------------------------------------------------------------------------------
 */


- (void)dealloc 
{
	
	[addressArray release];
	[flagstr release];
	[AreaArray release];
	[AreaDic release];
	[currentElementValue release];
	[conn  release];
	[xmlParser release];
	[webData release];
	[av release];
	[actInd release];
	[HotelDataArray release];
	[imageNameArrary release];
	[imageArray release];
	[roomIDArray release];
	[roomImagesArray release];
	[specificRoomImagesArray release];
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

