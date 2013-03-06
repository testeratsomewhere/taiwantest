//
//  RoomCoverFlow.m
//  imvr
//
//  Created by Yaseen Mansuri on 28/01/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RoomCoverFlow.h"


@implementation RoomCoverFlow

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
	loadImagesOperationQueue = [[NSOperationQueue alloc] init];
	
	
	NSString *imageName;
	for (int i=0; i < 10; i++) {
		imageName = [[NSString alloc] initWithFormat:@"cover_%d.jpg", i];
		[(AFOpenFlowView *)self.view setImage:[UIImage imageNamed:imageName] forIndex:i];
		[imageName release];
		NSLog(@"%d is the index",i);
		
		
		[(AFOpenFlowView *)self.view setTag:i];
		//	[(AFOpenFlowView *)self.view setSelectedCover:i];
		
		
	}
	[(AFOpenFlowView *)self.view setNumberOfImages:10];
	
}
- (void)openFlowView:(AFOpenFlowView *)openFlowView selectionDidChange:(int)index{
	
	
	NSLog(@"%d is selected",index);
	
}
- (void)openFlowView:(AFOpenFlowView *)openFlowView requestImageForIndex:(int)index{
}


- (UIImage *)defaultImage{
	
	return [UIImage imageNamed:@"cover_1.jpg"];
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


- (void)dealloc {
    [super dealloc];
}


@end
