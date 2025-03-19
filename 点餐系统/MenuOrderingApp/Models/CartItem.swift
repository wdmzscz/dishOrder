import Foundation

struct CartItem: Identifiable {
    let id = UUID()
    let menuItem: MenuItem
    var quantity: Int
    var notes: String
    
    var subtotal: Double {
        return menuItem.price * Double(quantity)
    }
} 