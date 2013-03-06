

#import "alertmessage.h"
#import "soap.h"
#import "AppConfig.h"

@implementation soap

//-(void)getSoapData:(NSString *)soapMsg{

-(void)getSoapData:(NSMutableDictionary *)soapDicc andFilename:(NSString *)filename{
	levelData = [[NSMutableArray alloc]init];
	innerArr = [[NSMutableArray alloc]init];
	innerDict = [[NSMutableDictionary alloc]init];
	soapDic=[[NSMutableDictionary alloc]initWithDictionary:soapDicc];
	fileName = filename;
	
	if(dataArr!=nil && [dataArr retainCount]>0){
		[dataArr release];
		dataArr = nil;
	}
	if(TagDict!=nil && [TagDict retainCount]>0){
		[TagDict release];
		TagDict = nil;
	}
	
	if(TmpStr!=nil && [TmpStr retainCount]>0){
		[TmpStr release];
		TmpStr = nil;
	}
	flgFinish = FALSE;
	[self MakeConnection];
}

-(NSMutableArray *)postdata{
	if(flgFinish){
		return dataArr;
	}else {
		return nil;
	}
}

-(void)MakeConnection{
	
	

	//NSURL *myURL = [NSURL URLWithString:@"http://www.imvr.net/iphonexml/getnews.php?id=318"];
	NSString *webservice=@"http://www.imvr.net/iphonexml/";
	
	NSURL *myURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@/%@",webservice,fileName]];

	NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];

	[request setURL:myURL];
	
	[request setHTTPMethod:@"POST"];
	
	NSString *boundary = [NSString stringWithString:@"---------------------------14737809831466499882746641449"];
	NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@",boundary];
	[request addValue:contentType forHTTPHeaderField: @"Content-Type"];
	
	NSMutableData *body = [NSMutableData data];
	
	
  // for(int i=0;i<[soapDic count];i++){
	for (NSString *key in soapDic){
		if([key isEqualToString:@"Image"])
		{
			[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
			[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; filename=\"Image\"\r\n",fileName] dataUsingEncoding:NSUTF8StringEncoding]];
			[body appendData:[[NSString stringWithString:@"Content-Type: application/octet-stream\r\n\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
			[body appendData:[NSData dataWithData:[soapDic objectForKey:@"Image"]]];
		}
		else
		{
			[body appendData:[[NSString stringWithFormat:@"\r\n--%@\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
			[body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",key] dataUsingEncoding:NSUTF8StringEncoding]];
			[body appendData:[[NSString stringWithFormat:@"%@",[soapDic objectForKey:key]] dataUsingEncoding:NSUTF8StringEncoding]];
				
		}	
	}

	[body appendData:[[NSString stringWithFormat:@"\r\n--%@--\r\n",boundary] dataUsingEncoding:NSUTF8StringEncoding]];
	
	[request setHTTPBody:body];
	NSURLConnection *myConnection=[[NSURLConnection alloc] initWithRequest:request delegate:self];
	
	TagDict = [[NSMutableDictionary alloc]init];
	dataArr = [[NSMutableArray alloc]init];
	
	if(myConnection){
		//	[alertmessage ShowAlert];
		myWebData = [[NSMutableData alloc]  initWithLength:0];
	}
	else{
		flgFinish = TRUE;
		[TagDict setObject:@"ConnectionLost" forKey:@"ERROR"];
		[dataArr addObject:TagDict];
		[alertmessage ShowMessageBoxWithTitle:@"Message" Message:@"Internet Connection is not available." Button:@"OK"];
		[alertmessage hideAlert];
		
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error{
	flgFinish = TRUE;
	
	[TagDict setObject:@"ConnectionLost" forKey:@"ERROR"];
	[dataArr addObject:TagDict];
	
	[alertmessage hideAlert];
    [myWebData release];
	[alertmessage ShowMessageBoxWithTitle:@"Message" Message:@"Internet Connection is lost." Button:@"OK"];
	//[alertmessage hideAlert];
}
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response{
    [myWebData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    [myWebData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection{
    //NSString *str = [[NSString alloc] initWithBytes:[myWebData bytes] length:[myWebData length] encoding:NSStringEncodingConversionAllowLossy];
//   NSLog(@"\n==============\n SOAP Response: \n\n%@\n==============\n\n",str);
//  	
    if(myXMLParser!=nil && [myXMLParser retainCount]>0){
        myXMLParser.delegate = nil;
        myXMLParser = nil;
    }
    myXMLParser = [[NSXMLParser alloc] initWithData:myWebData];
    myXMLParser.delegate = self;
    [myXMLParser parse];
    [myWebData release];
}

#pragma mark XMLParser methods
-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict{
	//TmpStr = [[NSMutableString alloc]initWithString:elementName];
//	[levelData  addObject:elementName];
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	
	//NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc]init];
//	[tmpDict setObject:string forKey:TmpStr]; 
//
//	if([levelData count] %4  == 0) {
//
//		if([innerDict objectForKey:TmpStr] != nil) {
//			[innerDict setObject:[[innerDict objectForKey:TmpStr] stringByAppendingString:[self ReplaceFirstNewLine:string]] forKey:TmpStr];
//		} else {
//			[innerDict setObject:string forKey:TmpStr];
//			[innerArr addObject:tmpDict];
//		}
//	} else {
//		[TagDict setObject:string forKey:TmpStr];
//	}

	//NSLog(@"\n\n%@ ==== %@\n\n",TmpStr,string);
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
	//if([levelData count] % 3 == 0 && [innerArr count] > 0) {
//		NSMutableArray *tmparr = [[NSMutableArray alloc]init];
//		if([TagDict objectForKey:[levelData objectAtIndex:([levelData count]-2)]] != nil){
//			tmparr = [TagDict objectForKey:[levelData objectAtIndex:([levelData count]-2)]];
//		}	
//		[tmparr addObject:innerDict];
//		[TagDict setObject:tmparr forKey:[levelData objectAtIndex:([levelData count]-2)]];
//		[innerArr release];
//		[innerDict release];
//		innerDict = [[NSMutableDictionary alloc]init];
//		innerArr = [[NSMutableArray alloc]init];
//	}
//	if([levelData count] == 1){
//		[dataArr addObject:TagDict];
//	}
//	[levelData  removeLastObject];
}

-(void)parserDidEndDocument:(NSXMLParser *)parser{
	flgFinish = TRUE;
}

-(void)dealloc{
	[super dealloc];
	[myWebData release];
	[myXMLParser release];
	[TmpStr release];
	[soapMssg release];
	[soapDic release];
	[fileName release];
	[TagDict release];
}

-(NSString *)ReplaceFirstNewLine:(NSString *)original{
	NSMutableString * newString = [NSMutableString stringWithString:original];
	
	NSRange foundRange = [original rangeOfString:@"\n"];
	if (foundRange.location != NSNotFound)
		{
			[newString replaceCharactersInRange:foundRange withString:@""];
		}
	
	return [[newString retain] autorelease];
}
@end


