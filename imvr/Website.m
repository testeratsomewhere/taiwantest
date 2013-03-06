//
//  Website.m
//  imvr
//
//  Created by Yaseen Mansuri on 21/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Website.h"
#define BARBUTTON(TITLE, SELECTOR) 	[[UIBarButtonItem alloc] initWithTitle:TITLE style:UIBarButtonItemStylePlain target:self action:SELECTOR]//UIBarButtonItem
#define TOOLBAR 102


@implementation Website
@synthesize strURL, webTitle, trimmedString;


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	NSLog(@"recieved url :- %@", self.strURL);
	lblTitle.text = webTitle;
	loading.hidden = YES;
	webview.delegate = self;
	int loc = [self.strURL rangeOfString:@"http://"].location;
	if(loc == NSNotFound)
	{
		URL = [NSString stringWithFormat:@"http://%@",self.strURL];
	}
	else 
	{
		URL = self.strURL;
	}

	NSLog(@"Corrected URL :- %@", URL);	
	self.trimmedString = [URL stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
	
	
	NSURL *test1 = [NSURL URLWithString:self.trimmedString];
	NSURLRequest *test = [NSURLRequest requestWithURL:test1];
	webview.backgroundColor = [UIColor blackColor];
	
	webview.scalesPageToFit = YES;
	//[webview setUserInteractionEnabled:NO];
	[webview loadRequest:test];
	
	
	/*// toolbar
	UIToolbar *toolbar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 375, 320, 40)];
	[toolbar setTag:TOOLBAR];
	toolbar.barStyle = self.navigationController.navigationBar.barStyle;
	UIBarButtonItem *refreshBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"btn_reload.png"] style:UIBarButtonItemStylePlain target:self action:@selector(reload)];
	
	//UIBarButtonItem *PreBtn = BARBUTTON(@"Pre", @selector(Pre:));
	UIBarButtonItem *PreBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_left.png"] style:UIBarButtonItemStylePlain target:self action:@selector(Pre:)];

	UIBarButtonItem *Item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	UIBarButtonItem *Item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
	
	//UIBarButtonItem *NextBtn = BARBUTTON(@"Next", @selector(NextBtn:));
	UIBarButtonItem *NextBtn = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"arrow_right.png"] style:UIBarButtonItemStylePlain target:self action:@selector(NextBtn:)];

	
	NSArray *items = [NSArray arrayWithObjects: refreshBtn, Item1, PreBtn,  Item2, NextBtn, nil];
	//toolbar.hidden = YES;
	[toolbar setItems:items animated:NO];
	[toolbar setTintColor:[UIColor blackColor]];
	[self.view addSubview:toolbar];
	[PreBtn release];
	[Item1 release];
	[Item2 release];
	[NextBtn release];
	[toolbar release];
	*/
	
	
	appDelegate = (imvrAppDelegate *) [UIApplication sharedApplication].delegate;
	appTabBar = (CustomTabBar *)appDelegate.tabBarController;
	
}

- (void)viewWillAppear:(BOOL)animated
{
	//appTabBar = (CustomTabBar *)appDelegate.tabBarController;
	[appTabBar hideTabBar];
	
	
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
	//[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
	//	NSLog(@"click on back");
	[self.navigationController popViewControllerAnimated:YES];
	
}


#pragma mark webview methods

- (void)webViewDidStartLoad:(UIWebView *)webView
{
	NSLog(@"DidStart :- %@", self.trimmedString);
	//[self ShowAlert];
	loading.hidden = NO;
	[loading startAnimating];
}
	
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
		NSLog(@"DidFinished :- %@", self.trimmedString);
	//[self Hidealert];
	[loading stopAnimating];
	loading.hidden = YES;
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
		NSLog(@"DidFail :- %@", self.trimmedString);
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
	lblTitle.text = webTitle;
	NSURL *test1 = [NSURL URLWithString:self.trimmedString];
	NSURLRequest *test = [NSURLRequest requestWithURL:test1];
	webview.backgroundColor = [UIColor blackColor];
	
	webview.scalesPageToFit = YES;
	[webview loadRequest:test];
}


-(void)Pre:(id)sender{
	[webview goBack];
	
}


-(void)NextBtn:(id)sender{
	[webview goForward];
}

/*
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	UIToolbar *toolbar = (UIToolbar *)[self.view viewWithTag:TOOLBAR];
	UITouch *touch = [[event allTouches] anyObject];
	NSLog(@"Touch began");
	if (touch.tapCount == 1) {
		if (isHidden == NO) 
		{
			CGContextRef context = UIGraphicsGetCurrentContext();
			[UIView beginAnimations:nil context:context];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDuration:0.3];
			[webview setUserInteractionEnabled:NO];
			toolbar.hidden = NO;
			[UIView commitAnimations];
			isHidden = YES;
		}else 
		{
			CGContextRef context = UIGraphicsGetCurrentContext();
			[UIView beginAnimations:nil context:context];
			[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
			[UIView setAnimationDuration:0.3];
			toolbar.hidden = YES;
			[webview setUserInteractionEnabled:YES];
			[UIView commitAnimations];
			isHidden = NO;			
		}
		
	}
}
*/



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


- (void)dealloc 
{
	[webview release];
    [super dealloc];
}


@end
