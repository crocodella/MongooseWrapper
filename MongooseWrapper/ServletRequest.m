/*
 The MIT License (MIT)
 Copyright (c) 2013 Crocodella Software LTDA
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "ServletRequest.h"


@implementation ServletRequest

@synthesize requestInfo;
@synthesize path;
@synthesize headers;
@synthesize parameters;
@synthesize body;

- (void)extractParametersFrom:(NSString *)string {
    NSArray *paramsStr = [string componentsSeparatedByString:@"&"];
    
    for (NSString *param in paramsStr) {
        NSArray *vals = [param componentsSeparatedByString:@"="];
        [parameters setValue:[vals objectAtIndex:1] forKey:[vals objectAtIndex:0]];
    }
}

- (id)initWithRequestInfo:(const struct mg_request_info *)ri body:(NSData *)bd {
    
    if ((self = [super init])) {
        
        requestInfo = ri;
        body = [bd retain];
        
        path = [[NSString stringWithUTF8String:ri->uri] retain];
        
        BOOL isPost = strcmp(ri->request_method, "POST") == 0;
        
        headers = [[NSMutableDictionary alloc] initWithCapacity:ri->num_headers];
        parameters = [[NSMutableDictionary alloc] init];
        
        // Extract all headers from the request
        
        for (int i = 0; i < ri->num_headers; i++) {
            
            NSString *name = [NSString stringWithUTF8String:ri->http_headers[i].name];
            NSString *val = [NSString stringWithUTF8String:ri->http_headers[i].value];
            
            [headers setValue:val forKey:name];
            
            // If it's a form POST, extract parameters from the request body
            
            if (isPost && [name isEqualToString:@"Content-Type"] && [val isEqualToString:@"application/x-www-form-urlencoded"]) {
                NSString *strBody = [[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding];
                [self extractParametersFrom:strBody];
                [strBody release];
            }
        }
        
        // Extract parameters from query string, if any
        
        if (ri->query_string != NULL) {
            
            NSString *query = [NSString stringWithUTF8String:ri->query_string];
            [self extractParametersFrom:query];
        }
    }
    return self;
}

- (void)dealloc {
    [path release];
    [headers release];
    [parameters release];
    [body release];
    [super dealloc];
}

@end
