//
//  ServletRequest.h
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "mongoose.h"

/**
 * HTTP request data
 */
@interface ServletRequest : NSObject {
    
    /**
     * Mongoose request info. All other data is derived from this, with the
     * exception of the request body
     */
    const struct mg_request_info *requestInfo;
    
    /**
     * Request path (URI)
     */
    NSString *path;
    
    /**
     * Request headers
     */
    NSDictionary *headers;
    
    /**
     * Request parameters (can be extracted from the query string or the
     * request body in the case of a form POST
     */
    NSDictionary *parameters;
    
    /**
     * Request body
     */
    NSData *body;
}

@property (readonly,assign) const struct mg_request_info *requestInfo;
@property (readonly,retain) NSString *path;
@property (readonly,retain) NSDictionary *headers;
@property (readonly,retain) NSDictionary *parameters;
@property (readonly,retain) NSData *body;

/**
 * Creates a new request object
 *
 * @param ri Request info obtained from Mongoose
 * @param bd The body of the request
 * @returns a new request
 */
- (id)initWithRequestInfo:(const struct mg_request_info *)ri body:(NSData *)bd;

@end
