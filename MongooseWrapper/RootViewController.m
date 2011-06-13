//
//  RootViewController.m
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import "RootViewController.h"
#import "HelloWorldServlet.h"
#import "ImageServlet.h"
#import "UploadServlet.h"

@implementation AccessLog

@synthesize name;
@synthesize path;
@synthesize date;

- (id)initWithName:(NSString *)n path:(NSString *)p {
    if ((self = [super init])) {
        name = [n retain];
        path = [p retain];
        date = [[NSDate date] retain];
    }
    return self;
}

- (void)dealloc {
    [name release];
    [path release];
    [date release];
    [super dealloc];
}

@end

@implementation RootViewController

- (void)didLogAccessInServlet:(NSString *)name forPath:(NSString *)path {
    
    [self.tableView beginUpdates];
    
    NSIndexPath *idx = [NSIndexPath indexPathForRow:[log count] inSection:0];
    [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:idx] withRowAnimation:UITableViewRowAnimationRight];
    
    AccessLog *logItem = [[AccessLog alloc] initWithName:name path:path];
    [log addObject:logItem];
    [logItem release];
    
    [self.tableView endUpdates];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"Mongoose Server";
    
    log = [[NSMutableArray alloc] init];
    
    /*
     This is equivalent to the following:
     
     const char *options[] = {
     "document_root", [NSHomeDirectory() UTF8String],
     "listening_ports", "8080",
     "enable_directory_listing", "yes",
     NULL
     };
     
     server = [[MongooseServer alloc] initWithOptions:options];
     
     Check the mongoose documentation for all the options available.
    */

    server = [[MongooseServer alloc] initWithPort:8080 allowDirectoryListing:YES];
    
    HelloWorldServlet *servlet = [[HelloWorldServlet alloc] init];
    servlet.delegate = self;
    [server addServlet:servlet forPath:@"/helloWorld"];
    
    /*
     You can also use wildcards in the servlet path. In this case, 
     the server will check first for any exact matches,
     and then will search for the wildcard servlets
     */
    [server addServlet:servlet forPath:@"/helloWildcard/*"];
    
    [servlet release];
    
    ImageServlet *imServlet = [[ImageServlet alloc] init];
    imServlet.delegate = self;
    [server addServlet:imServlet forPath:@"/image"];
    [imServlet release];
    
    /*
     This servlet can receive file uploads from forms such as:
     
     <html>
     <body>
     <form action="http://<host>/upload" method="POST" enctype="multipart/form-data">
     <input type="file" name="file"/>
     <input type="submit" value="submit"/>
     </form>
     </body>
     </html>
    
    */
    UploadServlet *upServlet = [[UploadServlet alloc] init];
    upServlet.delegate = self;
    [server addServlet:upServlet forPath:@"/upload"];
    [upServlet release];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    
    [server release];
    [log release];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [log count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    AccessLog *logItem = [log objectAtIndex:indexPath.row];
    
    cell.textLabel.text = logItem.name;
    cell.detailTextLabel.text = logItem.path;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;

    return cell;
}

- (void)dealloc
{
    [super dealloc];
}

@end
