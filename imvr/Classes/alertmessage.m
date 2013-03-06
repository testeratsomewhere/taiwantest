//
//  alertmessage.m
//  personalplan
//

//

#import "alertmessage.h"
UIAlertView *av;
UIActivityIndicatorView *actInd;

@implementation alertmessage

+(void)showAlertMessage : (NSString *) message
{
	UIAlertView *alert = [[UIAlertView alloc]initWithFrame:CGRectMake(10, 170, 300, 120)];
	alert.message=message;
	alert.title=@"Message";
	[alert addButtonWithTitle:@"OK"];
	[alert show];
	[alert release];	
}


+(void)ShowAlert{
	//if(av!=nil && [av retainCount]>0){ [av release]; av=nil; }
	//if(actInd!=nil && [actInd retainCount]>0){ [actInd removeFromSuperview];[actInd release]; actInd=nil; }
	if (av)
        return;

	NSAutoreleasePool *pool = [ [ NSAutoreleasePool alloc ] init ];
	
	av=[[UIAlertView alloc] initWithTitle:@"Please wait..." message:nil delegate:self cancelButtonTitle:nil otherButtonTitles:nil];
	NSLog(@"retain count before show: %i", av.retainCount);
	[av show];
	NSLog(@"retain count before show: %i", av.retainCount);
	actInd=[[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
	
	[actInd setFrame:CGRectMake(120, 50, 37, 37)];
	[actInd startAnimating];
	
	[av addSubview:actInd];
	av.hidden=YES;

	//[av show];
	[av release];
	NSLog(@"retain count before show: %i", av.retainCount);
	[actInd release];
	//[av autorelease];
	[pool drain];
}

+(void)hideAlert{
	[av dismissWithClickedButtonIndex:0 animated:YES];
	//[av release];
	//av = nil;
	//[actInd removeFromSuperview];
	//[av release];
	/*if(av!=nil && [av retainCount]>0){ [av release]; av=nil; }
	if(actInd!=nil && [actInd retainCount]>0){ [actInd removeFromSuperview];[actInd release]; actInd=nil; }	*/
}

+(void)ShowMessageBoxWithTitle:(NSString*)strTitle Message:(NSString*)strMessage Button:(NSString*)strButtonTitle{
	//if(av!=nil && [av retainCount]>0){ [av release]; av=nil; }	
	av = [[UIAlertView alloc]initWithTitle:strTitle message:strMessage  delegate:nil cancelButtonTitle:strButtonTitle otherButtonTitles:nil];
	[av show];
}



- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
        // Initialization code
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)dealloc {
	[av dismissWithClickedButtonIndex:0 animated:YES];
    [av release];

    [super dealloc];
}


@end
