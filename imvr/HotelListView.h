//
//  HotelListView.h
//  imvr
//
//  Created by Yaseen Mansuri on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imvrAppDelegate.h"
#import <MessageUI/MFMailComposeViewController.h>
#import "IconDownloader.h"
@class BusinessCard;

@interface HotelListView : UIViewController<MFMailComposeViewControllerDelegate,UITableViewDelegate ,UITableViewDataSource,NSXMLParserDelegate,UIAlertViewDelegate,UIPickerViewDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UITextFieldDelegate, IconDownloaderDelegate> {
	UITableView *Hotellisttbl;
	NSMutableArray *HotelsArray;
	NSMutableDictionary *HotelsDic;
	NSMutableDictionary *locCategory,*locCategoryAll;
	NSMutableArray *locArray;
	NSMutableString *currentElementValue;
	UIAlertView *av;
	UIActivityIndicatorView *actInd;
	IBOutlet UITextField *txtLocation;
	UIActionSheet *actGender;
	UIPickerView *pkrGender;
	NSMutableArray *arrayGender;
	NSString *mKey,*tempKey,*tempArea;
	NSURLConnection *conn;
	NSXMLParser *xmlParser;
	NSMutableData *webData;
	imvrAppDelegate *appDelegate;
	UIScrollView *svimg;
	IBOutlet UIButton *btnLogo;
	NSMutableArray *AreaArray;
	NSMutableArray *DataArray;
	IBOutlet UILabel *lblCity;
	NSString *pickerStr;
	NSMutableArray *PickerHotelsArray;
	
	NSMutableArray *logoArray;
	NSMutableDictionary *imageDownloadsInProgress;
	NSString *HotelId;
	
	NSMutableArray *entries; 
	NSString *lastTitle;
	int pickerRow;
	NSMutableArray *taipieList;
	
	BusinessCard *ObjBusinessCard;
	
}

@property (nonatomic, retain) NSString *HotelId;
@property (nonatomic, retain) NSMutableArray *HotelsArray;
@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
@property (nonatomic, retain) NSMutableArray *entries; 
@property (nonatomic, retain) NSMutableArray *PickerHotelsArray;
@property (nonatomic, retain) NSString *mKey;
@property (nonatomic, retain) NSString *lastTitle;
@property (nonatomic, readwrite) int pickerRow;
@property (nonatomic, retain) NSMutableArray *taipieList;
-(void)Call_WebService;
//-(void)getData;
-(void)ShowAlert;
-(void)Hidealert;
-(IBAction)back_click;
-(IBAction) taipai_click;
-(IBAction) btnLogo_click;
-(void)getLogo;
-(void)createLocationPickerView;
-(void)fillTheIconArray;
-(void)cleanup;
-(void)fixTableAgain;
@end
