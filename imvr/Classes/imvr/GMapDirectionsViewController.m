    //
//  GMapDirections.m
//  Maps
//
//  Created by Cory Wiles on 3/20/10.
//  Copyright 2010 Wiles, LLC. All rights reserved.
//

#import "GMapDirectionsViewController.h"
#import "Map.h"

#define BARBUTTON(TITLE, SELECTOR) 	[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]//UIBarButtonItem
#define TOOLBAR 102


@implementation GMapDirectionsViewController

@synthesize webView;
@synthesize latitude;
@synthesize longitude;
@synthesize activeIndicator;
@synthesize toolBar;
@synthesize mapsButton;
@synthesize tbar;


- (void)viewDidLoad 
{
  
  //NSLog(@"lat: %@", latitude);
//  NSLog(@"long:  %@", longitude);
//  
//  NSString *url         = [NSString stringWithFormat:@"%@?lat=%@&long=%@", 
//                           [[NSBundle mainBundle] pathForResource:@"map" 
//                                                           ofType:@"html"], 
//                           latitude, 
//                           longitude];
//
//  NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
//  
//  webView.delegate = self;
//  
//  [webView loadRequest:request]
 //---------
	//if(self == nil){
	
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *hotelAddress = nil;
	
	if (standardUserDefaults) 
		hotelAddress = [standardUserDefaults objectForKey:@"currentaddress"];
	
	NSString *urlstr = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@&mrt=yp",
					 [hotelAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	
	NSURL *url = [NSURL URLWithString:urlstr];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	//Load the request in the UIWebView.
	[webView loadRequest:requestObj];
	
	
	//[[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
  [super viewDidLoad];

	appDelegate = (imvrAppDelegate *)[UIApplication sharedApplication].delegate;
	appTabBar = (CustomTabBar *)appDelegate.tabBarController;
	[appTabBar hideTabBar];
	
	
	toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 430, 320.0,44)];
	[toolbar setTag:TOOLBAR];
	toolbar.barStyle = self.navigationController.navigationBar.barStyle;
	
	UIBarButtonItem *PreBtn = BARBUTTON(@"Back", @selector(back));
	//UIBarButtonItem *PreBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_back.png"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
	
	UIBarButtonItem *Item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	UIBarButtonItem *Item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	UIBarButtonItem *NextBtn = BARBUTTON(@"goolge導航", @selector(openGoogleMapsApp:));
	//UIBarButtonItem *NextBtn = [[UIBarButtonItem alloc] initWithTitle:@"goolge導航" style:UIBarButtonItemStylePlain target:self action:@selector(openGoogleMapsApp:)];
	
	
	NSArray *items = [NSArray arrayWithObjects: PreBtn, Item1, Item2, NextBtn, nil];
	//toolbar.hidden = YES;
	[toolbar setItems:items animated:NO];
	[toolbar setTintColor:[UIColor blackColor]];
	[appTabBar.view addSubview:toolbar];
	[PreBtn release];
	[Item1 release];
	[Item2 release];
	[NextBtn release];
	//[toolbar release];
	
	
	
	
	toolBar.hidden = YES;
	
	
}

-(void)viewWillAppear:(BOOL)animated
{
	
		
	
}

- (void)viewWillDisappear:(BOOL)animated
{
	//tbar.hidden = YES;
	//[tbar removeFromSuperview];
	
	[toolbar removeFromSuperview];
	[appTabBar showTabBar];
	
	NSLog(@"[%@ viewDidDisappear:%d]", [self class], animated);
	[super viewWillDisappear:animated];

	
}


- (void)viewDidDisappear:(BOOL)animated {
    NSLog(@"[%@ viewDidDisappear:%d]", [self class], animated);
    [super viewDidDisappear:animated];
}


/*
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
  return YES;
}
*/
- (void)didReceiveMemoryWarning 
{
  [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
  
  [super viewDidUnload];

  webView         = nil;
  activeIndicator = nil;
  toolBar         = nil;
  mapsButton      = nil;
}

- (void)dealloc {

  webView.delegate = nil;
	[toolbar release];	
  [webView release];
  [latitude release];
  [longitude release];
  [activeIndicator release];
  [toolBar release];
  [mapsButton release];
  
  [super dealloc];
}

//#pragma mark -
//#pragma mark UIWebViewDelegate Methods
- (void)webViewDidStartLoad:(UIWebView *)webView {

  UIApplication* app = [UIApplication sharedApplication];
  
  app.networkActivityIndicatorVisible = YES;
  
  [self.activeIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
  
  UIApplication* app = [UIApplication sharedApplication];
  
  app.networkActivityIndicatorVisible = NO;
  
  [self.activeIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
  
  NSString *errorString = [NSString stringWithFormat:@"@%", error];
  
  if (error != NULL) {
    
    UIAlertView *searchErrorAlert = [[UIAlertView alloc] initWithTitle:@"Error" 
                                                               message:errorString 
                                                              delegate:self 
                                                     cancelButtonTitle:nil 
                                                     otherButtonTitles:@"Dismiss", nil];
    [searchErrorAlert show];
    [searchErrorAlert release];
  }  
}

#pragma mark -
#pragma mark Custom Methods
- (IBAction)openGoogleMapsApp:(id)sender {
	/*NSString *hotelAddress = [Map getCurrentAddress];
	NSLog(@"Address : %@",hotelAddress );*/
	NSUserDefaults *standardUserDefaults = [NSUserDefaults standardUserDefaults];
	NSString *hotelAddress = nil;
	
	if (standardUserDefaults) 
		hotelAddress = [standardUserDefaults objectForKey:@"currentaddress"];
	
  NSString *urlstr = [NSString stringWithFormat:@"http://maps.google.com/maps?q=%@&mrt=yp",
                   [hotelAddress stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
	
	
    NSURL *url = [NSURL URLWithString:urlstr];
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	
	//Load the request in the UIWebView.
	[webView loadRequest:requestObj];
  
 // [[UIApplication sharedApplication] openURL:[NSURL URLWithString:url]];
}

-(IBAction)back
{
	
	
	[toolbar removeFromSuperview];
	
	[self.navigationController popViewControllerAnimated:YES];
	/*NSArray *navControllerArray = [self.navigationController viewControllers];
    for(int i=0; i<[navControllerArray count]; i++)
    {
		
		
        if([[navControllerArray objectAtIndex:i] isKindOfClass:[Map class]])
        {
			//[appDelegate.tabBarController.toolBar removeFromSuperview];
            [self.navigationController popToViewController:[navControllerArray objectAtIndex:i] animated:YES];
			
            break;
        }
		
		
    }*/
	
	
	//[self.navigationController popViewControllerAnimated:NO];
	
		
	
}
@end
