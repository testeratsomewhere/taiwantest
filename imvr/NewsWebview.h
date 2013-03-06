//
//  NewsWebview.h
//  imvr
//
//  Created by Nikhil Patel on 25/02/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBar.h"
#import "imvrAppDelegate.h"

@interface NewsWebview : UIViewController <UIWebViewDelegate>
{
	
	IBOutlet UIWebView *webview;
	IBOutlet UIButton *btnBack;
	IBOutlet UIButton *btnReload;
	
	NSString *strURL;
	NSString *urlConstant;
	NSString *webTitle;
	NSString *tmpURL;
	NSString *URL;
	NSString *newsID;
	UIAlertView *av;
	UIActivityIndicatorView *actInd;
	
	IBOutlet UIActivityIndicatorView *loading;
	
	IBOutlet UILabel *lblTitle;
	NSString *hotelName;
	
	
	CustomTabBar *appTabBar;
	
	imvrAppDelegate *appDelegate;
	
	UIToolbar *toolbar;
	

}

@property (nonatomic, retain) NSString *strURL;
@property (nonatomic, retain) NSString *webTitle;
@property (nonatomic, retain) NSString *newsID;
@property (nonatomic, retain) NSString *hotelName;
@property (nonatomic, retain) NSString *URL;

-(IBAction)back_click;
-(IBAction)reload;

-(void)ShowAlert;
-(void)Hidealert;



@end
