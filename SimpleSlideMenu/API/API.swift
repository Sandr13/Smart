//
//  API.swift
//  SimpleSlideMenu
//
//  Created by user162126 on 12/13/19.
//  Copyright © 2019 Test. All rights reserved.
//

import Foundation

typealias JSON = [String : Any]

enum API {
    
    static var identifier: String { "teseptsc" }
    static var baseURL: String { "https://smartplusplus.firebaseio.com/data/\(identifier)" }
    
    static func loadNotes(completion: @escaping ([Note]) -> Void) {
        let url = URL(string: baseURL + ".json")!
        let request = URLRequest(url: url)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard
                let data = data,
                let json = try? JSONSerialization.jsonObject(with: data, options: []) as? JSON
            else {
                DispatchQueue.main.async {
                    completion(Note.allObject())
                }
                return
            }
            
            DispatchQueue.main.async {
                let notesJSON = json["notes"] as! JSON
                var notes = [Note]()
                
                for note in notesJSON {
                    notes.append(Note(id: note.key, data: note.value as! JSON))
                }
                
                notes.sort { $0.date < $1.date }
            
                completion(notes)
            }
        }
        task.resume()
    }
    
    static func createNote(title: String, text: String, completion: @escaping (Bool) -> Void) {
        let params = [
            "title": title,
            "text": text,
            "date": Date().string
        ]
        
        let url = URL(string: baseURL + "/notes.json")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(error == nil)
        }
        task.resume()
    }
    
    static func editeNote(note: Note, completion: @escaping (Bool) -> Void) {
        let params = [
            "title": note.title,
            "text": note.text,
            "date": Date().string
        ]
        
        let url = URL(string: baseURL + "/notes/\(note.id)/.json")!
        var request = URLRequest(url: url)
        
        request.httpMethod = "PATCH"
        request.httpBody = try? JSONSerialization.data(withJSONObject: params)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            completion(error == nil)
        }
        task.resume()
    }
    
}
