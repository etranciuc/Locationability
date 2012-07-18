//
//  LocationViewController.h
//  Locationability
//
//  Created by Liam Beeton on 2012/07/17.
//  Copyright (c) 2012 Codebase. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CBLocationManager.h"

@interface LocationViewController : UIViewController<CBLocationManagerDelegate, UITableViewDelegate, UITableViewDataSource> {

@private
    CBLocationManager *_locationManager;
    UITableView *_tableView;
    NSMutableArray *_coordinates;
    
}

@end
