//
//  Website.h
//  imvr
//
//  Created by Yaseen Mansuri on 21/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CustomTabBar.h"
#import "imvrAppDelegate.h"

@interface Website : UIViewController<UIWebViewDelegate> {
	NSString *strURL;
	IBOutlet UIWebView *webview;
	NSString *webTitle;
	IBOutlet UILabel *lblTitle;
	NSString *URL;
	
	IBOutlet UIActivityIndicatorView *loading;
	
	UIAlertView *av;
	UIActivityIndicatorView *actInd;
	
	BOOL isHidden;
	
	CustomTabBar *appTabBar;
	
	imvrAppDelegate *appDelegate;
	
	UIToolbar *toolbar;
	NSString *trimmedString;
}

@property (nonatomic, retain) NSString *strURL;
@property (nonatomic, retain) NSString *webTitle;
@property (nonatomic, retain) NSString *trimmedString;

-(IBAction)back_click;

-(void)ShowAlert;
-(void)Hidealert;

-(IBAction)reload;
@end
