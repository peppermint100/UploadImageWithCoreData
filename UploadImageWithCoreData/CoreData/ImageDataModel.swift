import Foundation
import CoreData
import UIKit


@objc(ImageDataModel)
class ImageDataModel: NSManagedObject {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<ImageDataModel> {
        return NSFetchRequest<ImageDataModel>(entityName: "ImageDataModel")
    }

    @NSManaged public var id: UUID
    @NSManaged public var image: UIImage?
    @NSManaged public var createdAt: Date?
}

extension ImageDataModel : Identifiable {

}
