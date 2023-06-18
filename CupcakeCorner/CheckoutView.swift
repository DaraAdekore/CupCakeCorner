//
//  CheckoutView.swift
//  CupcakeCorner
//
//  Created by Dara Adekore on 2023-06-16.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order

    @State private var confimationMessage = ""
    @State private var showingConfirmation = false
    @State private var showingError = false
    @State private var errorMessage = ""
    var body: some View {
        ScrollView {
            VStack {
                AsyncImage(url: URL(string: "https://hws.dev/img/cupcakes@3x.jpg"), scale: 3) { image in
                    image
                        .resizable()
                        .scaledToFit()

                } placeholder: {
                    ProgressView()
                }
                .frame(height: 233)

                Text("Your total is \(order.order.cost, format: .currency(code: "USD"))")
                Button("Place order.order") {
                    Task {
                        await placeOrder()
                    }
                }
                .padding()
            }
        }
        .navigationTitle("Check out")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Thank you!", isPresented: $showingConfirmation) {
            Button("OK") {}
        } message: {
            Text(confimationMessage)
        }
        .alert("Could not place order", isPresented: $showingError) {
            Button("OK") {}
        } message: {
            Text("Error : \(errorMessage)")
        }
    }

    func placeOrder() async {
        guard let encoded = try? JSONEncoder().encode(order.order) else {
            print("Failed to encode order")
            return
        }

        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"

        do {
            let (data, _)  = try await URLSession.shared.upload(for: request, from: encoded)
            // handle the result
            let decodedOrder = try JSONDecoder().decode(OrderDetails.self, from: data)
            confimationMessage = "Your order of  \(decodedOrder.quantity) \(OrderDetails.types[decodedOrder.type].lowercased()) cupcakes are on their way!"
            showingConfirmation = true
        } catch {
            errorMessage = "Something went wrong!"
            showingError = true
            print("Checkout failed.")
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
