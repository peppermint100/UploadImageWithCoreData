import Foundation
import CoreData
import UIKit


@objc(MyImage)
class MyImage: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<MyImage> {
        return NSFetchRequest<MyImage>(entityName: "Image")
    }

    @NSManaged public var id: Int16
    @NSManaged public var image: UIImage?

}

extension MyImage : Identifiable {

}
