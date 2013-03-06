//
//  DisplayMap.h
//  MapKitDisplay
//
//  Created by Chakra on 12/07/10.
//  Copyright 2010 Chakra Interactive Pvt Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MKAnnotation.h>


@interface DisplayMap : NSObject <MKAnnotation> {

	CLLocationCoordinate2D coordinate; 
	NSString *title; 
	NSString *subtitle;
	NSString *HotelId;
	NSString *PhoneNumber;
	NSString *HotelUrl;
	NSString *Logo;
	NSString *Fax;
	NSString *Email;
}
@property (nonatomic, assign) CLLocationCoordinate2D coordinate; 
@property (nonatomic, copy) NSString *title; 
@property (nonatomic, copy) NSString *subtitle;
@property (nonatomic, copy) NSString *HotelId;
@property (nonatomic, copy) NSString *PhoneNumber,*HotelUrl,*Logo,*Fax, *Email;
@end
