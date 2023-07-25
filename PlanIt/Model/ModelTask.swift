//
//  Model.swift
//  PlanIt
//
//  Created by Bogdan Monid on 4.06.23.
//


import Foundation

struct ModelTask: Codable, Equatable{
    
    var id: Double
    var titleTask: String
    var descriptionTask: String
}
