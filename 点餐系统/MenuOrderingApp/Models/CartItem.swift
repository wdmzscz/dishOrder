import Foundation

struct CartItem: Identifiable, Equatable {
    let id = UUID()
    let menuItem: MenuItem
    var quantity: Int
    var notes: String
    var extraCharge: Double = 0.0
    var substitution: String = ""
    
    var subtotal: Double {
        return (menuItem.primaryPrice + extraCharge) * Double(quantity)
    }
    
    // 实现Equatable协议的静态方法
    static func == (lhs: CartItem, rhs: CartItem) -> Bool {
        return lhs.id == rhs.id
    }
} 