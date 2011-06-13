//
//  UploadServlet.h
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/13/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Servlet.h"
#import "AccessLogDelegate.h"

/**
 * Sample servlet which receives a file upload and saves it to the
 * Documents directory. WARNING: This is not a particularly robust 
 * implementation of the multipart form data standard. It should 
 * work only for cases where there is a single file element in 
 * the request.
 */
@interface UploadServlet : Servlet {
    id<AccessLogDelegate> delegate;
}

@property (nonatomic,assign) id<AccessLogDelegate> delegate;

- (void)logPath:(NSString *)path;

@end
