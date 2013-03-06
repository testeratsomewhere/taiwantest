//
//  alertmessage.h
//  personalplan
//
//  Created by hidden brains on 17/06/10.
//  Copyright 2010 hiddenbrains. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface alertmessage : UIView <UIAlertViewDelegate>{
}

+(void)ShowAlert;
+(void)hideAlert;
+(void)showAlertMessage : (NSString *) message;
+(void)ShowMessageBoxWithTitle:(NSString*)strTitle Message:(NSString*)strMessage Button:(NSString*)strButtonTitle;

@end
