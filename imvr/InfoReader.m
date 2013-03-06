//
//  InfoReader.m
//  imvr
//
//  Created by Yaseen Mansuri on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "InfoReader.h"
#import "BusinessCard.h"
#import "HotelListView.h"
@implementation InfoReader
@synthesize adBannerView = _adBannerView;
@synthesize adBannerViewIsVisible = _adBannerViewIsVisible;
@synthesize contentView = _contentView;


// The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andArray:(NSMutableArray *)arr1{
 if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
 arr=[[NSMutableArray alloc]init];
	 arr=arr1;
 }
 return self;
 }

- (int)getBannerHeight:(UIDeviceOrientation)orientation {
    if (UIInterfaceOrientationIsLandscape(orientation)) {
        return 32;
    } else {
        return 50;
    }
}

- (int)getBannerHeight {
    return [self getBannerHeight:[UIDevice currentDevice].orientation];
}

- (void)createAdBannerView {
    Class classAdBannerView = NSClassFromString(@"ADBannerView");
    if (classAdBannerView != nil) {
        self.adBannerView = [[[classAdBannerView alloc] initWithFrame:CGRectZero] autorelease];
        [_adBannerView setRequiredContentSizeIdentifiers:[NSSet setWithObjects: ADBannerContentSizeIdentifierPortrait, ADBannerContentSizeIdentifierLandscape, nil]];
        if (UIInterfaceOrientationIsLandscape([UIDevice currentDevice].orientation)) {
            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierLandscape];
        } else {
            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];            
        }
        [_adBannerView setFrame:CGRectOffset([_adBannerView frame], 0, -[self getBannerHeight])];
        [_adBannerView setDelegate:self];
        
        [self.view addSubview:_adBannerView];        
    }
}

- (void)fixupAdView:(UIInterfaceOrientation)toInterfaceOrientation {
    if (_adBannerView != nil) {        
        if (UIInterfaceOrientationIsLandscape(toInterfaceOrientation)) {
            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierLandscape];
        } else {
            [_adBannerView setCurrentContentSizeIdentifier:ADBannerContentSizeIdentifierPortrait];
        }          
        [UIView beginAnimations:@"fixupViews" context:nil];
        if (_adBannerViewIsVisible) {
            CGRect adBannerViewFrame = [_adBannerView frame];
            adBannerViewFrame.origin.x = 0;
            adBannerViewFrame.origin.y = 40;
            [_adBannerView setFrame:adBannerViewFrame];
            CGRect contentViewFrame = _contentView.frame;
            contentViewFrame.origin.y = [self getBannerHeight:toInterfaceOrientation];
            contentViewFrame.size.height = self.view.frame.size.height - [self getBannerHeight:toInterfaceOrientation];
            _contentView.frame = contentViewFrame;
        } else {
            CGRect adBannerViewFrame = [_adBannerView frame];
            adBannerViewFrame.origin.x = 0;
            adBannerViewFrame.origin.y = -[self getBannerHeight:toInterfaceOrientation];
            [_adBannerView setFrame:adBannerViewFrame];
            CGRect contentViewFrame = _contentView.frame;
            contentViewFrame.origin.y = 40;
            contentViewFrame.size.height = self.view.frame.size.height;
            _contentView.frame = contentViewFrame;            
        }
        [UIView commitAnimations];
    }   
}


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
    titlelbl.text=[arr valueForKey:@"NewsTitle"];
	NewsContentlbl.text=[arr valueForKey:@"NewsContent"];
	HotelName.text=[arr valueForKey:@"HotelName"];
	if(scr != nil) {
		[scr removeFromSuperview];
		[scr release];
	}
	NewsContentlbl = [[UILabel alloc]init];
	
	scr=[[UIScrollView alloc]initWithFrame:CGRectMake(40,240, 240,150)];
	
	NewsContentlbl.text = [arr valueForKey:@"NewsContent"];
	//msgString = strDesc;
	
	NewsContentlbl.font = [UIFont fontWithName:@"Arial" size:14];
	NewsContentlbl.textColor = [UIColor whiteColor];
	NewsContentlbl.backgroundColor = [UIColor clearColor];
	NewsContentlbl.textAlignment = UITextAlignmentLeft;
	NewsContentlbl.numberOfLines =0;
	NewsContentlbl.userInteractionEnabled = NO;
	

	CGSize blockSize = [self getBlockSizeForLabel:NewsContentlbl andWidth:280];
	
	NewsContentlbl.frame=CGRectMake(0, 0, blockSize.width, blockSize.height);
	
	[scr addSubview:NewsContentlbl];
	
	[self.view addSubview:scr];
	
	scr.contentSize =CGSizeMake(0,blockSize.height+5);
	
	//[scr setContentSize:CGSizeMake(0,320)];

	[self createAdBannerView];


}

-(CGSize) getBlockSizeForLabel:(UILabel *)_locallabel andWidth:(float)_width
{
	
	CGSize constraintSize = CGSizeMake(_width, MAXFLOAT);
	return [_locallabel.text sizeWithFont:_locallabel.font 
						constrainedToSize:constraintSize 
							lineBreakMode:UILineBreakModeWordWrap];
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

#pragma mark ADBannerViewDelegate

- (void)bannerViewDidLoadAd:(ADBannerView *)banner {
    if (!_adBannerViewIsVisible) {                
        _adBannerViewIsVisible = YES;
        [self fixupAdView:[UIDevice currentDevice].orientation];
    }
}

- (void)bannerView:(ADBannerView *)banner didFailToReceiveAdWithError:(NSError *)error
{
    if (_adBannerViewIsVisible)
    {        
        _adBannerViewIsVisible = NO;
        [self fixupAdView:[UIDevice currentDevice].orientation];
    }
}


-(IBAction)BtnBusinessCard_Click{
	((imvrAppDelegate*)[[UIApplication sharedApplication]delegate]).tabBarController.selectedIndex=1;

	//HotelListView *ObjBusinessCard = [[HotelListView alloc] initWithNibName:@"HotelListView" bundle:nil];
	//[self.navigationController pushViewController:ObjBusinessCard animated:YES];
	//[ObjBusinessCard release];
}

-(IBAction)back_click{
	[self.navigationController popViewControllerAnimated:YES];
}
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


- (void)dealloc {
    [super dealloc];
	self.contentView = nil;    
    self.adBannerView = nil;   
}


@end
