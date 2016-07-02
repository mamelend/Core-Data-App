//
//  AppDelegate.h
//  CoreDataCoursera
//
//  Created by Miguel Melendez on 6/27/16.
//  Copyright © 2016 Miguel Melendez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "ChoreMO.h"
#import "PersonMO.h"
#import "ChoreLogMO.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (ChoreMO *) createChoreMO;
- (PersonMO *) createPersonMO;
- (ChoreLogMO *) createChoreLogMO;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;


@end