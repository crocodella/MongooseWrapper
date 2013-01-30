/*
 The MIT License (MIT)
 Copyright (c) 2013 Crocodella Software LTDA
 
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

#import "UploadServlet.h"


@implementation UploadServlet

@synthesize delegate;

- (ServletResponse *)doPost:(ServletRequest *)request {
    
    [self performSelectorOnMainThread:@selector(logPath:) withObject:request.path waitUntilDone:NO];
    
    // WARNING: This is not a particularly robust implementation of the multipart
    // form data standard. It should work only for cases where there is a single
    // file element in the request.
    
    NSString *contentType = [request.headers valueForKey:@"Content-Type"];
    NSArray *comps = [contentType componentsSeparatedByString:@";"];
    
    if ([contentType rangeOfString:@"multipart/form-data"].location == NSNotFound) {
        return [self sendInternalError];
    }
    
    NSArray *bounds = [[comps objectAtIndex:1] componentsSeparatedByString:@"="];
    NSString *boundary = [bounds objectAtIndex:1];
    
    char byte = 'a';
    
    // Starts after boundary
    int pos = [boundary length] + 4;
    
    BOOL readingHeaders = YES;
    NSMutableArray *headers = [NSMutableArray array];
    
    while (readingHeaders) {
        
        char *header = malloc(1024);
        
        int i = 0;
        
        byte = *(char *)([request.body bytes] + pos);
        while (byte != '\r') {
            header[i] = byte;
            pos++;
            i++;
            
            byte = *(char *)([request.body bytes] + pos);
        }
        
        header[i] = '\0';
        
        // Skips the carriage return and line feed
        pos += 2;
        
        if (strcmp(header, "") == 0) {
            readingHeaders = NO;
        } else {
            [headers addObject:[NSString stringWithFormat:@"%s", header]];
        }
        
        free(header);
    }
    
    // Reads the actual data
    
    NSData *fileData = [request.body subdataWithRange:NSMakeRange(pos, [request.body length] - pos - [boundary length] - 8)];
    
    NSString *fileName = @"file.upload";
    
    // Search the headers for the file name
    
    for (NSString *header in headers) {
        if ([header length] >= 19 && [[header substringToIndex:19] isEqualToString:@"Content-Disposition"]) {
            
            NSArray *hComps = [header componentsSeparatedByString:@";"];
            
            for (NSString *hComp in hComps) {
                NSArray *hParams = [hComp componentsSeparatedByString:@"="];
                
                if ([hParams count] > 0) {
                    NSString *trimmed = [[hParams objectAtIndex:0] stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
                    if ([trimmed isEqualToString:@"filename"]) {
                        fileName = [hParams objectAtIndex:1];
                    }
                }
            }
            
        }
    }
    
    // Saves the file to the documents folder
    
    fileName = [fileName stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"\"'"]];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *file = [documentsDirectory stringByAppendingPathComponent:fileName];
    
    [fileData writeToFile:file atomically:YES];
    
    ServletResponse *resp = [[[ServletResponse alloc] init] autorelease];
    resp.statusCode = @"200 OK";
    resp.bodyString = [NSString stringWithFormat:@"%@ upload successfully.", fileName];
    [resp addHeader:@"Content-Type" withValue:@"text/plain"];
    
    return resp;
}

- (void)logPath:(NSString *)path {
    [delegate didLogAccessInServlet:@"UploadServlet" forPath:path];
}

@end
