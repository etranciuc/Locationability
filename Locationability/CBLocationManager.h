//
//  CBLocationManager.h
//  Locationability
//
//  Created by Liam Beeton on 2012/07/17.
//  Copyright (c) 2012 Codebase. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@protocol CBLocationManagerDelegate <NSObject>

@required
- (void)didUpdateLocation:(CLLocation *)currentLocation;
- (void)didFailWithError:(NSError *)error;

@end

@interface CBLocationManager : NSObject<CLLocationManagerDelegate> {

@private
    CLLocationManager *_locationManager;
    NSDate *_locationStartDate;

}

@property (nonatomic, assign) id<CBLocationManagerDelegate> delegate; 

+ (CBLocationManager *)instance;
- (void)start;
- (void)stop;

@end
