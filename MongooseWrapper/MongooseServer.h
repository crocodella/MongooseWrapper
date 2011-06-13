//
//  MoongoseServer.h
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Servlet.h"
#import "mongoose.h"

/**
 * Main wrapper object, handles the dispatching of requests to servlets
 */
@interface MongooseServer : NSObject {
    
    /**
     * Mongoose context
     */
    struct mg_context *ctx;
    
    /**
     * Servlets, where the key is the URI path
     */
    NSMutableDictionary *servlets;
}

@property (readonly,assign) struct mg_context *ctx;
@property (readonly,retain) NSMutableDictionary *servlets;

/**
 * Creates a new server in the specified port, with an option to allow
 * directory and file listing
 *
 * @param port The port the server will be listening on
 * @param listing Flag indicating if directory listing is enabled
 * @returns a new server
 */
- (id)initWithPort:(int)port allowDirectoryListing:(BOOL)listing;

/**
 * Creates a new server with the options specified. Check the Mongoose
 * server documentation for the available options.
 *
 * @param options Array of options to initialize the server
 * @returns a new server
 */
- (id)initWithOptions:(const char *[])options;

/**
 * Registers a new servlet in the server
 *
 * @param servlet The servlet to be registered
 * @param path The URI path. It may contain the * wildcard
 */
- (void)addServlet:(Servlet *)servlet forPath:(NSString *)path;

/**
 * Removes the server registered for the path
 *
 * @param path The URI path
 */
- (void)removeServletForPath:(NSString *)path;

@end
