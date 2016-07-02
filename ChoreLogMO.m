//
//  ChoreLogMO.m
//  CoreDataCoursera
//
//  Created by Miguel Melendez on 6/27/16.
//  Copyright © 2016 Miguel Melendez. All rights reserved.
//

#import "ChoreLogMO.h"
#import "ChoreMO.h"
#import "PersonMO.h"

@implementation ChoreLogMO

- (NSString *) description {
    return [NSString stringWithFormat:@"(%@) (%@) (%@)", self.person_who_did_it.person_name, self.chore_done.chore_name, self.when];
}

@end
