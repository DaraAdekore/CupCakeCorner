//
//  OrderDetails.swift
//  CupcakeCorner
//
//  Created by Dara Adekore on 2023-06-18.
//

import Foundation
struct OrderDetails: Codable {
    static let types = ["Vanilla", "Strawberry", "Chocolate", "Rainbow"]
     var type = 0
     var quantity = 3

     var specialRequestEnabled = false {
        didSet {
            if specialRequestEnabled == false {
                extraFrosting = false
                addSprinkles = false
            }
        }
    }
     var extraFrosting = false
     var addSprinkles = false

     var name = ""
     var streetAddress = ""
     var city = ""
     var zip = ""
    var hasValidAddress: Bool {
        if name.isEmpty || name.rangeOfCharacter(from: CharacterSet.alphanumerics) == nil || streetAddress.isEmpty || streetAddress.rangeOfCharacter(from: CharacterSet.alphanumerics) == nil || city.isEmpty || city.rangeOfCharacter(from: CharacterSet.alphanumerics) == nil || zip.isEmpty || zip.rangeOfCharacter(from: CharacterSet.alphanumerics) == nil {
            return false
        }
        return true
    }

    var cost: Double {
        // $2 per cake
        var cost = Double(quantity) * 2

        // complicated cakes cost more
        cost += (Double(type) / 2)

        // $1/cake for extra frosting
        if extraFrosting {
            cost += Double(quantity)
        }

        // $0.50/cake for sprinkles
        if addSprinkles {
            cost += Double(quantity) / 2
        }

        return cost
    }
}
