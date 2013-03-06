//
//  NewsWebview.m
//  imvr
//
//  Created by Nikhil Patel on 25/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "NewsWebview.h"
#define BARBUTTON(TITLE, SELECTOR) 	[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]//UIBarButtonItem
#define TOOLBAR 102

@implementation NewsWebview
@synthesize webTitle, strURL, newsID, hotelName, URL;

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
	
	appDelegate = (imvrAppDelegate *) [UIApplication sharedApplication].delegate;
	appTabBar = (CustomTabBar *)appDelegate.tabBarController;
}

- (void)viewWillAppear:(BOOL)animated
{
	loading.hidden = YES;
	lblTitle.text = self.hotelName;
	urlConstant = @"/news_ch.php?id=";
	
	int loc = [self.strURL rangeOfString:@"http://"].location;
	if(loc == NSNotFound)
	{
		tmpURL = [NSString stringWithFormat:@"http://%@",self.strURL];
	}
	else 
	{
		tmpURL = self.strURL;
	}
	
	NSString *joinedString = [NSString stringWithFormat:@"%@%@%@", tmpURL, urlConstant, self.newsID];
	//NSString *trimmedString = [joinedString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	NSString *trimmedString = [joinedString stringByReplacingOccurrencesOfString:@" " withString:@""];
	self.URL = trimmedString;
	
	NSLog(@"URL :- %@", self.URL);
	NSURL *url = [NSURL URLWithString:self.URL];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	webview.backgroundColor = [UIColor blackColor];
	
	webview.scalesPageToFit = YES;
	[webview loadRequest:urlRequest];
	
	// toolbar
	toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 430, 320.0,44)];
	[toolbar setTag:TOOLBAR];
	toolbar.barStyle = self.navigationController.navigationBar.barStyle;
	UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_reload.png"] style:UIBarButtonItemStylePlain target:self action:@selector(reload)];
	
	//UIBarButtonItem *PreBtn = BARBUTTON(@"Pre", @selector(Pre:));
	UIBarButtonItem *PreBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left.png"] style:UIBarButtonItemStylePlain target:self action:@selector(Pre:)];
	
	UIBarButtonItem *Item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	UIBarButtonItem *Item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	//UIBarButtonItem *NextBtn = BARBUTTON(@"Next", @selector(NextBtn:));
	UIBarButtonItem *NextBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_right.png"] style:UIBarButtonItemStylePlain target:self action:@selector(NextBtn:)];
	
	
	NSArray *items = [NSArray arrayWithObjects: PreBtn, Item1, refreshBtn,  Item2, NextBtn, nil];
	//toolbar.hidden = YES;
	[toolbar setItems:items animated:NO];
	[toolbar setTintColor:[UIColor blackColor]];
	[appTabBar.view addSubview:toolbar];
	[PreBtn release];
	[Item1 release];
	[Item2 release];
	[NextBtn release];
	[toolbar release];
	
	
}

- (void)viewWillDisappear:(BOOL)animated
{
	[toolbar removeFromSuperview];
	[appTabBar showTabBar];
}

-(IBAction)back_click{
	
	[self.navigationController popViewControllerAnimated:YES];
	
}


#pragma mark webview methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	//[self ShowAlert];
	[loading startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
	//[self Hidealert];
	[loading stopAnimating];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
	/*UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Message" message:@"Failed to open the website" delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[alert release];*/
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
	if(buttonIndex == 0)
	{
		[self.navigationController popViewControllerAnimated:YES];
	}
	
	
}


#pragma mark alert methods
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


-(IBAction)reload
{
	
	NSURL *url = [NSURL URLWithString:self.URL];
	NSURLRequest *urlRequest = [NSURLRequest requestWithURL:url];
	//webview.backgroundColor = [UIColor blackColor];
	
	//webview.scalesPageToFit = YES;
	[webview loadRequest:urlRequest];
}

-(void)Pre:(id)sender{
	[webview goBack];
}


-(void)NextBtn:(id)sender{
	[webview goForward];
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

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end
