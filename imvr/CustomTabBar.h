//
//  RumexCustomTabBar.h
//  
//

#import <UIKit/UIKit.h>

#import "imvrAppDelegate.h"

@class BusinessCard;


@interface CustomTabBar : UITabBarController <UITabBarControllerDelegate>
{
	UIButton *btn1;
	UIButton *btn2;
	UIButton *btn3;
	UIButton *btn4;
	
	UIImageView *imgTab;
	
	UILabel *lbl1;
	UILabel *lbl2;
	UILabel *lbl3;
	UILabel *lbl4;
	
	UIImageView *imgBg;
	NSArray *navArray;
	NSArray *conArrayTab1;
	NSArray *conArrayTab2;
	NSArray *conArrayTab3;
	
	
	UIView *tabView;
}

@property (nonatomic, retain) UIButton *btn1;
@property (nonatomic, retain) UIButton *btn2;
@property (nonatomic, retain) UIButton *btn3;
@property (nonatomic, retain) UIButton *btn4;

@property (nonatomic, retain) UILabel *lbl1;
@property (nonatomic, retain) UILabel *lbl2;
@property (nonatomic, retain) UILabel *lbl3;
@property (nonatomic, retain) UILabel *lbl4;

@property (nonatomic, retain) UIImageView *imgBg;

@property (nonatomic, retain) UIImageView *imgTab;

@property (nonatomic, retain) UIView *tabView;

-(void) hideTabBar;
-(void) showTabBar;
-(void) hideOriginalTabBar;
-(void) addCustomElements;
-(void) selectTab:(int)tabID;

@end
