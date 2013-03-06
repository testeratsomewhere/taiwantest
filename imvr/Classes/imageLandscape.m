//
//  imageLandscape.m
//  imvr
//
//  Created by Nikhil Patel on 11/03/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "imageLandscape.h"
#import "BusinessCard.h"

@implementation imageLandscape


@synthesize count;
@synthesize imgNo;
@synthesize currentImage;
// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
/*
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization.
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad 
{
    [super viewDidLoad];
	
	appDelegate = (imvrAppDelegate *) [UIApplication sharedApplication].delegate;
	
	//|hidding the tabbar
	//appTabbar = (CustomTabBar *)appDelegate.tabBarController;
	//[appTabbar hideTabBar];
	
	appDelegate.orientationCounter = 0;
	
	
	cfObj = [AFItemView alloc];
	
	
	
	if(appDelegate.imageFlag)
	{
		
		[cfObj Hidealert] ;
	}
	if(appDelegate.specificImageFlag) 
	{
		[cfObj roomHideAlert];
		[cfObj hideAlert2];

		//[cfObj hideMyAlert];
		
		
	}

	[imgView setBackgroundColor:[UIColor clearColor]];
	
	
	if(appDelegate.imageFlag)
	{
	
	[imgView setImage:[appDelegate.roomImagesArray objectAtIndex:imgNo]];
	[imgView setBounds:CGRectMake(0, 0, 480, 320)];
	[imgView setCenter:CGPointMake(160, 240)];
	[imgView setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
	
		
	
	if(imgNo >= 0 && imgNo < count-1)
	{
		btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
		btnNext.frame = CGRectMake(284, 110, 35, 51);
		[btnNext setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
		btnNext.tag = 1;
		[btnNext addTarget:self action:@selector(nextButtonClicked) forControlEvents:UIControlEventTouchUpInside];
		[self.view addSubview:btnNext];
		[btnNext setBounds:CGRectMake(0, 0, 35, 51)];
		[btnNext setCenter:CGPointMake(160, 445)];
		[btnNext setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
		
		
		if(imgNo != 0)
		{
			btnPrevious = [UIButton buttonWithType:UIButtonTypeCustom];
			btnPrevious.frame = CGRectMake(284, 110, 35, 51);
			[btnPrevious setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
			btnPrevious.tag = 1;
			[btnPrevious addTarget:self action:@selector(previousButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:btnPrevious];
			[btnPrevious setBounds:CGRectMake(0, 0, 35, 51)];
			[btnPrevious setCenter:CGPointMake(160, 15)];
			[btnPrevious setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
		}
		
		/*CGRect lblFrame1 = CGRectMake(0, 350, 320, 30);
		lbl = [[UILabel alloc] initWithFrame:lblFrame1];
		[lbl setText:[appDelegate.imageNameArrary objectAtIndex:imgNo]];
		lbl.backgroundColor = [UIColor whiteColor];
		lbl.textColor = [UIColor blackColor];
		lbl.textAlignment = UITextAlignmentCenter;
		lbl.adjustsFontSizeToFitWidth = YES;
		[lbl setFont:[UIFont fontWithName:@"Trebuchet MS" size:14]];
		[lbl setFont:[UIFont boldSystemFontOfSize:14]];
		[av addSubview:lbl];
		*/
	}
	else 
	{
		if(imgNo == count-1)
		{
			btnPrevious = [UIButton buttonWithType:UIButtonTypeCustom];
			btnPrevious.frame = CGRectMake(284, 110, 35, 51);
			[btnPrevious setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
			btnPrevious.tag = 1;
			[btnPrevious addTarget:self action:@selector(previousButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:btnPrevious];
			[btnPrevious setBounds:CGRectMake(0, 0, 35, 51)];
			[btnPrevious setCenter:CGPointMake(160, 15)];
			[btnPrevious setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
		}
		
		/*CGRect lblFrame1 = CGRectMake(0, 350, 320, 30);
		lbl = [[UILabel alloc] initWithFrame:lblFrame1];
		[lbl setText:[appDelegate.imageNameArrary objectAtIndex:imgNo]];
		lbl.backgroundColor = [UIColor whiteColor];
		lbl.textColor = [UIColor blackColor];
		lbl.textAlignment = UITextAlignmentCenter;
		lbl.adjustsFontSizeToFitWidth = YES;
		[lbl setFont:[UIFont fontWithName:@"Trebuchet MS" size:14]];
		[lbl setFont:[UIFont boldSystemFontOfSize:14]];
		[av addSubview:lbl];
		*/
		
	}
	
	} // end of first if
	
	if(appDelegate.specificImageFlag)
	{
		[imgView setImage:[appDelegate.specificRoomImagesArray objectAtIndex:imgNo]];
		[imgView setBounds:CGRectMake(0, 0, 480, 320)];
		[imgView setCenter:CGPointMake(160, 240)];
		[imgView setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
	
		
		if(imgNo >= 0 && imgNo < count-1)
		{
			btnNextRoom = [UIButton buttonWithType:UIButtonTypeCustom];
			btnNextRoom.frame = CGRectMake(284, 110, 35, 51);
			[btnNextRoom setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
			btnNextRoom.tag = 1;
			[btnNextRoom addTarget:self action:@selector(nextRoomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:btnNextRoom];
			[btnNextRoom setBounds:CGRectMake(0, 0, 35, 51)];
			[btnNextRoom setCenter:CGPointMake(160, 445)];
			[btnNextRoom setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
			
			
			if(imgNo != 0)
			{
				btnPreviousRoom = [UIButton buttonWithType:UIButtonTypeCustom];
				btnPreviousRoom.frame = CGRectMake(284, 110, 35, 51);
				[btnPreviousRoom setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
				btnPreviousRoom.tag = 1;
				[btnPreviousRoom addTarget:self action:@selector(previousRoomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
				[self.view addSubview:btnPreviousRoom];
				[btnPreviousRoom setBounds:CGRectMake(0, 0, 35, 51)];
				[btnPreviousRoom setCenter:CGPointMake(160, 15)];
				[btnPreviousRoom setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
			}
			
		}
		else 
		{
			if(imgNo == count-1)
			{
				btnPreviousRoom = [UIButton buttonWithType:UIButtonTypeCustom];
				btnPreviousRoom.frame = CGRectMake(284, 110, 35, 51);
				[btnPreviousRoom setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
				btnPreviousRoom.tag = 1;
				[btnPreviousRoom addTarget:self action:@selector(previousRoomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
				[self.view addSubview:btnPreviousRoom];
				[btnPreviousRoom setBounds:CGRectMake(0, 0, 35, 51)];
				[btnPreviousRoom setCenter:CGPointMake(160, 15)];
				[btnPreviousRoom setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
			}
			
			
			
		}
		
	
	} // end of second if
	
	
	
	//---


}

#pragma mark room Images methods

-(void)nextButtonClicked
{
	if(imgNo < count-1)
	{
		
		UIImage *roomImg = [appDelegate.roomImagesArray objectAtIndex:imgNo+1];
		[imgView setImage:roomImg];
		//[myButton setBackgroundImage:roomImg forState:UIControlStateNormal];
		//[lbl setText:[appDelegate.imageNameArrary objectAtIndex:imgNo+1]];
	
		imgNo = imgNo + 1;
		
		if(imgNo == 1)
		{
			btnPrevious = [UIButton buttonWithType:UIButtonTypeCustom];
			btnPrevious.frame = CGRectMake(284, 110, 35, 51);
			[btnPrevious setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
			btnPrevious.tag = 1;
			[btnPrevious addTarget:self action:@selector(previousButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:btnPrevious];
			[btnPrevious setBounds:CGRectMake(0, 0, 35, 51)];
			[btnPrevious setCenter:CGPointMake(160, 15)];
			[btnPrevious setTransform:CGAffineTransformMakeRotation(M_PI / 2)];			
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
		
		UIImage *roomImg = [appDelegate.roomImagesArray objectAtIndex:imgNo-1];
		[imgView setImage:roomImg];
		//[myButton setBackgroundImage:roomImg forState:UIControlStateNormal];
		//[lbl setText:[appDelegate.imageNameArrary objectAtIndex:imgNo-1]];
		
		imgNo = imgNo - 1;
		if(imgNo == count-2)
		{
			btnNext = [UIButton buttonWithType:UIButtonTypeCustom];
			btnNext.frame = CGRectMake(284, 110, 35, 51);
			[btnNext setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
			btnNext.tag = 1;
			[btnNext addTarget:self action:@selector(nextButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:btnNext];
			[btnNext setBounds:CGRectMake(0, 0, 35, 51)];
			[btnNext setCenter:CGPointMake(160, 445)];
			[btnNext setTransform:CGAffineTransformMakeRotation(M_PI / 2)];
			
			
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


#pragma mark specific room Images methods


-(void)nextRoomButtonClicked
{
	if(imgNo < count-1)
	{
		
		UIImage *roomImg = [appDelegate.specificRoomImagesArray objectAtIndex:imgNo+1];
		[imgView setImage:roomImg];
		//[roomButton setBackgroundImage:roomImg forState:UIControlStateNormal];
		//[lbl setText:[appDelegate.imageNameArrary objectAtIndex:imgNo+1]];
		//appDelegate.imageNo = roomImgNo + 1;
		imgNo = imgNo + 1;
		
		if(imgNo == 1)
		{
			btnPreviousRoom = [UIButton buttonWithType:UIButtonTypeCustom];
			btnPreviousRoom.frame = CGRectMake(284, 110, 35, 51);
			[btnPreviousRoom setBackgroundImage:[UIImage imageNamed:@"previous.png"] forState:UIControlStateNormal];
			btnPreviousRoom.tag = 1;
			[btnPreviousRoom addTarget:self action:@selector(previousRoomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:btnPreviousRoom];
			[btnPreviousRoom setBounds:CGRectMake(0, 0, 35, 51)];
			[btnPreviousRoom setCenter:CGPointMake(160, 15)];
			[btnPreviousRoom setTransform:CGAffineTransformMakeRotation(M_PI / 2)];			
		}
		
		if(imgNo ==  count-1)
		{
			[btnNextRoom removeFromSuperview];
		}
		if(imgNo == 0)
		{
			[btnPreviousRoom removeFromSuperview];
		}
		
	}
	else 
	{
		[btnNextRoom removeFromSuperview];
	}
	
}

-(void)previousRoomButtonClicked
{
	NSLog(@"Previous btn cliked");
	if(imgNo > 0)
	{
		
		UIImage *roomImg = [appDelegate.specificRoomImagesArray objectAtIndex:imgNo-1];
		[imgView setImage:roomImg];
		//[roomButton setBackgroundImage:roomImg forState:UIControlStateNormal];
		//[lbl setText:[appDelegate.imageNameArrary objectAtIndex:imgNo-1]];
		//appDelegate.imageNo = roomImgNo - 1;
		imgNo = imgNo - 1;
		
		if(imgNo == count-2)
		{
			btnNextRoom = [UIButton buttonWithType:UIButtonTypeCustom];
			btnNextRoom.frame = CGRectMake(284, 110, 35, 51);
			[btnNextRoom setBackgroundImage:[UIImage imageNamed:@"next.png"] forState:UIControlStateNormal];
			btnNextRoom.tag = 1;
			[btnNextRoom addTarget:self action:@selector(nextRoomButtonClicked) forControlEvents:UIControlEventTouchUpInside];
			[self.view addSubview:btnNextRoom];
			[btnNextRoom setBounds:CGRectMake(0, 0, 35, 51)];
			[btnNextRoom setCenter:CGPointMake(160, 445)];
			[btnNextRoom setTransform:CGAffineTransformMakeRotation(M_PI / 2)];			
			
		}
		
		if(imgNo ==  count-1)
		{
			[btnNextRoom removeFromSuperview];
		}
		if(imgNo == 0)
		{
			[btnPreviousRoom removeFromSuperview];
		}
	}
	else 
	{
		[btnPreviousRoom removeFromSuperview];
	}
	
}


-(void)viewWillDisappear:(BOOL)animated
{
	
	//[appTabbar showTabBar];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}

- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc 
{
	
	NSLog(@"imageLandscape dealloc called");
	
	[imgView release];
	
	[appDelegate release];
	
	[imageArray release];
	[cfObj  release];
	
	[btnNext  release];
	[btnPrevious  release];
	
	[btnNextRoom release];
	[btnPreviousRoom release];
	
	
	[currentImage  release];
	[appTabbar release];
	
	[businessCardObj release];
	
    [super dealloc];
}


@end
