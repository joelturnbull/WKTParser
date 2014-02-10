//
//  WKTParser.h
//  WKTParser
//
//  Created by Joel Turnbull on 2/12/13.
//  Copyright (c) 2013 Joel Turnbull. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

@interface WKTParser : NSObject

// WKT POLYGON/MULTIPOLYGON Parsing
+(NSArray *)polygonsForWkt:(NSString *)wkt;

// WKT POINT Parsing
+(CLLocationCoordinate2D)locationForWktPoint:(NSString *)location;

@end
