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
#import "AFOpenFlowView.h"
#import "AFOpenFlowConstants.h"
#import "AFUIImageReflection.h"

#define DOUBLE_TAP_DELAY 0.3

@interface AFOpenFlowView (hidden)

- (void)setUpInitialState;
- (AFItemView *)coverForIndex:(int)coverIndex;
- (void)updateCoverImage:(AFItemView *)aCover;
- (AFItemView *)dequeueReusableCover;
- (void)layoutCovers:(int)selected fromCover:(int)lowerBound toCover:(int)upperBound;
- (void)layoutCover:(AFItemView *)aCover selectedCover:(int)selectedIndex animated:(Boolean)animated;
- (AFItemView *)findCoverOnscreen:(CALayer *)targetLayer;

@end

@implementation AFOpenFlowView (hidden)



const static CGFloat kReflectionFraction = 0.85;
//added code
//const static CGFloat kReflectionFraction = 1.00;

- (void)setUpInitialState {
	// Set up the default image for the coverflow.
	self.defaultImage = [self.dataSource defaultImage];
	
	// Create data holders for onscreen & offscreen covers & UIImage objects.
	coverImages = [[NSMutableDictionary alloc] init];
	coverImageHeights = [[NSMutableDictionary alloc] init];
	offscreenCovers = [[NSMutableSet alloc] init];
	onscreenCovers = [[NSMutableDictionary alloc] init];
	
	scrollView = [[UIScrollView alloc] initWithFrame:self.frame];
	scrollView.userInteractionEnabled = NO;
	scrollView.multipleTouchEnabled = NO;
	scrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
	[self addSubview:scrollView];
	
	self.multipleTouchEnabled = NO;
	self.userInteractionEnabled = YES;
	self.autoresizesSubviews = YES;
	self.layer.position=CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
	
	// Initialize the visible and selected cover range.
	lowerVisibleCover = upperVisibleCover = -1;
	selectedCoverView = nil;
	
	// Set up the cover's left & right transforms.
	leftTransform = CATransform3DIdentity;
	leftTransform = CATransform3DRotate(leftTransform, SIDE_COVER_ANGLE, 0.0f, 1.0f, 0.0f);
	rightTransform = CATransform3DIdentity;
	rightTransform = CATransform3DRotate(rightTransform, SIDE_COVER_ANGLE, 0.0f, -1.0f, 0.0f);
	
	// Set some perspective
	CATransform3D sublayerTransform = CATransform3DIdentity;
	sublayerTransform.m34 = -0.01;
	[scrollView.layer setSublayerTransform:sublayerTransform];
	
	[self setBounds:self.frame];
}

- (AFItemView *)coverForIndex:(int)coverIndex 
{
	AFItemView *coverView = [self dequeueReusableCover];
	if (!coverView)
		coverView = [[[AFItemView alloc] initWithFrame:CGRectZero] autorelease];
		//coverView = [[[AFItemView alloc] initWithFrame:CGRectMake(0, 0, 480, 320)] autorelease];
	
	coverView.number = coverIndex;
	
	return coverView;
}

- (void)updateCoverImage:(AFItemView *)aCover {
	NSNumber *coverNumber = [NSNumber numberWithInt:aCover.number];
	UIImage *coverImage = (UIImage *)[coverImages objectForKey:coverNumber];
	if (coverImage) {
		NSNumber *coverImageHeightNumber = (NSNumber *)[coverImageHeights objectForKey:coverNumber];
		if (coverImageHeightNumber)
			[aCover setImage:coverImage originalImageHeight:[coverImageHeightNumber floatValue] reflectionFraction:kReflectionFraction];
	} else {
		[aCover setImage:defaultImage originalImageHeight:defaultImageHeight reflectionFraction:kReflectionFraction];
		[self.dataSource openFlowView:self requestImageForIndex:aCover.number];
	}
}

- (AFItemView *)dequeueReusableCover {
	AFItemView *aCover = [offscreenCovers anyObject];
	if (aCover) {
		[[aCover retain] autorelease];
		[offscreenCovers removeObject:aCover];
	}
	return aCover;
}

- (void)layoutCover:(AFItemView *)aCover selectedCover:(int)selectedIndex animated:(Boolean)animated  {
	NSLog(@"selectedIndex %i",selectedIndex);
	int coverNumber = aCover.number;
	CATransform3D newTransform;
	CGFloat newZPosition = SIDE_COVER_ZPOSITION;
	CGPoint newPosition;
	
	newPosition.x = halfScreenWidth + aCover.horizontalPosition;
	newPosition.y = halfScreenHeight + aCover.verticalPosition;
	if (coverNumber < selectedIndex) {
		newPosition.x -= CENTER_COVER_OFFSET;
		newTransform = leftTransform;
	} else if (coverNumber > selectedIndex) {
		newPosition.x += CENTER_COVER_OFFSET;
		newTransform = rightTransform;
	} else {
		newZPosition = 0;
		newTransform = CATransform3DIdentity;
	}
	
	if (animated) {
		[UIView beginAnimations:nil context:nil];
		[UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
		[UIView setAnimationBeginsFromCurrentState:YES];
	}
	
	aCover.layer.transform = newTransform;
	aCover.layer.zPosition = newZPosition;
	aCover.layer.position = newPosition;
	
	if (animated) {
		[UIView commitAnimations];
	}
}

- (void)layoutCovers:(int)selected fromCover:(int)lowerBound toCover:(int)upperBound {
	AFItemView *cover;
	NSNumber *coverNumber;
	for (int i = lowerBound; i <= upperBound; i++) {
		coverNumber = [[NSNumber alloc] initWithInt:i];
		cover = (AFItemView *)[onscreenCovers objectForKey:coverNumber];
		[coverNumber release];
		[self layoutCover:cover selectedCover:selected animated:YES];
	}
}

- (AFItemView *)findCoverOnscreen:(CALayer *)targetLayer {
	// See if this layer is one of our covers.
	NSEnumerator *coverEnumerator = [onscreenCovers objectEnumerator];
	AFItemView *aCover = nil;
	while (aCover = (AFItemView *)[coverEnumerator nextObject])
		if ([[aCover.imageView layer] isEqual:targetLayer])
			break;
	
	return aCover;
}
@end


@implementation AFOpenFlowView
@synthesize dataSource, viewDelegate, numberOfImages, defaultImage;

#define COVER_BUFFER 6

- (void)awakeFromNib 
{
	[self setUpInitialState];
}

- (id)initWithFrame:(CGRect)frame {
	if (self = [super initWithFrame:frame]) {
		[self setUpInitialState];
		self.multipleTouchEnabled = YES;
	}
	
	return self;
}

- (void)dealloc 
{
	NSLog(@"AFOpenFlowView's dealloc...?");
	[defaultImage release];
	[scrollView release];
	
	[coverImages release];
	[coverImageHeights release];
	[offscreenCovers removeAllObjects];
	[offscreenCovers release];
	
	[onscreenCovers removeAllObjects];
	[onscreenCovers release];
	//----
	
/*	[str release];
	[appDelegate release];
	
	[currentElementValue release];
	[conn release];
	[xmlParser release];
	[webData release];
	
	[roomImageArray release];
	[roomImageDic  release];
	
	[av release];
	[actInd release];
	
	
	[imgObj release];
	
	[viw release];
	
	[tapTimer release];
	*/
	//---
	[super dealloc];
}

- (void)setBounds:(CGRect)newSize {
	[super setBounds:newSize];
	
	halfScreenWidth = self.bounds.size.width / 2;
	halfScreenHeight = self.bounds.size.height / 2;

	int lowerBound = MAX(-1, selectedCoverView.number - COVER_BUFFER);
	int upperBound = MIN(self.numberOfImages - 1, selectedCoverView.number + COVER_BUFFER);

	[self layoutCovers:selectedCoverView.number fromCover:lowerBound toCover:upperBound];
	[self centerOnSelectedCover:NO];
}

- (void)setNumberOfImages:(int)newNumberOfImages {
	numberOfImages = newNumberOfImages;
	scrollView.contentSize = CGSizeMake(newNumberOfImages * COVER_SPACING + self.bounds.size.width, self.bounds.size.height);

	int lowerBound = MAX(0, selectedCoverView.number - COVER_BUFFER);
	int upperBound = MIN(self.numberOfImages - 1, selectedCoverView.number + COVER_BUFFER);
	
	if (selectedCoverView)
		[self layoutCovers:selectedCoverView.number fromCover:lowerBound toCover:upperBound];
	else
		[self setSelectedCover:0];
	
	[self centerOnSelectedCover:NO];
}

- (void)setDefaultImage:(UIImage *)newDefaultImage 
{
	[defaultImage release];
	defaultImageHeight = newDefaultImage.size.height;
	//defaultImage = [[newDefaultImage addImageReflection:kReflectionFraction] retain];
	
	CGSize size=CGSizeMake(350, 250);
	UIGraphicsBeginImageContext(size);
	[newDefaultImage drawInRect:CGRectMake(0, 0, size.width,size.height)];
	UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	defaultImage = [[scaledImage addImageReflection:kReflectionFraction] retain];

	
	
	
	// UIImage *stretchableButtonImage = [newDefaultImage stretchableImageWithLeftCapWidth:newDefaultImage.size.width topCapHeight:newDefaultImage.size.height];
	//defaultImage = [[stretchableButtonImage addImageReflection:kReflectionFraction] retain];
}

- (void)setImage:(UIImage *)image forIndex:(int)index 
{
	// Create a reflection for this image.
	/*UIImage *imageWithReflection = [image addImageReflection:kReflectionFraction];
	NSNumber *coverNumber = [NSNumber numberWithInt:index];
	[coverImages setObject:imageWithReflection forKey:coverNumber];
	[coverImageHeights setObject:[NSNumber numberWithFloat:image.size.height] forKey:coverNumber];
	//[coverImageHeights setObject:[NSNumber numberWithFloat:250.0f] forKey:coverNumber];
	*/
	
	//modified code
	UIImage *imageWithReflection = [image addImageReflection:kReflectionFraction];
	NSNumber *coverNumber = [NSNumber numberWithInt:index];
	[coverImages setObject:imageWithReflection forKey:coverNumber];
	[coverImageHeights setObject:[NSNumber numberWithFloat:250.0f] forKey:coverNumber];
	
	
	// If this cover is onscreen, set its image and call layoutCover.
	AFItemView *aCover = (AFItemView *)[onscreenCovers objectForKey:[NSNumber numberWithInt:index]];
	if (aCover) 
	{
		//[aCover setImage:imageWithReflection originalImageHeight:image.size.height reflectionFraction:kReflectionFraction];
		//[aCover setImage:imageWithReflection originalImageHeight:100.0f reflectionFraction:kReflectionFraction];
		
		/*CGSize size=CGSizeMake(200, 250);
		UIGraphicsBeginImageContext(size);
		[image drawInRect:CGRectMake(0, 0, size.width,size.height)];
		UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
		UIGraphicsEndImageContext();*/
		[aCover setImage:imageWithReflection originalImageHeight:100.0f reflectionFraction:kReflectionFraction];

			
		[self layoutCover:aCover selectedCover:selectedCoverView.number animated:NO];
	}
	
	appDelegate =(imvrAppDelegate *) [UIApplication sharedApplication].delegate;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event 
{
	
	if(multiTouches)
	{
		[NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(handleSingleTap) object:nil];
	}
	
	CGPoint startPoint = [[touches anyObject] locationInView:self];
	isDraggingACover = NO;
	
	// Which cover did the user tap?
	CALayer *targetLayer = (CALayer *)[scrollView.layer hitTest:startPoint];
	AFItemView *targetCover = [self findCoverOnscreen:targetLayer];
	isDraggingACover = (targetCover != nil);

	beginningCover = selectedCoverView.number;
	// Make sure the user is tapping on a cover.
	startPosition = (startPoint.x / 1.5) + scrollView.contentOffset.x;
	
	if (isSingleTap)
	{
		isDoubleTap = YES;
		
	}	
	isSingleTap = ([touches count] == 1);
	
	
	
	
	
	selectedCoverView.lblName.hidden = YES;
	
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event 
{
	isSingleTap = NO;
	//isDoubleTap = NO;
	
	// Only scroll if the user started on a cover.
	if (!isDraggingACover)
		return;
	
	CGPoint movedPoint = [[touches anyObject] locationInView:self];
	CGFloat offset = startPosition - (movedPoint.x / 1.5);
	CGPoint newPoint = CGPointMake(offset, 0);
	scrollView.contentOffset = newPoint;
	int newCover = offset / COVER_SPACING;
	if (newCover != selectedCoverView.number) {
		if (newCover < 0)
			[self setSelectedCover:0];
		else if (newCover >= self.numberOfImages)
			[self setSelectedCover:self.numberOfImages - 1];
		else
			[self setSelectedCover:newCover];
	}
	
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event 
{
	/*NSArray *allTouches = [touches allObjects]; 
    UITouch *touch = [touches anyObject];
    int count = [allTouches count];
	NSLog(@"COUNT :-  %d", count);
	*/
	//----
	
	if (!multiTouches) 
	{
		
        UITouch *touch = [touches anyObject];
	    
		
			
        if ([touch tapCount] == 1) 
		{
			
            [self performSelector:@selector(handleSingleTap) withObject:nil afterDelay:DOUBLE_TAP_DELAY];
		    multiTouches = YES;
        }
	}
	else 
	{
		NSLog(@"Double touch");
		AFItemView *obj = [AFItemView alloc];
		
		[obj ShowAlert:[appDelegate.roomImagesArray objectAtIndex:(int)selectedCoverView.number] imageNo:(int)selectedCoverView.number imageCount:[appDelegate.imageArray count]];
		isDoubleTap = NO;
		isSingleTap = NO;
		multiTouches = NO;
	}

	//----
	/*if (tapCount == 1 && tapTimer != nil)
	{
		
	}
	
	if(tapCount == 0)
	{
		tapCount+=1;
		[NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(tapTimerFired:) userInfo:nil repeats:NO];
	}*/
	
	
		/*
	NSArray *allTouches = [touches allObjects]; 
    UITouch *touch = [touches anyObject];
    int count = [allTouches count];
	NSLog(@"COUNT :-  %d", count);
	*/
	
	//NSLog(@"touch count :- %d", [touches count]);
	//NSLog(@"SET :- %@", touches);
	
	/*
	NSSet *allTouches = [event allTouches];
	NSLog(@"Touch count :- %d", [allTouches count]);
	UITouch *touch = [[allTouches allObjects] objectAtIndex:0];
	NSLog(@"touch :- %@", [touch description]);
	NSLog(@"222 :- %d", [touch tapCount]);
	NSLog(@"333 :- %d",[[event touchesForView:self] count]);
	
	UITouch *touch123 = [touches anyObject];
	//tapLocation = [touch123 locationInView:self];
	NSLog(@"444 :- %d", [touch123 tapCount]);
	switch ([touch tapCount])
	{
		case 1:isSingleTap = YES;
			break;
		case 2:isDoubleTap = YES;
			break;
	}	
	 */
	//--------
	/*if (isSingleTap) 
	{
		// Which cover did the user tap?
		CGPoint targetPoint = [[touches anyObject] locationInView:self];
		CALayer *targetLayer = (CALayer *)[scrollView.layer hitTest:targetPoint];
		AFItemView *targetCover = [self findCoverOnscreen:targetLayer];
		if (targetCover && (targetCover.number != selectedCoverView.number))
		{
			//[self setSelectedCover:targetCover.number];
			[self setSelectedCover:selectedCoverView.number];
		}
		if(!isDoubleTap && isSingleTap)
		{
			AFItemView *obj = [AFItemView alloc];
			NSString *rid = [appDelegate.roomIDArray objectAtIndex:selectedCoverView.number];
			[obj Call_WebService:rid];
			
		}
			
	}
	if (isDoubleTap) 
	{
		AFItemView *obj = [AFItemView alloc];

		[obj ShowAlert:[appDelegate.imageArray objectAtIndex:(int)selectedCoverView.number] imageNo:(int)selectedCoverView.number imageCount:[appDelegate.imageArray count]];
		isDoubleTap = NO;
		isSingleTap = NO;
		
	}*/
	[self centerOnSelectedCover:YES];
	
	// And send the delegate the newly selected cover message.
	if (beginningCover != selectedCoverView.number)
		if ([self.viewDelegate respondsToSelector:@selector(openFlowView:selectionDidChange:)])
			[self.viewDelegate openFlowView:self selectionDidChange:selectedCoverView.number];
	
	
}

- (void)centerOnSelectedCover:(BOOL)animated 
{
	CGPoint selectedOffset = CGPointMake(COVER_SPACING * selectedCoverView.number, 0);
	[scrollView setContentOffset:selectedOffset animated:animated];
	
	
	selectedCoverView.lblName.hidden = NO;
	selectedCoverView.lblName.text	= [appDelegate.imageNameArrary objectAtIndex:(int)selectedCoverView.number];
	NSLog(@"count :- %d", [appDelegate.imageNameArrary count]);
	NSLog(@"index :- %d", (int)selectedCoverView.number);
	NSLog(@"88888 :- %@", [appDelegate.imageNameArrary objectAtIndex:(int)selectedCoverView.number]);
}

- (void)setSelectedCover:(int)newSelectedCover 
{
	NSLog(@"selected indexxxxx %d", newSelectedCover);
	if (selectedCoverView && (newSelectedCover == selectedCoverView.number))
		return;
	
	AFItemView *cover;
	int newLowerBound = MAX(0, newSelectedCover - COVER_BUFFER);
	int newUpperBound = MIN(self.numberOfImages - 1, newSelectedCover + COVER_BUFFER);
	if (!selectedCoverView) {
		// Allocate and display covers from newLower to newUpper bounds.
		for (int i=newLowerBound; i <= newUpperBound; i++) {
			cover = [self coverForIndex:i];
			[onscreenCovers setObject:cover forKey:[NSNumber numberWithInt:i]];
			[self updateCoverImage:cover];
			[scrollView.layer addSublayer:cover.layer];
			//[scrollView addSubview:cover];
			[self layoutCover:cover selectedCover:newSelectedCover animated:NO];
		}
		
		lowerVisibleCover = newLowerBound;
		upperVisibleCover = newUpperBound;
		selectedCoverView = (AFItemView *)[onscreenCovers objectForKey:[NSNumber numberWithInt:newSelectedCover]];
		
		return;
	}
	
	// Check to see if the new & current ranges overlap.
	if ((newLowerBound > upperVisibleCover) || (newUpperBound < lowerVisibleCover)) {
		// They do not overlap at all.
		// This does not animate--assuming it's programmatically set from view controller.
		// Recycle all onscreen covers.
		AFItemView *cover;
		for (int i = lowerVisibleCover; i <= upperVisibleCover; i++) {
			cover = (AFItemView *)[onscreenCovers objectForKey:[NSNumber numberWithInt:i]];
			[offscreenCovers addObject:cover];
			[cover removeFromSuperview];
			[onscreenCovers removeObjectForKey:[NSNumber numberWithInt:cover.number]];
		}
			
		// Move all available covers to new location.
		for (int i=newLowerBound; i <= newUpperBound; i++) {
			cover = [self coverForIndex:i];
			[onscreenCovers setObject:cover forKey:[NSNumber numberWithInt:i]];
			[self updateCoverImage:cover];
			[scrollView.layer addSublayer:cover.layer];
		}

		lowerVisibleCover = newLowerBound;
		upperVisibleCover = newUpperBound;
		selectedCoverView = (AFItemView *)[onscreenCovers objectForKey:[NSNumber numberWithInt:newSelectedCover]];
		[self layoutCovers:newSelectedCover fromCover:newLowerBound toCover:newUpperBound];
		
		return;
	} else if (newSelectedCover > selectedCoverView.number) {
		// Move covers that are now out of range on the left to the right side,
		// but only if appropriate (within the range set by newUpperBound).
		for (int i=lowerVisibleCover; i < newLowerBound; i++) {
			cover = (AFItemView *)[onscreenCovers objectForKey:[NSNumber numberWithInt:i]];
			if (upperVisibleCover < newUpperBound) {
				// Tack it on the right side.
				upperVisibleCover++;
				cover.number = upperVisibleCover;
				[self updateCoverImage:cover];
				[onscreenCovers setObject:cover forKey:[NSNumber numberWithInt:cover.number]];
				[self layoutCover:cover selectedCover:newSelectedCover animated:NO];
			} else {
				// Recycle this cover.
				[offscreenCovers addObject:cover];
				[cover removeFromSuperview];
			}
			[onscreenCovers removeObjectForKey:[NSNumber numberWithInt:i]];
		}
		lowerVisibleCover = newLowerBound;
		
		// Add in any missing covers on the right up to the newUpperBound.
		for (int i=upperVisibleCover + 1; i <= newUpperBound; i++) {
			cover = [self coverForIndex:i];
			[onscreenCovers setObject:cover forKey:[NSNumber numberWithInt:i]];
			[self updateCoverImage:cover];
			[scrollView.layer addSublayer:cover.layer];
			[self layoutCover:cover selectedCover:newSelectedCover animated:NO];
		}
		upperVisibleCover = newUpperBound;
	} else {
		// Move covers that are now out of range on the right to the left side,
		// but only if appropriate (within the range set by newLowerBound).
		for (int i=upperVisibleCover; i > newUpperBound; i--) {
			cover = (AFItemView *)[onscreenCovers objectForKey:[NSNumber numberWithInt:i]];
			if (lowerVisibleCover > newLowerBound) {
				// Tack it on the left side.
				lowerVisibleCover --;
				cover.number = lowerVisibleCover;
				[self updateCoverImage:cover];
				[onscreenCovers setObject:cover forKey:[NSNumber numberWithInt:lowerVisibleCover]];
				[self layoutCover:cover selectedCover:newSelectedCover animated:NO];
			} else {
				// Recycle this cover.
				[offscreenCovers addObject:cover];
				[cover removeFromSuperview];
			}
			[onscreenCovers removeObjectForKey:[NSNumber numberWithInt:i]];
		}
		upperVisibleCover = newUpperBound;
		
		// Add in any missing covers on the left down to the newLowerBound.
		for (int i=lowerVisibleCover - 1; i >= newLowerBound; i--) {
			cover = [self coverForIndex:i];
			[onscreenCovers setObject:cover forKey:[NSNumber numberWithInt:i]];
			[self updateCoverImage:cover];
			[scrollView.layer addSublayer:cover.layer];
			//[scrollView addSubview:cover];
			[self layoutCover:cover selectedCover:newSelectedCover animated:NO];
		}
		lowerVisibleCover = newLowerBound;
	}

	if (selectedCoverView.number > newSelectedCover)
		[self layoutCovers:newSelectedCover fromCover:newSelectedCover toCover:selectedCoverView.number];
	else if (newSelectedCover > selectedCoverView.number)
		[self layoutCovers:newSelectedCover fromCover:selectedCoverView.number toCover:newSelectedCover];
	
	selectedCoverView = (AFItemView *)[onscreenCovers objectForKey:[NSNumber numberWithInt:newSelectedCover]];
	
		
			
}



-(void) handleSingleTap
{
	NSLog(@"First touch method called");
	AFItemView *obj = [AFItemView alloc];
	NSString *rid = [appDelegate.roomIDArray objectAtIndex:selectedCoverView.number];
	[obj Call_WebService:rid];
		
	multiTouches = NO;
}

#pragma mark parsing methods
/*
-(void)Call_WebService:(NSString *)roomID
{

	[self ShowAlert];
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
	[self Hidealert];
	NSLog(@"Did end");
	//NSLog(@"room image array %@", [roomImageArray description]);
	
	[self getSpecificRoomImages];
}
*/

-(void)ShowAlert{
	//[alertmessage ShowAlert];
	NSAutoreleasePool *pool = [ [ NSAutoreleasePool alloc] init];
	av=[[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	[av show];
	actInd=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	
	[actInd setFrame:CGRectMake(120, 50, 37, 37)];
	[actInd startAnimating];
	[av addSubview:actInd];
	[pool release];
}

-(void)Hidealert
{
	[av dismissWithClickedButtonIndex:0 animated:YES];
}

-(void)getSpecificRoomImages
{
	//BusinessCard *bussinessObj = [[BusinessCard alloc] init];
	
	
	/*bussinessObj.NewCoverFlowview.hidden = NO;
	bussinessObj.LocationView.hidden = YES;
	bussinessObj.NewsView.hidden = YES;
	bussinessObj.PriceView.hidden = YES;
	bussinessObj.priceWebView.hidden = YES;*/
	
	//[coverImages removeAllObjects];
	//[coverImageHeights removeAllObjects];
	
/*	NSLog(@"all array : %@",[roomImageArray description]);
	 for (int i=0; i < [roomImageArray count]; i++) 
	{
		
		//NSString *imgstr=[[roomImageArray objectAtIndex:i] valueForKey:@"RoomPic"];
		//[roomImageArray retain];
		NSString *strUrl = [NSString stringWithFormat:@"http://www.imvr.net%@",[[roomImageArray objectAtIndex:i] valueForKey:@"RoomPic"]];
		NSLog(@"URL :- %@", strUrl);
		NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:strUrl]];
		UIImage *img = [UIImage  imageWithData:imageData];
		
	
		if(i==0)
		{
			//[(AFOpenFlowView *)bussinessObj.NewCoverFlowview setDefaultImage:img];
			[self setDefaultImage:img];
		}
		else 
		{
			//[(AFOpenFlowView *)bussinessObj.NewCoverFlowview setImage:img forIndex:i];
			[self setImage:img forIndex:i];
		}
		
		
	}
	
	//[(AFOpenFlowView *)bussinessObj.NewCoverFlowview setNumberOfImages:[roomImageArray count]];
	[self setNumberOfImages:[roomImageArray count]];
	*/
	//-----------------------
	
	/*RootViewController *root = [[RootViewController alloc] init];
	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:root];
	
	[self.view addSubview:(UIView *)navController];
	imgObj = [[imageLandscape alloc] initWithNibName:@"imageLandscape" bundle:nil];
	[navController.navigationController pushViewController:imgObj animated:NO];
	*/
	
	/*imgObj = [[imageLandscape alloc] initWithNibName:@"imageLandscape" bundle:nil];
	UINavigationController * navigation = [[UINavigationController alloc] init];
	[navigation pushViewController:imgObj animated:NO];
	[navigation modalViewController
	[imgObj release];
	*/
	
	//imgObj = [[imageLandscape alloc] initWithNibName:@"imageLandscape" bundle:nil];
	
	//[bussinessObj pushImageController];
	//[bussinessObj release];
	
	//imgObj.parentViewController = self;
	//[super. pushViewController:imgObj animated:YES];
	//[imgObj release];
	//[parentViewController presentModalViewController: imgObj animated: YES];
	//[imgObj release];
	
	//AFItemView *obj = [[AFItemView alloc] init];
	selectedCoverView.viw.hidden = NO;
	
	

}

@end