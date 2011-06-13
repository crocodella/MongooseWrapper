//
//  RootViewController.h
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MongooseServer.h"
#import "AccessLogDelegate.h"

@interface AccessLog : NSObject {
    NSString *name;
    NSString *path;
    NSDate *date;
}

@property (readwrite,retain) NSString *name;
@property (readwrite,retain) NSString *path;
@property (readwrite,retain) NSDate *date;

- (id)initWithName:(NSString *)n path:(NSString *)p;

@end

@interface RootViewController : UITableViewController <AccessLogDelegate> {
    MongooseServer *server;
    NSMutableArray *log;
}

@end
