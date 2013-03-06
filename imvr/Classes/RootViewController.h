//
//  RootViewController.h
//  imvr
//
//  Created by Yaseen Mansuri on 16/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController <UIPickerViewDelegate,UIActionSheetDelegate,UIPickerViewDataSource,UITextFieldDelegate>{
	IBOutlet UIActivityIndicatorView *act;
}

@end
