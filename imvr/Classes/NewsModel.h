//
//  NewsModel.h
//  imvr
//
//  Created by Yaseen Mansuri on 20/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "soap.h"

@interface NewsModel : UIViewController {
	soap *soapObj;
	NSString *Id;
}

-(NSMutableArray *)mgetAllData;
-(void)mGetNews;
@property (nonatomic,retain)NSString *Id;

@end
