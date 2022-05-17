//
//  TagManager.swift
//  SQLClient
//
//  Created by Helen Wang on 5/16/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import Foundation
import FirebaseFirestore

class TagManager{
    
    static let shared = TagManager()
    var _collectionRef: CollectionReference
    
    
    private init(){
        _collectionRef = Firestore.firestore().collection(kTagCollectionPath)
    }
    
    var latestTags = [Tag]()
    
    func startListening(filterByAuthor authorFilter: Int, changeListener: @escaping (() -> Void)) -> ListenerRegistration{// recieves a function that takes no parameter and return void
        
        var query = _collectionRef.limit(to: 50)
       print("filter by authID: \(authorFilter)")
        query = query.whereField(kTagAuthID, isEqualTo: AuthManager.shared.currentUser?.uid)
        
        return query.addSnapshotListener { querySnapshot, error in
            guard let documents = querySnapshot?.documents else {// if exist then carry on, else stop and print
                print("Error fetching documents: \(error!)")
                return
            }
            self.latestTags.removeAll()
            for document in documents {
                print("\(document.documentID) => \(document.data())")
                self.latestTags.append(Tag(documentSnapshot: document))
            }
            changeListener()
        }
        
    }
    
    func stopListening(_ listenerRegistration: ListenerRegistration?){
        listenerRegistration?.remove();
        
    }
    
    func add(_ t: Tag){
        _collectionRef.addDocument(data: [
            kTagName: t.tagName,
            kTagAuthID: t.authID,
            kTagPlan: t.planName,
        ]){err in
            if let err = err {
                print("Error adding document \(err)")
            }
        }
    }
    
    func delete(_ documentId: String){
        _collectionRef.document(documentId).delete() { err in
            if let err = err {
                print("Error removing document: \(err)")
            } else {
                print("Document successfully removed!")
            }
        }
        
    }
    
}
