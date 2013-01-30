/*
 The MIT License (MIT)
 Copyright (c) 2013 Crocodella Software LTDA
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import <Foundation/Foundation.h>
#import "ServletRequest.h"
#import "ServletResponse.h"

/**
 * Main servlet class. Should not be used directly, but subclassed
 */
@interface Servlet : NSObject {
    
}

/**
 * Handles a GET request
 *
 * @param request The request data
 * @returns a response to be sent to the client
 */
- (ServletResponse *)doGet:(ServletRequest *)request;

/**
 * Handles a POST request
 *
 * @param request The request data
 * @returns a response to be sent to the client
 */
- (ServletResponse *)doPost:(ServletRequest *)request;

/**
 * Handles a PUT request
 *
 * @param request The request data
 * @returns a response to be sent to the client
 */
- (ServletResponse *)doPut:(ServletRequest *)request;

/**
 * Handles a DELETE request
 *
 * @param request The request data
 * @returns a response to be sent to the client
 */
- (ServletResponse *)doDelete:(ServletRequest *)request;

/**
 * Convenience method to return a 500 error
 *
 * @returns a response to be sent to the client
 */
- (ServletResponse *)sendInternalError;

/**
 * Convenience method to return a 404 error
 *
 * @returns a response to be sent to the client
 */
- (ServletResponse *)sendNotFound;

/**
 * Convenience method to return a 401 error
 *
 * @returns a response to be sent to the client
 */
- (ServletResponse *)sendNotImplemented;

@end
