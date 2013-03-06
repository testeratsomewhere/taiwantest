//
//  HotelRoom.m
//  imvr
//
//  Created by Yaseen Mansuri on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "HotelRoom.h"


@implementation HotelRoom
@synthesize RoomName,RoomDesc,imageData;

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
- (void)viewDidLoad {
    [super viewDidLoad];
	RoomNamelbl.text=RoomName;
	RoomDesclbl.text=RoomDesc;
	//NSString *imgstr=RoomPic;
	//NSLog(@"%@",[NSString stringWithFormat:@"http://www.imvr.net%@",imgstr]);
	//[imgview setImage:[UIImage imageNamed:[NSString stringWithFormat:@"http://www.imvr.net%@",imgstr]]];
	//NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://www.imvr.net%@",imgstr]]];
	UIImage *img = [UIImage  imageWithData:imageData];
	RoomPiclbl.image = img;
}


/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/
-(IBAction)back_click{
	[self.navigationController popViewControllerAnimated:NO];
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
}


@end
