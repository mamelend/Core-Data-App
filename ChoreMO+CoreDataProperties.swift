//
//  ChoreMO+CoreDataProperties.swift
//  CoreDataCoursera
//
//  Created by Miguel Melendez on 6/27/16.
//  Copyright © 2016 Miguel Melendez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension ChoreMO {

    @NSManaged var chore_name: String?
    @NSManaged var chore_log: NSSet?

}
