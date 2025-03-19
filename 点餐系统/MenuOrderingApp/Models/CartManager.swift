import Foundation
import SwiftUI

class CartManager: ObservableObject {
    @Published var items: [CartItem] = []
    @Published var tableNumber: Int = 1
    
    // Ontario tax rates
    private let hstRate = 0.13 // 13% HST in Ontario
    
    // Total before tax
    var subtotal: Double {
        items.map { $0.subtotal }.reduce(0, +)
    }
    
    // Tax amount
    var taxAmount: Double {
        subtotal * hstRate
    }
    
    // Total including tax
    var total: Double {
        subtotal + taxAmount
    }
    
    // Add item to cart
    func addItem(menuItem: MenuItem, quantity: Int = 1, notes: String = "") {
        // Check if item already exists in cart
        if let index = items.firstIndex(where: { $0.menuItem.id == menuItem.id }) {
            // If notes are different, add as a new item
            if items[index].notes != notes {
                items.append(CartItem(menuItem: menuItem, quantity: quantity, notes: notes))
            } else {
                // Otherwise update quantity
                items[index].quantity += quantity
            }
        } else {
            // Add new item to cart
            items.append(CartItem(menuItem: menuItem, quantity: quantity, notes: notes))
        }
    }
    
    // Update item quantity
    func updateItemQuantity(item: CartItem, quantity: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].quantity = max(1, quantity) // Ensure quantity is at least 1
        }
    }
    
    // Update item notes
    func updateItemNotes(item: CartItem, notes: String) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].notes = notes
        }
    }
    
    // Remove item from cart
    func removeItem(item: CartItem) {
        items.removeAll { $0.id == item.id }
    }
    
    // Clear cart
    func clearCart() {
        items.removeAll()
    }
} 