/*
The MIT License (MIT)
Copyright (c) 2013 Crocodella Software LTDA

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/
 
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
