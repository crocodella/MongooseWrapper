/*
 The MIT License (MIT)
 Copyright (c) 2013 Crocodella Software LTDA
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "ServletResponse.h"


@implementation ServletResponse

@synthesize statusCode;
@synthesize headers;
@synthesize body;
@synthesize customResponse;

- (id)init {
    if ((self = [super init])) {
        headers = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (void)dealloc {
    [statusCode release];
    [headers release];
    [body release];
    [customResponse release];
    [super dealloc];
}

- (void)addHeader:(NSString *)name withValue:(NSString *)val {
    [headers setValue:val forKey:name];
}

- (NSString *)bodyString {
    NSString *ret = [[[NSString alloc] initWithData:body encoding:NSUTF8StringEncoding] autorelease];
    return ret;
}

- (void)setBodyString:(NSString *)bodyStr {
    self.body = [bodyStr dataUsingEncoding:NSUTF8StringEncoding];
}

- (NSData *)toBinary {
    
    if (customResponse) {
        return customResponse;
    }
    
    if (body) {
        [self addHeader:@"Content-Length" withValue:[NSString stringWithFormat:@"%d", [body length]]];
    }
    
    NSMutableString *response = [NSMutableString stringWithFormat:@"HTTP/1.1 %@\r\n", statusCode];
    
    for (NSString *headerName in headers) {
        [response appendFormat:@"%@: %@\r\n", headerName, [headers objectForKey:headerName]];
    }
    [response appendFormat:@"\r\n"];
    
    NSMutableData *ret = [NSMutableData data];
    [ret appendData:[response dataUsingEncoding:NSUTF8StringEncoding]];
    [ret appendData:body];
    
    return ret;
}

@end
