@interface AppRecord : NSObject
{
    NSString *appName;
    UIImage *appIcon;
    NSString *imageURLString;
}

@property (nonatomic, retain) NSString *appName;
@property (nonatomic, retain) UIImage *appIcon;
@property (nonatomic, retain) NSString *imageURLString;

@end