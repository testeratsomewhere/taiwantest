//
//  Price.h
//  imvr
//
//  Created by Yaseen Mansuri on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface Price : UIViewController<UIWebViewDelegate> {

	IBOutlet UIWebView *webview;
	NSString *StrPrice;
	
	IBOutlet UILabel *lblTitle;
	NSString *strTitle;
	
	UIAlertView *av;
	UIActivityIndicatorView *actInd;

	
}
@property(nonatomic,retain)NSString *StrPrice;
@property (nonatomic, retain) NSString *strTitle;

-(IBAction)back_click;


-(void)ShowAlert;
-(void)Hidealert;



@end
