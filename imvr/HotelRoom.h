//
//  HotelRoom.h
//  imvr
//
//  Created by Yaseen Mansuri on 17/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HotelRoom : UIViewController {
	NSString *RoomName,*RoomDesc,*RoomPic;
	NSData *imageData;
	IBOutlet UILabel *RoomNamelbl,*RoomDesclbl;
	IBOutlet UIImageView *RoomPiclbl;
}
-(IBAction)back_click;
-(void)HotelRoom;
@property(nonatomic,retain)	NSString *RoomName,*RoomDesc;
@property(nonatomic,retain)	NSData *imageData;

@end
