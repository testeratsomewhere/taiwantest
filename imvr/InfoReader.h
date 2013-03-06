//
//  InfoReader.h
//  imvr
//
//  Created by Yaseen Mansuri on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "iAd/ADBannerView.h"


@interface InfoReader : UIViewController<ADBannerViewDelegate> {
	id _adBannerView;
	BOOL _adBannerViewIsVisible;
	UIView *_contentView;
	NSMutableArray *arr;
	IBOutlet UILabel *titlelbl;
	IBOutlet UILabel *NewsContentlbl;
	IBOutlet UILabel *HotelName;

	IBOutlet UIScrollView *scr;
}
-(IBAction)BtnBusinessCard_Click;
-(IBAction)back_click;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil andArray:(NSMutableArray *)arr1;
-(CGSize) getBlockSizeForLabel:(UILabel *)_label andWidth:(float)_width;

@property (nonatomic, retain) id adBannerView;
@property (nonatomic) BOOL adBannerViewIsVisible;
@property (nonatomic, retain) IBOutlet UIView *contentView;

@end
