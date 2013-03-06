    //
//  NewsModel.m
//  imvr
//
//  Created by Yaseen Mansuri on 20/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "NewsModel.h"


@implementation NewsModel

@synthesize Id;
-(void)mGetNews { 
	
	NSMutableDictionary *soapDic=[[NSMutableDictionary alloc]init];
	[soapDic setObject:@"318" forKey:@"id"];
	
	if(soapObj == nil) {
		soapObj = [[soap alloc]init];
	}
	
	[soapObj getSoapData:soapDic andFilename:@"getnews.php"];
	[soapDic release];
}

-(NSMutableArray *)mgetAllData{
	NSMutableArray *tmp = [[NSMutableArray alloc]init];
	tmp = [soapObj postdata];
	if([tmp count] > 0){
		return tmp;
	}
	return nil;
}

-(void) dealloc
{
	[super dealloc];
}



@end
