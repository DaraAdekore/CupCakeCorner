//
//  Order.swift
//  CupcakeCorner
//
//  Created by Dara Adekore on 2023-06-12.
//

import SwiftUI

class Order: ObservableObject {
    enum CodingKeys: CodingKey {
        case order
    }
    @Published var order = OrderDetails()

    // We've overloaded the constructor so we need this for when the order is not filled in
    init() {

    }
    func encode(to encoder: Encoder) throws {
        var container  = encoder.container(keyedBy: CodingKeys.self)

        try container.encode(order, forKey: .order)
    }

    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        order = try container.decode(OrderDetails.self, forKey: .order)
    }
}
