//
//  Servlet.h
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

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
