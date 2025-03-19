import Foundation

struct CartItem: Identifiable, Equatable {
    let id = UUID()
    let menuItem: MenuItem
    var quantity: Int
    var notes: String
    
    var subtotal: Double {
        return menuItem.price * Double(quantity)
    }
    
    // 实现Equatable协议的静态方法
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.id == rhs.id
    }
} 