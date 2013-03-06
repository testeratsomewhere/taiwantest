//
//  imvrAppDelegate.h
//  imvr
//
//  Created by Yaseen Mansuri on 16/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CustomTabbarController : UITabBarController
{
	
}
@end
@interface imvrAppDelegate : NSObject <UIApplicationDelegate,UITabBarControllerDelegate,UIAlertViewDelegate,NSXMLParserDelegate,UIAlertViewDelegate,UIActionSheetDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
	IBOutlet CustomTabbarController *tabBarController;
	NSMutableArray *addressArray;
	NSString *flagstr;
	BOOL IscallWebservice;
	
	NSMutableArray *AreaArray;
	NSMutableDictionary *AreaDic;
	NSMutableString *currentElementValue;
	NSURLConnection *conn;
	NSXMLParser *xmlParser;
	NSMutableData *webData;
	UIAlertView *av;
	UIActivityIndicatorView *actInd;
	NSMutableArray *HotelDataArray;
	
	BOOL mapFlag;
	
	int segmentIndex;
	NSMutableArray *imageNameArrary;
	NSMutableArray *imageArray;
	NSMutableArray *roomIDArray;
	
	BOOL imageFlag;
	BOOL specificImageFlag;
	int imageCount;
	int imageNo;
	
	
	int roomImageFlag;
	NSMutableArray *roomImagesArray;
	int specificRoomImageFlag;
	NSMutableArray *specificRoomImagesArray;
	
	int orientationCounter;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@property (nonatomic, retain) CustomTabbarController *tabBarController;
@property(nonatomic,retain)NSString *flagstr;
@property(nonatomic,readwrite)BOOL IscallWebservice;
@property (nonatomic, retain)NSMutableArray *AreaArray,*HotelDataArray;
@property (nonatomic, readwrite)BOOL mapFlag;
@property (nonatomic, readwrite)int segmentIndex;
@property (nonatomic, retain) NSMutableArray *imageNameArrary;
@property (nonatomic, retain) NSMutableArray *imageArray;
@property (nonatomic, retain) NSMutableArray *roomIDArray;
@property (nonatomic, readwrite) BOOL imageFlag;
@property (nonatomic, readwrite) BOOL specificImageFlag;
@property (nonatomic, readwrite) int imageCount;
@property (nonatomic, readwrite) int imageNo;
@property (nonatomic, retain) NSMutableArray *roomImagesArray;
@property (nonatomic, retain) NSMutableArray *specificRoomImagesArray;
@property (nonatomic, readwrite) int roomImageFlag;
@property (nonatomic, readwrite) int specificRoomImageFlag;
@property (nonatomic, readwrite) int orientationCounter;
//@property (nonatomic ,retain)NSMutableDictionary *HotelDataDic;;
-(void)tabBarControllerView;
-(void)ShowAlert;
-(void) Call_WebService;
@end

