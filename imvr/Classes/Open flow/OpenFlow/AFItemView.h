/**
 * Copyright (c) 2009 Alex Fajkowski, Apparent Logic LLC
 *
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use,
 * copy, modify, merge, publish, distribute, sublicense, and/or sell
 * copies of the Software, and to permit persons to whom the
 * Software is furnished to do so, subject to the following
 * conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
 * OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
 * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
 * OTHER DEALINGS IN THE SOFTWARE.
 */
#import <UIKit/UIKit.h>
#import "imvrAppDelegate.h"

UIAlertView *av;
UIActivityIndicatorView *actInd;
UIActivityIndicatorView *actIndServices;

UIAlertView *avServices;
UIAlertView *avSpecificRoomImages;
UIAlertView *av1;
UIAlertView *roomAlertView;

@interface AFItemView : UIView <UIAlertViewDelegate>{
	UIImageView		*imageView;
	int				number;
	CGFloat			horizontalPosition;
	CGFloat			verticalPosition;
	CGFloat			originalImageHeight;
	
	UILabel *lblName;
	UIButton *myButton; 
	
	UIButton *btnNext;
	UIButton *btnPrevious;
	int imgNo;
	int count;
	BOOL previousFlag;
	UILabel *lbl;
	imvrAppDelegate *appDelegate;
	
	
	UIView *viw;
	
	NSMutableString *currentElementValue;
	NSURLConnection *conn;
	NSXMLParser *xmlParser;
	NSMutableData *webData;
	
	NSMutableArray *roomImageArray;
	NSMutableDictionary *roomImageDic;
	
	//UIAlertView *av;
	//UIActivityIndicatorView *actIndServices;
//	
//	UIAlertView *avServices;
//	UIAlertView *avSpecificRoomImages;
//	UIAlertView *av1;
	
	UIButton *closeButton;
	
	BOOL alertFlag;
	
	NSMutableArray *actualImageArray;
	
	
	//| variables for specific room images
	//UIAlertView *roomAlertView;
	UIButton *roomButton; 
	UIButton *btnRoomNext;
	UIButton *btnRoomPrevious;
	int roomImgNo;
	int roomCount;
	
	
}

@property int number;
@property (nonatomic, readonly) CGFloat horizontalPosition;
@property (nonatomic, readonly) CGFloat verticalPosition;
@property (nonatomic, readonly) UIImageView *imageView;
@property (nonatomic, retain) UILabel *lblName;
@property (nonatomic, retain) UIButton *btnNext;
@property (nonatomic, retain) UIButton *btnPrevious;
@property (nonatomic, readwrite) int imgNo;
@property (nonatomic, readwrite) int count;
@property (nonatomic, readwrite) BOOL previousFlag;
@property (nonatomic, retain) UIView *viw;



- (void)setImage:(UIImage *)newImage originalImageHeight:(CGFloat)imageHeight reflectionFraction:(CGFloat)reflectionFraction;
- (CGSize)calculateNewSize:(CGSize)originalImageSize boundingBox:(CGSize)boundingBox;

-(void)buttonClicked;
-(void) roomButtonClicked;
-(void)Hidealert;
-(void)ShowAlert:(UIImage *)roomImage imageNo:(int)no imageCount:(int)cnt;
-(void)ShowRoomAlert:(UIImage *)roomImage imageNo:(int)no imageCount:(int)cnt;
-(void)roomHideAlert;

-(UIImage *)resizeImage:(UIImage *)image withWidth:(int) width withHeight:(int) height;

-(void)Call_WebService:(NSString *)roomID;

-(void)getSpecificRoomImages;
-(void)servicesAlert;
-(void)hidAlert;
-(void)close;
-(void)hideAlert2;
-(void) getImagesFromURL;
-(void)fixRoomImages;
-(void) particularImageButtonClicked:(id)sender;
@end