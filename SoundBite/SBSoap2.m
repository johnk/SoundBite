//
//  SBSoap2.m
//  SoundBite
//
//  Created by John Keyes on 6/5/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "SBSoap2.h"


@implementation SBSoap2


- (void)setDelegate:(id)new_delegate {
    m_Delegate = new_delegate;
}	

- (void)request:(User *)user requestTemplate:(NSString *)requestTemplate urlTemplate:(NSString *)urlTemplate delegate:(id)delegate {
    [self request:user requestTemplate:requestTemplate urlTemplate:urlTemplate filter:@"" delegate:delegate];
}


// The old way -- needs to be removed from the calling methods.
- (void)request:(User *)user requestTemplate:(NSString *)requestTemplate urlTemplate:(NSString *)urlTemplate filter:(NSString *)filter delegate:(id)delegate {
	m_Delegate = delegate;
	
    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);

	self.error = NO;
	self.currentUser = user;
	
    NSString *soapMessage = [NSString stringWithFormat:requestTemplate, user.userName, user.password, user.account];
	//NSLog(@"XML request: %@", soapMessage);
	
	NSString *urlString = [NSString stringWithFormat:urlTemplate, user.stack];
	NSURL *url = [NSURL URLWithString:urlString];
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		self.workInProgress = YES;
		webData = [NSMutableData data];
	} else {
		NSLog(@"theConnection is NULL");
		self.error = YES;
	}
}


// The new way.
- (void)request:(User *)user message:(NSString *)soapMessage urlTemplate:(NSString *)urlTemplate delegate:(id)delegate {
	m_Delegate = delegate;

    NSLog(@"%s [Line %d]", __PRETTY_FUNCTION__, __LINE__);
    //NSLog(@"XML request: %@", soapMessage);

    self.error = NO;
	self.currentUser = user;
	
	NSString *urlString = [NSString stringWithFormat:urlTemplate, user.stack];
	NSURL *url = [NSURL URLWithString:urlString];
	
	NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:url];
	NSString *msgLength = [NSString stringWithFormat:@"%d", [soapMessage length]];
	
	[theRequest addValue: @"text/xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
	[theRequest addValue: msgLength forHTTPHeaderField:@"Content-Length"];
	[theRequest setHTTPMethod:@"POST"];
	[theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
	
	theConnection = [[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
	
	if (theConnection) {
		self.workInProgress = YES;
		webData = [NSMutableData data];
	} else {
		NSLog(@"theConnection is NULL");
		self.error = YES;
	}
}

-(void)abortDownload {
	if (self.workInProgress == YES) {
		[theConnection cancel];
		self.workInProgress = NO;
	}
}


#pragma mark -
#pragma mark XML parser methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	[webData setLength: 0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[webData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)connectionError {
	NSLog(@"Unable to connect to that stack.");
    NSLog(@"Connection failed! Error - %@ %@", [connectionError localizedDescription], [connectionError userInfo][NSURLErrorFailingURLStringErrorKey]);
	self.error = YES;
	 // ???
	self.workInProgress = NO;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	if (self.workInProgress == YES) {
		self.workInProgress = NO;
		
		NSLog(@"DONE. Received Bytes: %d", [webData length]);
		NSString *theXMLNS = [[NSString alloc] initWithBytes: [webData mutableBytes] length:[webData length] encoding:NSUTF8StringEncoding];
		
		// remove the namespaces
		NSString *theXML = [self removeXMLNamespaces:theXMLNS];
        
        NSLog(@"XML: %@", theXML);

		NSData *xmlData = [[NSData alloc] initWithData:[theXML dataUsingEncoding:NSUTF8StringEncoding]];
		
		NSError *xmlerror;
		self.doc = [[GDataXMLDocument alloc] initWithData:xmlData options:0 error:&xmlerror];

		if (self.doc == nil) {
			self.error = YES;
			NSLog(@"No XML document");
		} else {
            /*
			NSString *xpath = @"//Data/ExternalId";			
            NSArray *nodes = [doc nodesForXPath:xpath error:nil];

			NSLog(@"Found %d Category nodes:", [nodes count]);
			for (GDataXMLElement *node in nodes) {
				NSLog(@"%@", node.stringValue);
			}
            */
		}

		
		// Verify that our delegate responds to the ...Ready method
		
		// ??? can the selector be an instance variable to make this generic???
		if ([m_Delegate respondsToSelector:@selector(dataIsReady:)]) {
			// Call the delegate method and pass ourselves along.
			[m_Delegate dataIsReady:self];
		}
	}
}

- (NSString *)removeXMLNamespaces:(NSString *)xmlWithNS {
	// See http://www.torquemaya.net/code/regex.html
    
    // remove the headers from the XML response
    
    NSRange startRange = [xmlWithNS rangeOfString:@"Envelope"];
    NSRange endRange = [xmlWithNS rangeOfString:@"Envelope>"];
    // NSString *xmlWithoutHeader = [xmlWithNS substringWithRange:NSMakeRange(startRange.location, endRange.location + 9 - startRange.location)];
    NSString *xmlWithoutHeader = [NSString stringWithFormat:@"<%@", [xmlWithNS substringWithRange:NSMakeRange(startRange.location, endRange.location + 9 - startRange.location)]];
    
    NSLog(@"***** xmlWithNS: %@", xmlWithoutHeader);
    
	// remove the xmlns attributes from main tag
	
	NSError *reerror = NULL;
	NSRegularExpression *regex1 = [NSRegularExpression regularExpressionWithPattern:@" xmlns:\\w+=['\"][^'\"]*[ '\"]"
																		   options:NSRegularExpressionCaseInsensitive
																			 error:&reerror];
	NSString *tmpString1 = [NSString stringWithString:[regex1 stringByReplacingMatchesInString:xmlWithoutHeader
																					   options:0
																						 range:NSMakeRange(0, [xmlWithoutHeader length])
																				  withTemplate:@""]];
																			 
    //NSLog(@"***** tmpString1: %@", tmpString1);

	// remove namespace prefixes from attributes on all elements
	
	reerror = NULL;
	NSRegularExpression *regex2 = [NSRegularExpression regularExpressionWithPattern:@" \\w+:(\\w+)="
                                                                            options:NSRegularExpressionCaseInsensitive
                                                                              error:&reerror];
	NSString *tmpString2 = [NSString stringWithString:[regex2 stringByReplacingMatchesInString:tmpString1
																					   options:0
																						 range:NSMakeRange(0, [tmpString1 length])
																				  withTemplate:@" $1="]];
    //NSLog(@"***** tmpString2: %@", tmpString2);

	// remove prefixes from open element tags
	
	reerror = NULL;
	NSRegularExpression *regex3 = [NSRegularExpression regularExpressionWithPattern:@"<\\w+:(.*?)>"
																		   options:NSRegularExpressionCaseInsensitive
																			 error:&reerror];
	NSString *tmpString3 = [NSString stringWithString:[regex3 stringByReplacingMatchesInString:tmpString2
																					   options:0
																						 range:NSMakeRange(0, [tmpString2 length])
																				  withTemplate:@"<$1>"]];

    //NSLog(@"***** tmpString3: %@", tmpString3);

	// remove prefixes from closed element tags
	
	reerror = NULL;
	NSRegularExpression *regex4 = [NSRegularExpression regularExpressionWithPattern:@"</\\w+:(\\w+)>"
																		   options:NSRegularExpressionCaseInsensitive
																			 error:&reerror];
	NSString *tmpString4 = [NSString stringWithString:[regex4 stringByReplacingMatchesInString:tmpString3
																					   options:0
																						 range:NSMakeRange(0, [tmpString3 length])
																				  withTemplate:@"</$1>"]];
    //NSLog(@"***** tmpString4: %@", tmpString4);

    NSLog(@"removeXMLNamespaces: XML shrunk from %d to %d bytes", [xmlWithNS length], [tmpString4 length]);
          
	return tmpString4;
}

@end
