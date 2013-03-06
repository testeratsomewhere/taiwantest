//
//  imageLandscape.h
//  imvr
//
//  Created by Nikhil Patel on 11/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "imvrAppDelegate.h"
#import "AFItemView.h"
#import "CustomTabBar.h"

@class BusinessCard;

@interface imageLandscape : UIViewController 
{
	IBOutlet UIImageView *imgView;

	imvrAppDelegate *appDelegate;
	
	NSMutableArray *imageArray;
	AFItemView *cfObj;
	
	UIButton *btnNext;
	UIButton *btnPrevious;
	
	UIButton *btnNextRoom;
	UIButton *btnPreviousRoom;
	
	int count;
	int imgNo;
	UIImage *currentImage;
	CustomTabBar *appTabbar;
	
	BusinessCard *businessCardObj;
}

@property (nonatomic, readwrite) int count;
@property (nonatomic, readwrite) int imgNo;
@property (nonatomic, retain) UIImage *currentImage;


@property (nonatomic, assign) UIViewController* parentViewController;

-(void)nextButtonClicked;
-(void)previousButtonClicked;
-(void)nextRoomButtonClicked;
-(void)previousRoomButtonClicked;

@end
