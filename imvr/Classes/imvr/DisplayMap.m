//
//  DisplayMap.m
//  MapKitDisplay
//
//  Created by Chakra on 12/07/10.
//  Copyright 2010 Chakra Interactive Pvt Ltd. All rights reserved.
//

#import "DisplayMap.h"


@implementation DisplayMap

@synthesize coordinate,title,subtitle,HotelId,PhoneNumber,HotelUrl,Logo,Fax, Email;


-(id)initWithCoordinate:(CLLocationCoordinate2D) c{
	coordinate=c;
	//NSLog(@"%f,%f",c.latitude,c.longitude);
	return self;
}

-(void)dealloc{
	[title release];
	[subtitle release];
	[HotelId release];
	[PhoneNumber release];
	[HotelUrl release];
	[Logo release];
	[Fax release];
	[Email release];
	[super dealloc];
}

@end
