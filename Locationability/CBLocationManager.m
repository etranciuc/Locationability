//
//  CBLocationManager.m
//  Locationability
//
//  Created by Liam Beeton on 2012/07/17.
//  Copyright (c) 2012 Codebase. All rights reserved.
//

#import "CBLocationManager.h"

@interface CBLocationManager (Private)

- (BOOL)isValidLocation:(CLLocation *)newLocation withOldLocation:(CLLocation *)oldLocation;

@end

@implementation CBLocationManager

@synthesize delegate;

#pragma mark - Shared instance (Singleton)

+ (CBLocationManager *)instance {
    static CBLocationManager *_default = nil;
    
    if (_default != nil) {
        return _default;
    }
    
    static dispatch_once_t safer;
    dispatch_once(&safer, ^(void) {
        _default = [[CBLocationManager alloc] init];
    });
    
    return _default;
}

#pragma mark - Initialization

- (id)init {
    self = [super init];
    
    if (self) {
        if ([CLLocationManager locationServicesEnabled]) {
            _locationManager = [[CLLocationManager alloc] init];
            _locationManager.delegate = self;
            _locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters;
            _locationManager.distanceFilter = 100;
            
            [self start];
            
            _locationStartDate = [[NSDate date] retain];
        }
    }
    
    return self;
}

#pragma mark - Memory management

- (void)dealloc {
    _locationManager.delegate = nil;
    [_locationManager release];
    
    [super dealloc];
}

#pragma mark - Location manager controls

- (void)start {
    [_locationManager startUpdatingLocation];
}

- (void)stop {
    [_locationManager stopUpdatingLocation];
}

#pragma mark - Private functions

- (BOOL)isValidLocation:(CLLocation *)newLocation withOldLocation:(CLLocation *)oldLocation {
    if (!newLocation) {
        return NO;
    }
    
    if (newLocation.horizontalAccuracy < 0) {
        return NO;
    }
    
    NSTimeInterval secondsSinceLastPoint = [newLocation.timestamp timeIntervalSinceDate:oldLocation.timestamp];
    if (secondsSinceLastPoint < 0) {
        return NO;
    }
    
    NSTimeInterval secondsSinceManagerStarted = [newLocation.timestamp timeIntervalSinceDate:_locationStartDate];
    if (secondsSinceManagerStarted < 0) {
        return NO;
    }
    
    return YES;
}

#pragma mark - Location manager delegate implementation

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation {
    NSInteger locationAge = abs([newLocation.timestamp timeIntervalSinceDate:[NSDate date]]);
    
    if (locationAge > 120 || ![self isValidLocation:newLocation withOldLocation:oldLocation]) {     
        return;
    }
    
    if ([delegate respondsToSelector:@selector(didUpdateLocation:)]) {
        [delegate didUpdateLocation:newLocation];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error {
    if ([delegate respondsToSelector:@selector(didFailWithError:)]) {
        [delegate didFailWithError:error];
    }
}

@end
