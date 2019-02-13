//
//  Person+CoreDataProperties.swift
//  CoreDataDemo
//
//  Created by Pablo Ramirez on 22/12/17.
//  Copyright © 2017 Pablo Ramirez. All rights reserved.
//
//

import Foundation
import CoreData


extension Person {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Person> {
        return NSFetchRequest<Person>(entityName: "Person")
    }

    @NSManaged public var name: String?
    @NSManaged public var age: Int16

}
