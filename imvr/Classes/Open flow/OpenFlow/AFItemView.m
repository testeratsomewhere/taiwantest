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
#import "AFItemView.h"
#import <QuartzCore/QuartzCore.h>
#import "AFOpenFlowConstants.h"

static inline double radians (double degrees) {return degrees * M_PI/180;}


@implementation AFItemView
@synthesize number, imageView, horizontalPosition, verticalPosition;
@synthesize lblName;
@synthesize btnNext, btnPrevious;
@synthesize imgNo, count;
@synthesize previousFlag;
@synthesize viw;

- (id)initWithFrame:(CGRect)frame 
{
	if (self = [super initWithFrame:frame]) 
	{
		self.opaque = YES;
		self.backgroundColor = NULL;
		verticalPosition = 0;
		horizontalPosition = 0;
		
		// Image View
		imageView = [[UIImageView alloc] initWithFrame:frame];
		imageView.opaque = YES;
		[self addSubview:imageView];
		
		CGRect lblFrame = CGRectMake(0, 240, 200, 44);
		lblName = [[UILabel alloc] initWithFrame:lblFrame];
		[lblName setText:@"Name"];
		lblName.backgroundColor = [UIColor clearColor];
		lblName.textColor = [UIColor whiteColor];
		lblName.textAlignment = UITextAlignmentCenter;
		lblName.adjustsFontSizeToFitWidth = YES;
		[lblName setFont:[UIFont fontWithName:@"Trebuchet MS" size:14]];
		[lblName setFont:[UIFont boldSystemFontOfSize:14]];
		lblName.hidden = YES;
		[self addSubview:lblName];
		
		appDelegate = (imvrAppDelegate *) [UIApplication sharedApplication].delegate;
		
	}
	
	return self;
}

- (void)setImage:(UIImage *)newImage originalImageHeight:(CGFloat)imageHeight reflectionFraction:(CGFloat)reflectionFraction {
	[imageView setImage:newImage];
	//verticalPosition = imageHeight * reflectionFraction / 2;
	//originalImageHeight = imageHeight;
	//self.frame = CGRectMake(0, 0, newImage.size.width, newImage.size.height);
	
	verticalPosition = 0;
	originalImageHeight = 300;
	self.frame = CGRectMake(0, 0, 200, 250);
	//self.frame = CGRectMake(0, 0, newImage.size.width, 250);
}

- (void)setNumber:(int)newNumber {
	horizontalPosition = COVER_SPACING * newNumber;
	number = newNumber;
}

- (CGSize)calculateNewSize:(CGSize)baseImageSize boundingBox:(CGSize)boundingBox {
	CGFloat boundingRatio = boundingBox.width / boundingBox.height;
	CGFloat originalImageRatio = baseImageSize.width / baseImageSize.height;
	
	CGFloat newWidth;
	CGFloat newHeight;
	if (originalImageRatio > boundingRatio) {
		newWidth = boundingBox.width;
		newHeight = boundingBox.width * baseImageSize.height / baseImageSize.width;
	} else {
		newHeight = boundingBox.height;
		newWidth = boundingBox.height * baseImageSize.width / baseImageSize.height;
	}
	
	return CGSizeMake(newWidth, newHeight);
}

- (void)setFrame:(CGRect)newFrame {
	[super setFrame:newFrame];
	[imageView setFrame:newFrame];
}

- (void)dealloc {
	[imageView release];
	
	//----
	NSLog(@"AFItemView's dealloc...?");
	
	/*[lblName release];
	[myButton release]; 
	
	[btnNext release];
	[btnPrevious  release];
	
	[lbl release];
	[appDelegate release];
	
	
	[viw release];
	
	[currentElementValue release];
	[conn release];
	[xmlParser release];
	[webData release];
	
	[roomImageArray release];
	[roomImageDic release];
		
	[closeButton release];
	
	
	
	[actualImageArray release];
	
	
	
	[roomButton release]; 
	[btnRoomNext release];
	[btnRoomPrevious release];
*/
	
	
	
	
	//-----
	
	[super dealloc];
}


-(void)ShowAlert:(UIImage *)roomImage imageNo:(int)no imageCount:(int)cnt
{
	
	
	//appDelegate.imageFlag = YES;
	
	
	//[alertmessage ShowAlert];
//	lblName.hidden = YES;
	
	appDelegate = (imvrAppDelegate *) [UIApplication sharedApplication].delegate;
	//appDelegate.roomImageFlag = 1;
	appDelegate.imageFlag = YES;
	appDelegate.specificImageFlag = NO;
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	av=[[UIAlertView alloc] initWithTitle:@"" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	//av.frame =CGRectMake(90, 90, 320, 300);
	[av show];
	av.backgroundColor = [UIColor clearColor];
	//actInd=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	//[actInd setFrame:CGRectMake(120, 50, 37, 37)];
	//[actInd startAnimating];
	//[av addSubview:actInd];
	
	//UIImageView *roomImageView = [[UIImageView alloc] initWithFrame:CGRectMake(-20, -100, 320, 300)];
	//[roomImageView setImage:roomImage];
	
	//[av addSubview:roomImageView];
	UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,-80,320, 480)];
	imgView.backgroundColor = [UIColor blackColor];
	[av addSubview:imgView];
	
	myButton = [UIButton buttonWithType:UIButtonTypeCustom];
    //myButton.frame = CGRectMake(0, -80, 320, 430); 
    myButton.frame = CGRectMake(0, 0, 320, 250);
	[myButton setTitle:@"" forState:UIControlStateNormal];
	//[btnimg addTarget:self action:@selector(HotelRoom:) forControlEvents:UIControlEventTouchUpInside];

    [myButton addTarget:self action:@selector(buttonClicked) forControlEvents:UIControlEventTouchUpInside];
	
	NSLog(@"WIDTH :- %f  HEIGHT :- %f", roomImage.size.width, roomImage.size.height);
	
	CGSize size=CGSizeMake(320, 250);//Your new image size
	UIGraphicsBeginImageContext(size);
	[roomImage drawInRect:CGRectMake(0, 0, size.width,size.height)];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	[myButton setBackgroundImage:scaledImage forState:UIControlStateNormal];
	[av addSubview:myButton];
	
	//appDelegate.currentImage = scaledImage;
	
	//-------
	/*[myButton setBounds:CGRectMake(0, 0, 480, 320)];
	[myButton setCenter:CGPointMake(160, 160)];
	[myButton setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
	*/
	
	
	//-------
	
	
	
	imgNo = no;
	count = cnt;
	appDelegate.imageCount= cnt;
	appDelegate.imageNo = no;
	NSLog(@"Image number :- %d", imgNo);
	NSLog(@"Image count :- %d", count);
	if(no >= 0 && no < count-1)
	{
		btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
		btnNext.frame = CGRectMake(284, 110, 35, 51);
		[btnNext setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
		 btnNext.tag = 2;
		[btnNext addTarget:self action:@selector(nextButtonClicked) forControlEvents:UIControlEventTouchUpInside];
		[av addSubview:btnNext];
		
		if(no != 0)
		{
			btnPrevious = [UIButton buttonWithType:UIButtonTypeCustom];
			btnPrevious.frame = CGRectMake(0, 110, 35, 51);
			[btnPrevious setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
			btnPrevious.tag = 1;
			[btnPrevious addTarget:self action:@selector(previousButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[av addSubview:btnPrevious];
					}
		
		CGRect lblFrame1 = CGRectMake(0, 350, 320, 30);
		lbl = [[UILabel alloc] initWithFrame:lblFrame1];
		[lbl setText:[appDelegate.imageNameArrary objectAtIndex:imgNo]];
		lbl.backgroundColor = [UIColor whiteColor];
		lbl.textColor = [UIColor blackColor];
		lbl.textAlignment = UITextAlignmentCenter;
		lbl.adjustsFontSizeToFitWidth = YES;
		[lbl setFont:[UIFont fontWithName:@"Trebuchet MS" size:14]];
		[lbl setFont:[UIFont boldSystemFontOfSize:14]];
		[av addSubview:lbl];
				
	}
	else 
	{
		if(no == count-1)
		{
			btnPrevious = [UIButton buttonWithType:UIButtonTypeCustom];
			btnPrevious.frame = CGRectMake(0, 110, 35, 51);
			[btnPrevious setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
			btnPrevious.tag = 1;
			[btnPrevious addTarget:self action:@selector(previousButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[av addSubview:btnPrevious];
		}
		
		CGRect lblFrame1 = CGRectMake(0, 350, 320, 30);
		lbl = [[UILabel alloc] initWithFrame:lblFrame1];
		[lbl setText:[appDelegate.imageNameArrary objectAtIndex:imgNo]];
		lbl.backgroundColor = [UIColor whiteColor];
		lbl.textColor = [UIColor blackColor];
		lbl.textAlignment = UITextAlignmentCenter;
		lbl.adjustsFontSizeToFitWidth = YES;
		[lbl setFont:[UIFont fontWithName:@"Trebuchet MS" size:14]];
		[lbl setFont:[UIFont boldSystemFontOfSize:14]];
		[av addSubview:lbl];
		
		
	}

	
	[pool release];
	
}
-(void)nextButtonClicked
{
	if(imgNo < count-1)
	{
		
			UIImage *roomImg = [appDelegate.imageArray objectAtIndex:imgNo+1];
			[myButton setBackgroundImage:roomImg forState:UIControlStateNormal];
			[lbl setText:[appDelegate.imageNameArrary objectAtIndex:imgNo+1]];
		appDelegate.imageNo = imgNo + 1;
			imgNo = imgNo + 1;
		
			if(imgNo == 1)
			{
				btnPrevious = [UIButton buttonWithType:UIButtonTypeCustom];
				btnPrevious.frame = CGRectMake(0, 110, 35, 51);
				[btnPrevious setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
				btnPrevious.tag = 1;
				[btnPrevious addTarget:self action:@selector(previousButtonClicked) forControlEvents:UIControlEventTouchUpInside];
				[av addSubview:btnPrevious];
				
				
			}
		
		if(imgNo ==  count-1)
		{
			[btnNext removeFromSuperview];
		}
		if(imgNo == 0)
		{
			[btnPrevious removeFromSuperview];
		}
			
	}
	else 
	{
		[btnNext removeFromSuperview];
	}

}

-(void)previousButtonClicked
{
	NSLog(@"Previous btn cliked");
	if(imgNo > 0)
	{
		
		UIImage *roomImg = [appDelegate.imageArray objectAtIndex:imgNo-1];
		[myButton setBackgroundImage:roomImg forState:UIControlStateNormal];
		[lbl setText:[appDelegate.imageNameArrary objectAtIndex:imgNo-1]];
		appDelegate.imageNo = imgNo - 1;
		imgNo = imgNo - 1;
		if(imgNo == count-2)
		{
			btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
			btnNext.frame = CGRectMake(284, 110, 35, 51);
			[btnNext setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
			btnNext.tag = 1;
			[btnNext addTarget:self action:@selector(nextButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[av addSubview:btnNext];
						
			
		}
		
		if(imgNo ==  count-1)
		{
			[btnNext removeFromSuperview];
		}
		if(imgNo == 0)
		{
			[btnPrevious removeFromSuperview];
		}
	}
	else 
	{
		[btnPrevious removeFromSuperview];
	}

}
-(void)buttonClicked
{
	[self Hidealert];
}
-(void)Hidealert
{
	
	[av dismissWithClickedButtonIndex:0 animated:YES];
	
}



- (void)willPresentAlertView:(UIAlertView *)alertView 
{
	if(alertFlag)
	{
		alertView.frame = CGRectMake(25, 200, 275, 120);
		alertFlag = NO;
	}
    else 
	{
			alertView.frame = CGRectMake(0, 100, 320, 400);
	}

	  
}

#pragma mark image resizing
-(UIImage *)resizeImage:(UIImage *)image withWidth:(int) width withHeight:(int) height 
{
	
	CGImageRef imageRef = [image CGImage];
	CGImageAlphaInfo alphaInfo = CGImageGetAlphaInfo(imageRef);
	CGColorSpaceRef colorSpaceInfo = CGColorSpaceCreateDeviceRGB();
	
	if (alphaInfo == kCGImageAlphaNone)
		alphaInfo = kCGImageAlphaNoneSkipLast;
	
	CGContextRef bitmap;
	
	if (image.imageOrientation == UIImageOrientationUp | image.imageOrientation == UIImageOrientationDown) 
	{
		bitmap = CGBitmapContextCreate(NULL, width, height, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, alphaInfo);
		
	} 
	else 
	{
		bitmap = CGBitmapContextCreate(NULL, height, width, CGImageGetBitsPerComponent(imageRef), CGImageGetBytesPerRow(imageRef), colorSpaceInfo, alphaInfo);
		
	}
	
	if (image.imageOrientation == UIImageOrientationLeft) 
	{
		NSLog(@"image orientation left");
		CGContextRotateCTM (bitmap, radians(90));
		CGContextTranslateCTM (bitmap, 0, -height);
		
	} 
	else if (image.imageOrientation == UIImageOrientationRight) 
	{
		NSLog(@"image orientation right");
		CGContextRotateCTM (bitmap, radians(-90));
		CGContextTranslateCTM (bitmap, -width, 0);
		
	} 
	else if (image.imageOrientation == UIImageOrientationUp) 
	{
		NSLog(@"image orientation up");
		
	} 
	else if (image.imageOrientation == UIImageOrientationDown) 
	{
		NSLog(@"image orientation down");
		CGContextTranslateCTM (bitmap, width,height);
		CGContextRotateCTM (bitmap, radians(-180.));
		
	}
	
	CGContextDrawImage(bitmap, CGRectMake(0, 0, width, height), imageRef);
	CGImageRef ref = CGBitmapContextCreateImage(bitmap);
	UIImage *result = [UIImage imageWithCGImage:ref];
	
	CGContextRelease(bitmap);
	CGImageRelease(ref);
	
	return result;
}


#pragma mark parsing methods

-(void)Call_WebService:(NSString *)roomID
{
	alertFlag = YES;
	[self servicesAlert];
	NSString *strURL = [NSString stringWithFormat:@"http://www.imvr.net/iphonexml/getroompics.php?rid=%@", roomID];
	NSURL *url = nil;
	
	url = [[NSURL alloc] initWithString:strURL];
	
	NSMutableURLRequest *req =[NSMutableURLRequest requestWithURL:url];
	conn = [[NSURLConnection alloc] initWithRequest:req delegate:self];
	if (conn) {
		webData =[[NSMutableData alloc]  initWithLength:0];
	}    
	
}

-(void) connection:(NSURLConnection *) connection didReceiveResponse:(NSURLResponse *) response {
	[webData setLength: 0];
}

-(void) connection:(NSURLConnection *) connection didReceiveData:(NSData *) data {
	
	[webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	UIAlertView *connectionError = [[UIAlertView alloc] initWithTitle:@"Connection error" message:@"Error connecting to page.  Please check your 3G and/or Wifi settings." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil]; 
    [connectionError show];
	
	[av dismissWithClickedButtonIndex:0 animated:YES];	
	
	
	[webData release];
    [connection release];
	
}
-(void) connectionDidFinishLoading:(NSURLConnection *) connection {
    
	if (xmlParser)
    {
        [xmlParser release];
    }    
    xmlParser = [[NSXMLParser alloc] initWithData: webData];
    [xmlParser setDelegate: self];
    [xmlParser setShouldResolveExternalEntities:YES];
    [xmlParser parse];
    [connection release];
	[webData release];	
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
	
	if([elementName isEqualToString:@"HotelTable"]) 
	{
		//Initialize the array.
		roomImageArray = [[NSMutableArray alloc] init];
		
	}
	else if([elementName isEqualToString:@"HotelRoomPic"]) 
	{
		roomImageDic = [[NSMutableDictionary alloc] init];
	}
	
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string 
{ 
	
	currentElementValue = [[NSMutableString alloc] init];
	
	[currentElementValue appendString:string];
	
	
	
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
	
	if([elementName isEqualToString:@"HotelTable"])
	{
		
		//[roomImageDic release];
		return;
	}
	else if([elementName isEqualToString:@"HotelRoomPic"]) 
	{
		[roomImageArray addObject:roomImageDic];
		NSLog(@"Yaseen :- %@", [roomImageArray description] );
		[roomImageDic release];
		
	}	
	else if([elementName isEqualToString:@"HotelID"]||[elementName isEqualToString:@"RoomId"] || [elementName isEqualToString:@"RoomPic"])
	{
		NSLog(@"valuee :- %@", elementName);
		[roomImageDic setObject:currentElementValue forKey:elementName];
		NSLog(@"dic valuee :- %@", [roomImageDic description]);
	}
	
}

- (void)parserDidEndDocument:(NSXMLParser *)parser
{
	[self hidAlert];
	NSLog(@"Did end");
	//NSLog(@"room image array %@", [roomImageArray description]);
	
	[self getSpecificRoomImages];
}


-(void)servicesAlert{
	//[alertmessage ShowAlert];
	NSAutoreleasePool *pool = [ [ NSAutoreleasePool alloc] init];
	avServices=[[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	[avServices show];
	actIndServices=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	
	[actIndServices setFrame:CGRectMake(120, 50, 37, 37)];
	[actIndServices startAnimating];
	[avServices addSubview:actIndServices];
	[pool release];
}

-(void)hidAlert
{
	[avServices dismissWithClickedButtonIndex:0 animated:YES];
}

#pragma mark specific images method
-(void)getSpecificRoomImages
{
	av1=[[UIAlertView alloc] initWithTitle:@"" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	av.frame =CGRectMake(90, 90, 320, 300);
	[av1 show];
	
	
	viw = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 400)];
	[viw setBackgroundColor:[UIColor blackColor]];
	[av1 addSubview:viw];
	
	closeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    closeButton.frame = CGRectMake(0, 0, 51, 51);
	[closeButton setTitle:@"" forState:UIControlStateNormal];
	[closeButton setImage:[UIImage imageNamed:@"close.png"] forState:UIControlStateNormal];

    [closeButton addTarget:self action:@selector(close) forControlEvents:UIControlEventTouchUpInside];
	//[viw addSubview:closeButton];
	[av1 addSubview:closeButton];
	
	[self getImagesFromURL];
	[self fixRoomImages];
}


-(void)hideAlert2
{
	[av1 dismissWithClickedButtonIndex:0 animated:YES];
	
}


-(void) close
{
	[self hideAlert2];
}
-(void) getImagesFromURL
{
	appDelegate = (imvrAppDelegate *) [UIApplication sharedApplication].delegate;
	if([appDelegate.specificRoomImagesArray count] != 0)
	{
		[appDelegate.specificRoomImagesArray removeAllObjects];
	}
	actualImageArray = [[NSMutableArray	alloc] init];
	for (int i=0; i < [roomImageArray count]; i++) 
	{
		
		
		NSString *strUrl = [NSString stringWithFormat:@"http://www.imvr.net%@",[[roomImageArray objectAtIndex:i] valueForKey:@"RoomPic"]];
		NSLog(@"URL :- %@", strUrl);
		NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]];
		UIImage *img = [UIImage  imageWithData:imageData];
		
		if(img != nil)
		{
			[actualImageArray addObject:img];
			[appDelegate.specificRoomImagesArray addObject:img];
			[img release];
		}
		
		
	}
}
-(void)fixRoomImages
{
	int x = 20;
	int y = 80;
	int width = 87;
	int height = 50;
	for(int i=1; i<=[actualImageArray count]; i++)
	{
		UIButton *roomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
		roomBtn.frame = CGRectMake(x, y, width, height);
		[roomBtn setTitle:@"" forState:UIControlStateNormal];
		[roomBtn setImage:[actualImageArray objectAtIndex:i-1] forState:UIControlStateNormal];
		[roomBtn addTarget:self action:@selector(particularImageButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
		[viw addSubview:roomBtn];
		[roomBtn setTag:i-1];
		//[roomBtn release];
		x = x + width + 10;
		
		if(i%3 ==0)
		{
			y = y + height + 10;
			x = 20;
		}
	}
	 
		
	
	
}

-(void)particularImageButtonClicked:(id)sender
{
	UIButton *btn = (UIButton *)sender;
	int btnTag = btn.tag;
	
	
	/*
	CGContextRef context = UIGraphicsGetCurrentContext();
	[UIView beginAnimations:nil context:context];
	[UIView setAnimationTransition: UIViewAnimationTransitionFlipFromLeft forView:btn cache:NO];
	[UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
	[UIView setAnimationDuration:1.0];
	[UIView commitAnimations];
	*/
	
	/*
	CABasicAnimation *halfTurn;
	halfTurn = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
	halfTurn.fromValue = [NSNumber numberWithFloat:0];
	halfTurn.toValue = [NSNumber numberWithFloat:((360*M_PI)/180)];
	halfTurn.duration = 0.5;
	halfTurn.repeatCount = 1;
	[btn addAnimation:halfTurn forKey:@"180"];
	*/
	//btn.transform = CGAffineTransformMakeRotation( ( 180 * M_PI ) / 180 );
	
	[self ShowRoomAlert:[actualImageArray objectAtIndex:btnTag] imageNo:btnTag imageCount:[actualImageArray count]];
}

-(void)resizeButton
{
	
	
}

#pragma mark roomImages next previous methods

-(void)ShowRoomAlert:(UIImage *)roomImage imageNo:(int)no imageCount:(int)cnt
{
	
	appDelegate = (imvrAppDelegate *) [UIApplication sharedApplication].delegate;
	appDelegate.imageFlag = NO;
	appDelegate.specificImageFlag = YES;
	
	
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	roomAlertView=[[UIAlertView alloc] initWithTitle:@"" message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	[roomAlertView show];
	//roomAlertView.backgroundColor = [UIColor clearColor];
	
	UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0,-80,320, 480)];
	imgView.backgroundColor = [UIColor blackColor];
	[roomAlertView addSubview:imgView];
	
	roomButton = [UIButton buttonWithType:UIButtonTypeCustom];
    roomButton.frame = CGRectMake(0, 0, 320, 250);
	[roomButton setTitle:@"" forState:UIControlStateNormal];
    [roomButton addTarget:self action:@selector(roomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
	
	NSLog(@"WIDTH :- %f  HEIGHT :- %f", roomImage.size.width, roomImage.size.height);
	
	CGSize size=CGSizeMake(320, 250);//Your new image size
	UIGraphicsBeginImageContext(size);
	[roomImage drawInRect:CGRectMake(0, 0, size.width,size.height)];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	[roomButton setBackgroundImage:scaledImage forState:UIControlStateNormal];
	[roomAlertView addSubview:roomButton];
	
	
		
	
	
	roomImgNo = no;
	roomCount = cnt;
	appDelegate.imageNo = no;
	appDelegate.imageCount = cnt;
	
	NSLog(@"Image number :- %d", roomImgNo);
	NSLog(@"Image count :- %d", roomCount);
	if(no >= 0 && no < roomCount-1)
	{
		btnRoomNext = [UIButton buttonWithType:UIButtonTypeCustom];
		btnRoomNext.frame = CGRectMake(284, 110, 35, 51);
		[btnRoomNext setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
		btnRoomNext.tag = 2;
		[btnRoomNext addTarget:self action:@selector(nextRoomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
		[roomAlertView addSubview:btnRoomNext];
		
		if(no != 0)
		{
			btnRoomPrevious = [UIButton buttonWithType:UIButtonTypeCustom];
			btnRoomPrevious.frame = CGRectMake(0, 110, 35, 51);
			[btnRoomPrevious setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
			btnRoomPrevious.tag = 1;
			[btnRoomPrevious addTarget:self action:@selector(previousRoomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[roomAlertView addSubview:btnRoomPrevious];
		}
		
				
	}
	else 
	{
		if(no == roomCount-1)
		{
			btnRoomPrevious = [UIButton buttonWithType:UIButtonTypeCustom];
			btnRoomPrevious.frame = CGRectMake(0, 110, 35, 51);
			[btnRoomPrevious setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
			btnRoomPrevious.tag = 1;
			[btnRoomPrevious addTarget:self action:@selector(previousRoomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[roomAlertView addSubview:btnRoomPrevious];
		}
		
			
		
	}
	
	
	[pool release];
	 
	 
	
}
-(void)nextRoomButtonClicked
{
	if(roomImgNo < roomCount-1)
	{
		
		UIImage *roomImg = [actualImageArray objectAtIndex:roomImgNo+1];
		[roomButton setBackgroundImage:roomImg forState:UIControlStateNormal];
		//[lbl setText:[appDelegate.imageNameArrary objectAtIndex:imgNo+1]];
		appDelegate.imageNo = roomImgNo + 1;
		roomImgNo = roomImgNo + 1;
		
		if(roomImgNo == 1)
		{
			btnRoomPrevious = [UIButton buttonWithType:UIButtonTypeCustom];
			btnRoomPrevious.frame = CGRectMake(0, 110, 35, 51);
			[btnRoomPrevious setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
			btnRoomPrevious.tag = 1;
			[btnRoomPrevious addTarget:self action:@selector(previousRoomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[roomAlertView addSubview:btnRoomPrevious];
			
			
		}
		
		if(roomImgNo ==  roomCount-1)
		{
			[btnRoomNext removeFromSuperview];
		}
		if(roomImgNo == 0)
		{
			[btnRoomPrevious removeFromSuperview];
		}
		
	}
	else 
	{
		[btnRoomNext removeFromSuperview];
	}
	
}

-(void)previousRoomButtonClicked
{
	NSLog(@"Previous btn cliked");
	if(roomImgNo > 0)
	{
		
		UIImage *roomImg = [actualImageArray objectAtIndex:roomImgNo-1];
		[roomButton setBackgroundImage:roomImg forState:UIControlStateNormal];
		//[lbl setText:[appDelegate.imageNameArrary objectAtIndex:imgNo-1]];
		appDelegate.imageNo = roomImgNo - 1;

		roomImgNo = roomImgNo - 1;
		if(roomImgNo == roomCount-2)
		{
			btnRoomNext = [UIButton buttonWithType:UIButtonTypeCustom];
			btnRoomNext.frame = CGRectMake(284, 110, 35, 51);
			[btnRoomNext setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
			btnRoomNext.tag = 1;
			[btnRoomNext addTarget:self action:@selector(nextRoomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[roomAlertView addSubview:btnRoomNext];
			
			
		}
		
		if(roomImgNo ==  roomCount-1)
		{
			[btnRoomNext removeFromSuperview];
		}
		if(roomImgNo == 0)
		{
			[btnRoomPrevious removeFromSuperview];
		}
	}
	else 
	{
		[btnRoomPrevious removeFromSuperview];
	}
	
}
-(void)roomButtonClicked
{
	[self roomHideAlert];
}
-(void)roomHideAlert
{
	
	[roomAlertView dismissWithClickedButtonIndex:0 animated:YES];
	
}

@end