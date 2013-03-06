//
//  GetHotelModel.h
//  imvr
//
//  Created by Yaseen Mansuri on 26/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imvrAppDelegate.h"
#import "alertmessage.h"
@interface GetHotelModel : UIViewController<NSXMLParserDelegate> {
	NSURLConnection *conn;
	NSXMLParser *xmlParser;
	NSMutableData *webData;
	imvrAppDelegate *appDelegate;
	UIAlertView *av;
	NSMutableArray *HotelsArray;
	NSMutableDictionary *HotelsDic;
	NSMutableString *currentElementValue;
	
	UIActivityIndicatorView *actInd;

}
-(void)Call_WebService:(NSString*)HotelId;
@end
