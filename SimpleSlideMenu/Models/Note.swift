import Foundation
import RealmSwift

class Note: Object {
    
    @objc dynamic var title: String = ""
    @objc dynamic var status: Bool
    
    @discardableResult
    convenience init(id: String, data: JSON) {
        
        self.init()
        
        self.title  = data["title"] as! String
        self.status   = (data["status"] as! String)
        
        saveNote()
    }
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    func saveNote() {
        let realm = try! Realm()
        try! realm.write() {
            realm.add(self, update: .modified)
        }
    }
    
    static func allObject() -> [Note] {
        let realm = try! Realm()
        return realm.objects(Note.self).map { $0 }
    }
    
}

extension Note {
    
    override var debugDescription: String {
        "\(title): \(text)"
    }
    
}
