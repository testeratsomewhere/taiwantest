//
//  Price.m
//  imvr
//
//  Created by Yaseen Mansuri on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "Price.h"


@implementation Price
@synthesize StrPrice, strTitle;

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
- (void)viewDidLoad {
    [super viewDidLoad];
	lblTitle.text = strTitle;
	NSURL *test1 = [NSURL URLWithString:StrPrice];
	NSURLRequest *test = [NSURLRequest requestWithURL:test1];
	webview.backgroundColor = [UIColor blackColor];
	webview.scalesPageToFit = YES;
	[webview loadRequest:test];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(IBAction)back_click{
	//[self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:0] animated:YES];
//	NSLog(@"click on back");
	[self.navigationController popViewControllerAnimated:YES];
	
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
