//
//  ServletResponse.h
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * HTTP response data
 */
@interface ServletResponse : NSObject {
    
    /**
     * The response status code. Should contain the code and the description,
     * such as "200 OK" or "404 Not Found"
     */
    NSString *statusCode;
    
    /**
     * Headers to be added to the response
     */
    NSMutableDictionary *headers;
    
    /**
     * Response body
     */
    NSData *body;
    
    /**
     * If this is set, it will override the other fields
     */
    NSData *customResponse;
    
}

@property (readwrite,retain) NSString *statusCode;
@property (readonly,retain) NSMutableDictionary *headers;
@property (readwrite,retain) NSData *body;
@property (readwrite,retain) NSString *bodyString;
@property (readwrite,retain) NSData *customResponse;

/**
 * Adds a new header to the response
 *
 * @param name Header name
 * @param val Header value
 */
- (void)addHeader:(NSString *)name withValue:(NSString *)val;

/**
 * Converts this response to binary to be sent to the client. If a custom
 * response is set, it will be used instead
 *
 * @returns the response in binary form
 */
- (NSData *)toBinary;

@end
