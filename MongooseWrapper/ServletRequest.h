/*
 The MIT License (MIT)
 Copyright (c) 2013 Crocodella Software LTDA
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

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
