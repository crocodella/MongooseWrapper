//
//  SampleServlet.m
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import "HelloWorldServlet.h"


@implementation HelloWorldServlet

@synthesize delegate;

- (ServletResponse *)doGet:(ServletRequest *)request {
    
    [self performSelectorOnMainThread:@selector(logPath:) withObject:request.path waitUntilDone:NO];
    
    NSString *name = [request.parameters valueForKey:@"name"];
    
    ServletResponse *response = [[[ServletResponse alloc] init] autorelease];
    response.statusCode = @"200 OK";
    
    NSString *strBody = [NSString stringWithFormat:@"<html><body><p>Hello %@, how are you?</p></body></html>", name];
    response.bodyString = strBody;
    [response addHeader:@"Content-Type" withValue:@"text/html"];
    
    return response;
}

- (ServletResponse *)doPost:(ServletRequest *)request {
    return [self doGet:request];
}

- (void)logPath:(NSString *)path {
    [delegate didLogAccessInServlet:@"HelloWorld" forPath:path];
}

@end
