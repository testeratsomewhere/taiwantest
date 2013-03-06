//
//  News.h
//  imvr
//
//  Created by Yaseen Mansuri on 16/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imvrAppDelegate.h"
#import "soap.h"
#import "NewsModel.h"
#import "GetHotelModel.h"
@class BusinessCard;
@interface News : UIViewController<UITableViewDelegate,UITableViewDataSource,NSXMLParserDelegate,UIAlertViewDelegate, UITabBarDelegate> {
	UITableView *Newstbl;
	NSMutableArray *NewsArray;
	NSMutableDictionary *NewsDic;
	NSMutableString *currentElementValue;
	soap *Objsoap;
	NSMutableData *myWebData;
	NSXMLParser *myXMLParser;
	NSString *TmpStr, *soapMssg,*fileName;
	
	NSMutableDictionary *TagDict,*soapDic,*innerDict;
	GetHotelModel *objGetHotelModel;
	NSMutableArray *dataArr;
	BOOL flgFinish;
	int cnt;
	NewsModel *modelObj;
	NSMutableArray *levelData, *innerArr;
	int level;
	NSString *tempstr;
	UIAlertView *av;
	UIActivityIndicatorView *actInd;
	NSURLConnection *conn;
	NSXMLParser *xmlParser;
	NSMutableData *webData;
	NSString *SelectedCellStr,*HotelId;
	NSMutableArray *HotelsArray;
	NSMutableDictionary *HotelsDic;
	id _adBannerView;
	BOOL _adBannerViewIsVisible;
	UIView *_contentView;
	BOOL isBusinessCard;
	
	// RR
	UIButton *btnMore;
	int startwith,endwith;
	BOOL endFlag;
	
	int tableRowCount;
	int count;
	
	imvrAppDelegate *appDelegate;
	UIView *footerView;
	int lastCount;
	int previousCount;
	BOOL moreFlag;
	//IBOutlet UITableView *table;
	BusinessCard *ObjBusinessCard;
}

@property (nonatomic, retain) id adBannerView;
@property (nonatomic) BOOL adBannerViewIsVisible;
@property (nonatomic, retain) IBOutlet UIView *contentView;
@property (nonatomic, retain) NSString *HotelId;
@property (nonatomic, readwrite) int tableRowCount;
- (void)createAdBannerView;
//
//@property(nonatomic,retain)NSString *WebserviceUrl;
//@property(nonatomic,retain)NSString *userName;
//@property(nonatomic,retain)NSString *userPassword;
-(void)Call_WebService;
//-(void)MakeConnection;
//-(void)getSoapData:(NSMutableDictionary *)soapDicc andFilename:(NSString *)filename;
//-(NSMutableArray *)postdata;
//-(NSString *)ReplaceFirstNewLine:(NSString *)original;
//-(void)getNewsList;
//-(void)checkNewstList;
-(void)ShowAlert;
-(void)Hidealert;

-(void) fixTableAndButton;

-(void)btnMoreClicked;

@end
