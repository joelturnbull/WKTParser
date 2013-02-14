//
//  WKTParser.h
//  WKTParser
//
//  Created by Joel Turnbull on 2/12/13.
//  Copyright (c) 2013 Joel Turnbull. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WKTParser : NSObject

+(NSArray*)polygonsForWkt:(NSString*)wkt;

@end
