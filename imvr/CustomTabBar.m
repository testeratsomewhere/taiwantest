//
//  RumexCustomTabBar.m
//  
//

#import "CustomTabBar.h"
#import "BusinessCard.h"


@implementation CustomTabBar

@synthesize btn1, btn2, btn3, btn4;
@synthesize lbl1, lbl2, lbl3, lbl4;
@synthesize imgTab, tabView;
@synthesize imgBg;

- (void)viewDidAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	//self.delegate = self;
	

	
	[self hideOriginalTabBar];
	[self addCustomElements];
	
}

- (void)hideTabBar
{
	self.imgTab.hidden = YES;
	self.btn1.hidden = YES;
	self.btn2.hidden = YES;
	self.btn3.hidden = YES;
	//self.btn4.hidden = YES;
	self.imgBg.hidden = YES;
}

- (void)showTabBar
{
	self.imgTab.hidden = NO;
	self.btn1.hidden = NO;
	self.btn2.hidden = NO;
	self.btn3.hidden = NO;
	//self.btn4.hidden = NO;
	self.imgBg.hidden = NO;
}

- (void)hideOriginalTabBar
{
	for(UIView *view in self.view.subviews)
	{
		if([view isKindOfClass:[UITabBar class]])
		{
			view.hidden = YES;
			break;
		}
	}
}

-(void)addCustomElements
{
	// Initialise our two images
	
	//tabView = [[UIView alloc] init];//]WithFrame:CGRectMake(0, 424, 320.0, 56)];
	//[tabView setBackgroundColor:[UIColor redColor]];
	//[self.view addSubview:tabView];

	imgTab = [[UIImageView alloc]initWithFrame:CGRectMake(0, 430, 320.0,44)];
    imgTab.image=[UIImage imageNamed:@"top_stripe.png"];
	[self.view addSubview:imgTab];
	//[tabView addSubview:imgTab];
	//[tabView insertSubview:imgTab atIndex:10];
		
	UIImage *btnImage = [UIImage imageNamed:@"ico_news.png"];
	UIImage *btnImageSelected = [UIImage imageNamed:@"ico_news_selected.png"];
	   
	btn1 = [UIButton buttonWithType:UIButtonTypeCustom]; //Setup the button
	//btn1.frame = CGRectMake(25, 435, 28, 28); // Set the frame (size and position) of the button)
	btn1.frame = CGRectMake(0, 430, 106, 50);
	//[btn1 setBackgroundImage:btnImage forState:UIControlStateNormal]; // Set the image for the normal state of the button
	//[btn1 setBackgroundImage:btnImageSelected forState:UIControlStateSelected]; // Set the image for the selected state of the button
	[btn1 setTitle:@"最新情報" forState:UIControlStateNormal];
	[btn1 setTitleColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:1.0f] forState:UIControlStateNormal];
	[btn1 setTitleColor:[UIColor colorWithRed:122/255.0f green:108/255.0f blue:52/255.0f alpha:1.0f] forState:UIControlStateSelected];
	[btn1.titleLabel setFont:[UIFont boldSystemFontOfSize:9.0]];
	[btn1 setTitleEdgeInsets:UIEdgeInsetsMake(5.0, -btnImage.size.width, -25.0, 0.0)];
	[btn1 setImage:btnImage forState:UIControlStateNormal];
	[btn1 setImageEdgeInsets:UIEdgeInsetsMake(-12.0, 0.0, 0.0, -36.0)];
	[btn1 setImage:btnImageSelected forState:UIControlStateSelected];
	[btn1 setTag:0]; // Assign the button a "tag" so when our "click" event is called we know which button was pressed.
	[btn1 setSelected:true]; // Set this button as selected (we will select the others to false as we only want Tab 1 to be selected initially
	
	
	
	
	
	 //[btn1 setTitle:@"Display" forState:UIControlStateNormal];
	//[btn1 setTitle:@"Display" forState:UIControlStateSelected];
	//[btn1 setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
	
	/*lbl1 = [[UILabel alloc] initWithFrame:CGRectMake(23, 455, 35, 28)];
	[lbl1 setText:@"Display"];
	lbl1.backgroundColor = [UIColor clearColor];
	[lbl1 setFont:[UIFont fontWithName:@"Trebuchet MS" size:9.0]];
	[lbl1 setTextColor:[UIColor colorWithRed:97/255.0f green:75/255.0f blue:48/255.0f alpha:1.0f]];
	[self.view addSubview:lbl1];
	*/
	
	[imgBg removeFromSuperview];
	imgBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 433, 106, 44)];
	imgBg.image=[UIImage imageNamed:@"transp_bg.png"];
	imgBg.backgroundColor = [UIColor clearColor];
	[self.view addSubview:imgBg];
	[self.view bringSubviewToFront:btn1];
	//[self.view bringSubviewToFront:lbl1];
	
	// Now we repeat the process for the other buttons
	btnImage = [UIImage imageNamed:@"ico_hotel_list.png"];
	btnImageSelected = [UIImage imageNamed:@"ico_hotel_list_selected.png"];
	btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn2.frame = CGRectMake(106, 430, 106, 50);
	//[btn2 setBackgroundImage:btnImage forState:UIControlStateNormal];
	//[btn2 setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
	[btn2 setTitle:@"飯店列表" forState:UIControlStateNormal];
	[btn2 setTitleColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:1.0f] forState:UIControlStateNormal];
	[btn2 setTitleColor:[UIColor colorWithRed:122/255.0f green:108/255.0f blue:52/255.0f alpha:1.0f] forState:UIControlStateSelected];
	[btn2.titleLabel setFont:[UIFont boldSystemFontOfSize:9.0]];
	[btn2 setTitleEdgeInsets:UIEdgeInsetsMake(5.0, -btnImage.size.width, -25.0, 7.0)];
	[btn2 setImage:btnImage forState:UIControlStateNormal];
	[btn2 setImage:btnImageSelected forState:UIControlStateSelected];
	[btn2 setImageEdgeInsets:UIEdgeInsetsMake(-12.0, 0.0, 0.0, -30.0)];
	[btn2 setTag:1];
	
	/*lbl2 = [[UILabel alloc] initWithFrame:CGRectMake(103, 455, 35, 28)];
	[lbl2 setText:@"Activity"];
	lbl2.backgroundColor = [UIColor clearColor];
	[lbl2 setFont:[UIFont fontWithName:@"Trebuchet MS" size:9.0]];
	[lbl2 setTextColor:[UIColor colorWithRed:97/255.0f green:75/255.0f blue:48/255.0f alpha:1.0f]];
	[self.view addSubview:lbl2];
	*/
	
	btnImage = [UIImage imageNamed:@"ico_map.png"];
	btnImageSelected = [UIImage imageNamed:@"ico_map_selected.png"];
	btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn3.frame = CGRectMake(212, 430, 106, 50);
	//[btn3 setBackgroundImage:btnImage forState:UIControlStateNormal];
	//[btn3 setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
	[btn3 setTitle:@"地圖索引" forState:UIControlStateNormal];
	[btn3 setTitleColor:[UIColor colorWithRed:255 green:255 blue:255 alpha:1.0f] forState:UIControlStateNormal];
	[btn3 setTitleColor:[UIColor colorWithRed:122/255.0f green:108/255.0f blue:52/255.0f alpha:1.0f] forState:UIControlStateSelected];
	[btn3.titleLabel setFont:[UIFont boldSystemFontOfSize:9.0]];
	[btn3 setTitleEdgeInsets:UIEdgeInsetsMake(5.0, -btnImage.size.width, -25.0, 11.0)];
	[btn3 setImage:btnImage forState:UIControlStateNormal];
	[btn3 setImage:btnImageSelected forState:UIControlStateSelected];
	[btn3 setImageEdgeInsets:UIEdgeInsetsMake(-12.0, 0.0, 0.0, -30.0)];
	[btn3 setTag:2];
	
	/*lbl3 = [[UILabel alloc] initWithFrame:CGRectMake(183, 455, 35, 28)];
	[lbl3 setText:@"Search"];
	lbl3.backgroundColor = [UIColor clearColor];
	[lbl3 setFont:[UIFont fontWithName:@"Trebuchet MS" size:9.0]];
	[lbl3 setTextColor:[UIColor colorWithRed:97/255.0f green:75/255.0f blue:48/255.0f alpha:1.0f]];
	[self.view addSubview:lbl3];
	*/
	
	/*btnImage = [UIImage imageNamed:@"tab_bar_icon_settings_off.png"];
	btnImageSelected = [UIImage imageNamed:@"tab_bar_icon_settings_on.png"];
	btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
	btn4.frame = CGRectMake(241, 430, 80, 50);
	//[btn4 setBackgroundImage:btnImage forState:UIControlStateNormal];
	//[btn4 setBackgroundImage:btnImageSelected forState:UIControlStateSelected];
	[btn4 setTitle:@"Settings" forState:UIControlStateNormal];
	[btn4 setTitleColor:[UIColor colorWithRed:97/255.0f green:75/255.0f blue:48/255.0f alpha:1.0f] forState:UIControlStateNormal];
	[btn4 setTitleColor:[UIColor colorWithRed:238/255.0f green:227/255.0f blue:198/255.0f alpha:1.0f] forState:UIControlStateSelected];
	[btn4.titleLabel setFont:[UIFont boldSystemFontOfSize:9.0]];
	[btn4 setTitleEdgeInsets:UIEdgeInsetsMake(5.0, -btnImage.size.width, -25.0, 0.0)];
	[btn4 setImage:btnImage forState:UIControlStateNormal];
	[btn4 setImage:btnImageSelected forState:UIControlStateSelected];
	[btn4 setImageEdgeInsets:UIEdgeInsetsMake(-12.0, 0.0, 0.0, -30.0)];
	[btn4 setTag:3];
	*/
	/*lbl4 = [[UILabel alloc] initWithFrame:CGRectMake(263, 455, 35, 28)];
	[lbl4 setText:@"Settings"];
	lbl4.backgroundColor = [UIColor clearColor];
	[lbl4 setFont:[UIFont fontWithName:@"Trebuchet MS" size:9.0]];
	[lbl4 setTextColor:[UIColor colorWithRed:97/255.0f green:75/255.0f blue:48/255.0f alpha:1.0f]];
	[self.view addSubview:lbl4];
	*/

	[self.view addSubview:btn1];
	[self.view addSubview:btn2];
	[self.view addSubview:btn3];
	//[self.view addSubview:btn4];

	// Setup event handlers so that the buttonClicked method will respond to the touch up inside event.
	[btn1 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[btn2 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	[btn3 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	//320[btn4 addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
	
}

- (void)buttonClicked:(id)sender
{
	int tagNum = [sender tag];
	[self selectTab:tagNum];
}

- (void)selectTab:(int)tabID
{
	/*imvrAppDelegate *appDelegate = (imvrAppDelegate *) [UIApplication sharedApplication].delegate;
	navArray = [appDelegate.tabBarController viewControllers];
	conArrayTab1 = [[navArray objectAtIndex:0] viewControllers];
	conArrayTab2 = [[navArray objectAtIndex:1] viewControllers];
	conArrayTab3 = [[navArray objectAtIndex:2] viewControllers];
	if([conArrayTab1 count] > 1)
	{
		for(int i = 0; i<[conArrayTab1 count]; i++)
		{
			NSLog(@".... %@", [conArrayTab1 objectAtIndex:i]);
			if([[conArrayTab1 objectAtIndex:i] isKindOfClass:[BusinessCard class]])
			{
				UINavigationController *navController = (UINavigationController *)[conArrayTab1 objectAtIndex:i];
				[navController popViewControllerAnimated:NO];
				//[navController popToViewController:[conArray objectAtIndex:i] animated:NO];
				//[[conArrayTab1 objectAtIndex:i] popViewControllerAnimated:NO];
				break;
			}
		}
	 }
	if([conArrayTab2 count] > 1)
	{
		for(int i = 0; i<[conArrayTab2 count]; i++)
		{
			NSLog(@".... %@", [conArrayTab2 objectAtIndex:i]);
			if([[conArrayTab2 objectAtIndex:i] isKindOfClass:[BusinessCard class]])
			{
								
				UINavigationController *navController = (UINavigationController *) [conArrayTab2 objectAtIndex:i];
				[navController popViewControllerAnimated:NO];
				//UINavigationController *navController = (UINavigationController *)[self selectedViewController];
				//[navController popToViewController:[conArray objectAtIndex:i] animated:NO];
				//[[conArrayTab2 objectAtIndex:i] popViewControllerAnimated:NO];
				break;
			}
		}
	}
	if([conArrayTab3 count] > 1)
	{
		for(int i = 0; i<[conArrayTab3 count]; i++)
		{
			NSLog(@".... %@", [conArrayTab3 objectAtIndex:i]);
			if([[conArrayTab3 objectAtIndex:i] isKindOfClass:[BusinessCard class]])
			{
				UINavigationController *navController = (UINavigationController *)[conArrayTab3 objectAtIndex:i];
				[navController popViewControllerAnimated:NO];
				//UINavigationController *navController = (UINavigationController *)[self selectedViewController];
				//[navController popToViewController:[conArray objectAtIndex:i] animated:NO];
				//[[conArrayTab3 objectAtIndex:i] popViewControllerAnimated:NO];
				break;
			}
		}
	}
	*/
	
	
	switch(tabID)
	{
		case 0:
			
			//navArray = [appDelegate.tabBarController viewControllers];
			//conArray = [[navArray objectAtIndex:0] viewControllers];
			/*if([conArray count] > 1)
			{
				for(int i = 0; i<[conArray count]; i++)
				{
					NSLog(@".... %@", [conArray objectAtIndex:i]);
					if([[conArray objectAtIndex:i] isKindOfClass:[CollectionsViewController class]])
					{
						UINavigationController *navController = (UINavigationController *)[self selectedViewController];
						[navController popToViewController:[conArray objectAtIndex:i] animated:NO];
						break;
					}
				}
			}*/
			
			[imgBg removeFromSuperview];
			imgBg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 433, 106, 44)];
			imgBg.image=[UIImage imageNamed:@"transp_bg.png"];
			imgBg.backgroundColor = [UIColor clearColor];
			[self.view addSubview:imgBg];
			[self.view bringSubviewToFront:btn1];
			//[self.view bringSubviewToFront:lbl1];
			//[lbl1 setTextColor:[UIColor colorWithRed:238/255.0f green:227/255.0f blue:198/255.0f alpha:1.0f]];
			[btn1 setSelected:true];
			[btn2 setSelected:false];
			[btn3 setSelected:false];
			//[btn4 setSelected:false];
			break;
		case 1:
			[imgBg removeFromSuperview];
			imgBg = [[UIImageView alloc]initWithFrame:CGRectMake(106, 433, 106, 44)];
			imgBg.image=[UIImage imageNamed:@"transp_bg.png"];
			imgBg.backgroundColor = [UIColor clearColor];
			[self.view addSubview:imgBg];
			[self.view bringSubviewToFront:btn2];
			//[self.view bringSubviewToFront:lbl2];
			//[lbl2 setTextColor:[UIColor colorWithRed:238/255.0f green:227/255.0f blue:198/255.0f alpha:1.0f]];
			[btn1 setSelected:false];
			[btn2 setSelected:true];
			[btn3 setSelected:false];
			//[btn4 setSelected:false];
			break;
		case 2:
			[imgBg removeFromSuperview];
			imgBg = [[UIImageView alloc]initWithFrame:CGRectMake(212, 433, 106, 44)];
			imgBg.image=[UIImage imageNamed:@"transp_bg.png"];
			imgBg.backgroundColor = [UIColor clearColor];
			[self.view addSubview:imgBg];
			[self.view bringSubviewToFront:btn3];
			//[self.view bringSubviewToFront:lbl3];
			//[lbl3 setTextColor:[UIColor colorWithRed:238/255.0f green:227/255.0f blue:198/255.0f alpha:1.0f]];
			[btn1 setSelected:false];
			[btn2 setSelected:false];
			[btn3 setSelected:true];
			//[btn4 setSelected:false];
			break;
			
			
	}	
	
	self.selectedIndex = tabID;
	if (self.selectedIndex == tabID) 
	{
		UINavigationController *navController = (UINavigationController *)[self selectedViewController];
		[navController popToRootViewControllerAnimated:NO];
	} 
	else 
	{
		self.selectedIndex = tabID;
	}
	
}




- (void)dealloc 
{
	[btn1 release];
	[btn2 release];
	[btn3 release];
	[btn4 release];
	
	[lbl1 release];
	[lbl2 release];
	[lbl3 release];
	[lbl4 release];

	
	
    [super dealloc];
	
}

@end
