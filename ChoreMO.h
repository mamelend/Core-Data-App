//
//  ChoreMO.h
//  CoreDataCoursera
//
//  Created by Miguel Melendez on 6/27/16.
//  Copyright © 2016 Miguel Melendez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class ChoreLogMO;

NS_ASSUME_NONNULL_BEGIN

@interface ChoreMO : NSManagedObject

- (NSString *) description;

@end

NS_ASSUME_NONNULL_END

#import "ChoreMO+CoreDataProperties.h"
