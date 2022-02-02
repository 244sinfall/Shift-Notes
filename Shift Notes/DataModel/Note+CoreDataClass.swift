//
//  Note+CoreDataClass.swift
//  Shift Notes
//
//  Created by Дмитрий Филин on 31.01.2022.
//
//

import Foundation
import CoreData

@objc(Note)
public class Note: NSManagedObject {
}

@objc(NSAttributedStringTransformer)
class NSAttributedStringTransformer: NSSecureUnarchiveFromDataTransformer {
    override class var allowedTopLevelClasses: [AnyClass] {
        return super.allowedTopLevelClasses + [NSAttributedString.self]
    }
}
