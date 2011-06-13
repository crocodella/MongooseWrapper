//
//  ImageServlet.h
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Servlet.h"
#import "AccessLogDelegate.h"

/**
 * Sample servlet which returns an image. Responds to GET requests only
 */
@interface ImageServlet : Servlet {
    id<AccessLogDelegate> delegate;
}

@property (nonatomic,assign) id<AccessLogDelegate> delegate;

- (void)logPath:(NSString *)path;

@end
