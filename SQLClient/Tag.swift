//
//  Tag.swift
//  SQLClient
//
//  Created by Helen Wang on 5/16/22.
//  Copyright © 2022 vinayaka s yattinahalli. All rights reserved.
//

import Foundation
import FirebaseFirestore


class Tag{
    
    var authID: Int
    var planName: [String: Int]
    var tagName: String
    var documentID: String?
    
    init(authID: Int, planName: [String: Int], tagName: String){
        self.authID = authID
        self.planName = planName
        self.tagName = tagName
    }
    
    init(documentSnapshot: DocumentSnapshot){
        self.documentID = documentSnapshot.documentID
        let data = documentSnapshot.data()
        self.authID = data?[kTagAuthID] as? Int ?? -1
        self.tagName = data?[kTagName] as? String ?? ""
        self.planName = data?[kTagPlan] as? [String:Int] ?? [:]
    }
    
}
