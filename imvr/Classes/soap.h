

#import <Foundation/Foundation.h>

@interface soap : NSObject {
		
	NSMutableData *myWebData;
	NSXMLParser *myXMLParser;
	NSString *TmpStr, *soapMssg,*fileName;

	NSMutableDictionary *TagDict,*soapDic,*innerDict;

	NSMutableArray *dataArr;
	BOOL flgFinish;
	int cnt;
	
	NSMutableArray *levelData, *innerArr;
	int level;
	NSString *tempstr;
}
//
//@property(nonatomic,retain)NSString *WebserviceUrl;
//@property(nonatomic,retain)NSString *userName;
//@property(nonatomic,retain)NSString *userPassword;

-(void)MakeConnection;
-(void)getSoapData:(NSMutableDictionary *)soapDicc andFilename:(NSString *)filename;
-(NSMutableArray *)postdata;
-(NSString *)ReplaceFirstNewLine:(NSString *)original;
@end
