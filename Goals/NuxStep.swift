//
//  NuxStep.swift
//  Goals
//
//  Created by Nathaniel Hajian on 3/16/16.
//  Copyright © 2016 Alex Miles. All rights reserved.
//

import Foundation

import UIKit

import UIKit

public class NuxStep: NSObject {
    
    // MARK: Properties
    var titleText: String
    var model : DataModel
    var type : ToDoType
    
    
    init?(text: String, model: DataModel){
        self.titleText = text
        self.model = model
        self.type = model.type
        
        super.init()
    }
    
  }

