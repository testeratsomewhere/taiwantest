//
//  BusinessCard.h
//  imvr
//
//  Created by Yaseen Mansuri on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iAd/ADBannerView.h"
#import "AFOpenFlowView.h"
#import "imvrAppDelegate.h"
#import "FlowCoverView.h"
#import "DataCache.h"
#import "NewsWebview.h"
#import "imageLandscape.h"
#import "CustomTabBar.h"
#import <MessageUI/MFMailComposeViewController.h>

//@class Price;
@interface BusinessCard : UIViewController<UIWebViewDelegate, MFMailComposeViewControllerDelegate, ADBannerViewDelegate,UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate,UIAlertViewDelegate, FlowCoverViewDelegate> {
	IBOutlet UIScrollView *scr;
	IBOutlet UIView *LocationView;
	IBOutlet UIView *NewsView;
	IBOutlet UIView *PriceView;
	IBOutlet UIView *priceWebView;
	IBOutlet UIView *NewCoverFlowview;
	
	
	id _adBannerView;
	BOOL _adBannerViewIsVisible;
	UIView *_contentView;
	//IBOutlet UIScrollView *scr;
	NSString *HotelId,*Address,*PhoneNumber,*HotelName,*Fax,*Logo,*HotelURL,*Email;
	IBOutlet UILabel *lblAddress,*lblPhoneNumber,*lblHotelName,*lblHotelURL,*lblFax,*lblEmail;
	NSMutableArray *RoomsArray;
	NSMutableDictionary *RoomsDic;
	NSMutableArray *NewsArray;
	NSMutableDictionary *NewsDic;
	NSMutableString *currentElementValue;
    UITableView *tblNews;
	UIScrollView *svimg;
	NSMutableArray *imgArray;
	UIAlertView *av;
	UIActivityIndicatorView *actInd;
	IBOutlet UISegmentedControl *segmentedControl;
	IBOutlet UIImageView *logoImageView;
	NSMutableArray *HotelDataArrrayFromDelegate;

	NSOperationQueue *loadImagesOperationQueue;
	
	imvrAppDelegate *appDelegate;
	
	NSMutableData *webData;
	NSXMLParser *xmlParser;
	NSURLConnection *conn;
	NSMutableDictionary *DetailDic;
	NSMutableArray *hotelDetailArray;
	int webServiceCount;
	NSMutableArray *imgArr;
	
	IBOutlet FlowCoverView *FlowCover;
	IBOutlet UILabel *imageName;
	
	NSMutableArray *mArr;
	
	UIView *viw;
	
	int lastSelectedIndex;
	
	IBOutlet UIWebView *webview;
	NewsWebview *newsObj;
	
	
	imageLandscape *imgLandView;
	
	BOOL roomsImageFlag;
	
	CustomTabBar *appTabBar;
	UINavigationController *navController;
	NSArray *navArray;

	int selectedTabForMail;
	NSArray *navArrayMail;
	UINavigationController *navControllerMail;
	
	int selectedTab;
	BOOL orientationFlag;
	int orientationCall;
	BOOL addNotification;
}
-(IBAction)back_click;
-(IBAction)btnLocation_click;
-(IBAction)btnNews_click;
-(IBAction)btnRooms_click;
-(void)Room_WebService;
-(void)call_Scroll;
-(IBAction)Phone;
-(IBAction)Website;
-(IBAction)sendEmail;
-(void)HotelRoom:(id)sender;
-(IBAction)btnPrice_click;
-(IBAction) segmentedControlIndexChanged;
-(IBAction)btnAddress_click;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andArray:(NSMutableArray *)arr1;


@property (nonatomic,retain) IBOutlet UISegmentedControl *segmentedControl;
@property (nonatomic, retain) id adBannerView;
@property (nonatomic) BOOL adBannerViewIsVisible;
@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic,retain)NSString *HotelId,*Address,*PhoneNumber,*HotelName,*Fax,*Logo,*HotelURL,*Email;
@property (nonatomic, readwrite) int webServiceCount;
@property (nonatomic, retain) IBOutlet UILabel *imageName;
@property (nonatomic, retain) IBOutlet UILabel *imgName;
@property (nonatomic, retain) IBOutlet UIView *PriceView;
@property (nonatomic, readwrite) int lastSelectedIndex;
@property (nonatomic, retain) NSMutableArray *RoomsArray;

@property (nonatomic, retain) IBOutlet UIView *LocationView;
@property (nonatomic, retain) IBOutlet UIView *NewsView;
//@property (nonatomic, retain) IBOutlet UIView *PriceView;
@property (nonatomic, retain) IBOutlet UIView *priceWebView;
@property (nonatomic, retain) IBOutlet UIView *NewCoverFlowview;
@property (nonatomic, readwrite) int orientationCall;

-(void)ShowAlert;
-(void)Hidealert;
-(void)setImageName;

-(void)Call_WebService;
-(void)fixParticularHotelValue;
-(void)fixRoomImages;
-(void)pushImageController;
@end
