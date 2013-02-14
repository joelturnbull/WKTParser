//
//  WKTParser.m
//  WKTParser
//
//  Created by Joel Turnbull on 2/12/13.
//  Copyright (c) 2013 Joel Turnbull. All rights reserved.
//

#import "WKTParser.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@implementation WKTParser

+(NSArray*)polygonsForWkt:(NSString*)wkt {
    NSMutableArray *polygons = [NSMutableArray array];
    
    if ([wkt rangeOfString: @"MULTIPOLYGON"].location == NSNotFound)
    {
        NSMutableArray *coordinates = [self coordinatesForWkt: wkt];
        MKPolygon *polygon = [self polygonForCoordinates: coordinates];
        [polygons addObject: polygon];
    }
    else
    {
        NSArray *wkts = [self splitMultiPolygonsFromWkt: wkt];
        for(NSString *wkt in wkts)
        {
            NSMutableArray *coordinates = [self coordinatesForWkt: wkt];
            MKPolygon *polygon = [self polygonForCoordinates: coordinates];
            [polygons addObject: polygon];
        }
    }
    
    return [NSArray arrayWithArray: polygons];
}

+(NSArray*)splitMultiPolygonsFromWkt:(NSString*)wkt {
    return [wkt componentsSeparatedByString: @")),(("];
}

+(MKPolygon*)polygonForWkt:(NSString*)wkt {
    NSMutableArray *coordinates = [self coordinatesForWkt: wkt];
    return [self polygonForCoordinates: coordinates];
}

+(NSMutableArray*)coordinatesForWkt:(NSString*)wkt {
    
    NSMutableArray *coordinates = [NSMutableArray array];
    
    NSError *error = NULL;
    
    NSArray *polygonStrings = [wkt componentsSeparatedByString: @"),("];
    
    NSString *exteriorRingString = [polygonStrings objectAtIndex: 0];
    
    NSString *coordinatesRegexString = @"([-\\d\\.]+\\s[-\\d\\.]+)";
    NSRegularExpression *coordinatesRegex = [NSRegularExpression regularExpressionWithPattern: coordinatesRegexString
                                                                                      options: NSRegularExpressionCaseInsensitive
                                                                                        error: &error];
    NSArray *coordinatesStrings = [coordinatesRegex matchesInString: exteriorRingString
                                                            options: 0
                                                              range: NSMakeRange(0, [exteriorRingString length])];
    
    for (NSTextCheckingResult *match in coordinatesStrings) {
        NSRange matchRange = [match rangeAtIndex:1];
        [coordinates addObject:[self parseCoordinateFromString: [wkt substringWithRange:matchRange]]];
    }
    
    return coordinates;
}

+(MKPolygon*)polygonForCoordinates:(NSArray*) coordinates {
    
	NSInteger coordsLen = [coordinates count] - 1;
    
	if (coordsLen < 1) {
		return nil;
    }
	
	CLLocationCoordinate2D *coords = malloc(sizeof(CLLocationCoordinate2D) * [coordinates count]);
	for (int i=0; i < coordsLen; i++) {
		CLLocation *coordObj = [coordinates objectAtIndex:i];
		coords[i] = CLLocationCoordinate2DMake(coordObj.coordinate.latitude, coordObj.coordinate.longitude);
	}
    
    MKPolygon *newPolygon = [MKPolygon polygonWithCoordinates:coords count:coordsLen];
	free(coords);
    
	return newPolygon;
}

+(CLLocation*)parseCoordinateFromString:(NSString*)coordinateString {
    NSArray *points = [coordinateString componentsSeparatedByString:@" "];
    NSString *lon = [points objectAtIndex:0];
    NSString *lat = [points objectAtIndex:1];
    return [[CLLocation alloc] initWithLatitude:[lat floatValue]
                                      longitude:[lon floatValue]];
    
}

@end
