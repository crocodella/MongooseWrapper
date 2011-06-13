//
//  Servlet.m
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import "Servlet.h"


@implementation Servlet

- (ServletResponse *)doGet:(ServletRequest *)request {
    NSLog(@"%@", @"Override me if you want to support GET!");
    return [self sendNotImplemented];
}

- (ServletResponse *)doPost:(ServletRequest *)request {
    NSLog(@"%@", @"Override me if you want to support POST!");
    return [self sendNotImplemented];
}

- (ServletResponse *)doPut:(ServletRequest *)request {
    NSLog(@"%@", @"Override me if you want to support PUT!");
    return [self sendNotImplemented];
}

- (ServletResponse *)doDelete:(ServletRequest *)request {
    NSLog(@"%@", @"Override me if you want to support DELETE!");
    return [self sendNotImplemented];
}

- (ServletResponse *)sendInternalError {
    ServletResponse *response = [[[ServletResponse alloc] init] autorelease];
    response.statusCode = @"500 Internal Server Error";
    response.bodyString = @"<html><head><title>500 - Internal Server Error</title></head><body><h1>500 - Internal Server Error</h1></body></html>";
    [response addHeader:@"Content-Type" withValue:@"text/html"];
    
    return response;
}

- (ServletResponse *)sendNotFound {
    ServletResponse *response = [[[ServletResponse alloc] init] autorelease];
    response.statusCode = @"404 Not Found";
    response.bodyString = @"<html><head><title>404 - Not Found</title></head><body><h1>404 - Not Found</h1></body></html>";
    [response addHeader:@"Content-Type" withValue:@"text/html"];
    
    return response;
}

- (ServletResponse *)sendNotImplemented {
    ServletResponse *response = [[[ServletResponse alloc] init] autorelease];
    response.statusCode = @"501 Not Implemented";
    response.bodyString = @"<html><head><title>501 - Not Implemented</title></head><body><h1>501 - Not Implemented</h1></body></html>";
    [response addHeader:@"Content-Type" withValue:@"text/html"];
    
    return response;
}

@end
