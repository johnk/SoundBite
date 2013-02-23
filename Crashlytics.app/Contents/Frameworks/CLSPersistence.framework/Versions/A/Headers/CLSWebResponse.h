//
//  CLSWebResponse.h
//  CLSPersistence
//
//  Created by Matt Massicotte on 9/25/12.
//
//

#import "CLSResponseCodes.h"

#import <Foundation/Foundation.h>

@interface CLSWebResponse : NSObject {
    NSURL*         _requestURL;
    NSUInteger     _statusCode;
    id             _body;
    NSError*       _error;
    NSMutableData* _responseData;
}

// the basic properties
@property (nonatomic, retain) NSURL*     requestURL;
@property (nonatomic, assign) NSUInteger statusCode;
@property (nonatomic, retain) id         body;
@property (nonatomic, retain) NSError*   error;
@property (nonatomic, retain, readonly) NSData*    responseData;

// defined as no error and responseCode between 200 and 299
@property (nonatomic, assign, readonly) BOOL wasSuccessful;

- (void)appendData:(NSData*)data;

@end
