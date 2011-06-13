//
//  ImageServlet.m
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import "ImageServlet.h"


@implementation ImageServlet

@synthesize delegate;

- (ServletResponse *)doGet:(ServletRequest *)request {

    [self performSelectorOnMainThread:@selector(logPath:) withObject:request.path waitUntilDone:NO];
    
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:@"logo" ofType:@"png"];
    NSURL *imageURL = [NSURL fileURLWithPath:imagePath];
    NSData *imageData = [NSData dataWithContentsOfURL:imageURL];
    
    ServletResponse *response = [[[ServletResponse alloc] init] autorelease];
    response.statusCode = @"200 OK";
    response.body = imageData;
    [response addHeader:@"Content-Type" withValue:@"image/png"];
    
    return response;
}

- (void)logPath:(NSString *)path {
    [delegate didLogAccessInServlet:@"ImageServlet" forPath:path];
}

@end
