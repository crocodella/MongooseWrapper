//
//  SampleServlet.h
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Servlet.h"
#import "AccessLogDelegate.h"

/**
 * Sample servlet implementing a Hello World service. Can be invoked via
 * GET or POST methods
 */
@interface HelloWorldServlet : Servlet {
    id<AccessLogDelegate> delegate;
}

@property (nonatomic,assign) id<AccessLogDelegate> delegate;

- (void)logPath:(NSString *)path;

@end
