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
    var planNames: [String]
    var tagName: String
    var documentID: String?
    
    init(authID: Int, planNames: [String], tagName: String){
        self.authID = authID
        self.planNames = planNames
        self.tagName = tagName
    }
    
    init(documentSnapshot: DocumentSnapshot){
        self.documentID = documentSnapshot.documentID
        let data = documentSnapshot.data()
        self.authID = data?[kTagAuthID] as? Int ?? 0
        self.tagName = data?[kTagName] as? String ?? ""
        self.planNames = data?[kTagPlans] as? [String] ?? [String]()
    }
    
}
