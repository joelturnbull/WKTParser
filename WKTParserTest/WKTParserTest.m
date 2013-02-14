//
//  WKTParserTest.m
//  WKTParserTest
//
//  Created by Joel Turnbull on 2/14/13.
//  Copyright (c) 2013 Joel Turnbull. All rights reserved.
//

#import "WKTParserTest.h"
#import <Kiwi/Kiwi.h>
#import <MapKit/MapKit.h>
#import "WKTParser.h"

SPEC_BEGIN(WKTParserSpec)

describe(@"+parseCoordinates", ^{
    it(@"parses a polygon", ^{
        NSString* wkt = @"POLYGON((-86.0720443605771 41.742595260603,-86.0720443605771 41.7462135318731,-86.0725593447079 41.746501704004,-86.0726451753969 41.7466938180394,-86.0726022600524 41.7468859314999,-86.0721301912662 41.7470780443855,-86.0721301912662 41.7497355469899,-86.0765504717219 41.7497675644231,-86.0765075563774 41.742691323537,-86.0720443605771 41.742595260603))";

        NSArray *polygons = [WKTParser polygonsForWkt: wkt];
        [[theValue([polygons count]) should ] equal: theValue(1)];
        MKPolygon *polygon = [polygons objectAtIndex:0];
        [[theValue([polygon pointCount]) should] equal: theValue(9)];
    });
    it(@"parses an exterior polygon", ^{
        NSString* wkt = @"POLYGON ((35 10, 10 20, 15 40, 45 45, 35 10),(20 30, 35 35, 30 20, 20 30))";
        NSArray *polygons = [WKTParser polygonsForWkt: wkt];
        [[theValue([polygons count]) should ] equal: theValue(1)];
        MKPolygon *polygon = [polygons objectAtIndex:0];
        [[theValue([polygon pointCount]) should] equal: theValue(4)];
    });
    it(@"parses multiple polygons", ^{
        NSString* wkt = @"MULTIPOLYGON (((30 20, 10 40, 45 40, 30 20)),((15 5, 40 10, 10 20, 5 10, 15 5)))";
        NSArray *polygons = [WKTParser polygonsForWkt: wkt];
        [[theValue([polygons count]) should ] equal: theValue(2)];
        MKPolygon *firstPolygon = [polygons objectAtIndex:0];
        [[theValue([firstPolygon pointCount]) should] equal: theValue(3)];
        MKPolygon *secondPolygon = [polygons objectAtIndex:1];
        [[theValue([secondPolygon pointCount]) should] equal: theValue(4)];
    });
    it(@"parses multiple exterior polygons", ^{
        NSString* wkt = @"MULTIPOLYGON (((40 40, 20 45, 45 30, 40 40)),((20 35, 45 20, 30 5, 10 10, 10 30, 20 35),(30 20, 20 25, 20 15, 30 20)))";
        NSArray *polygons = [WKTParser polygonsForWkt: wkt];
        [[theValue([polygons count]) should ] equal: theValue(2)];
        MKPolygon *firstPolygon = [polygons objectAtIndex:0];
        [[theValue([firstPolygon pointCount]) should] equal: theValue(3)];
        MKPolygon *secondPolygon = [polygons objectAtIndex:1];
        [[theValue([secondPolygon pointCount]) should] equal: theValue(5)];
    });

});

SPEC_END