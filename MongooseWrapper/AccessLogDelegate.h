//
//  AccessLogDelegate.h
//  MongooseWrapper
//
//  Created by Fabio Rodella on 6/10/11.
//  Copyright 2011 Crocodella Software. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Simple delegate to allow servlets to provide feedback to 
 * the RootViewController
 */
@protocol AccessLogDelegate <NSObject>

- (void)didLogAccessInServlet:(NSString *)name forPath:(NSString *)path;

@end
