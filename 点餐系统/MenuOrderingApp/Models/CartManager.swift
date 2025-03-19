import Foundation
import SwiftUI

// 定义餐桌号码结构
struct TableNumber: Equatable, Hashable {
    var area: String  // 区域: A, B, C
    var number: Int   // 号码: 1-5
    
    // 格式化为显示用的字符串
    var formatted: String {
        return "\(area)\(number)"
    }
    
    // 默认餐桌
    static let defaultTable = TableNumber(area: "A", number: 1)
}

class CartManager: ObservableObject {
    @Published var items: [CartItem] = []
    @Published var tableNumber: TableNumber = TableNumber.defaultTable
    
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
    func addItem(menuItem: MenuItem, quantity: Int = 1, notes: String = "", extraCharge: Double = 0.0, substitution: String = "") {
        // Check if item already exists in cart
        if let index = items.firstIndex(where: { $0.menuItem.id == menuItem.id && $0.notes == notes && $0.extraCharge == extraCharge && $0.substitution == substitution }) {
            // If all properties match, update quantity
            items[index].quantity += quantity
        } else {
            // Add new item to cart
            items.append(CartItem(
                menuItem: menuItem, 
                quantity: quantity, 
                notes: notes,
                extraCharge: extraCharge,
                substitution: substitution
            ))
        }
    }
    
    // Update item quantity - 强制更新数量，不使用max函数
    func updateItemQuantity(item: CartItem, quantity: Int) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            // 直接设置数量，不限制最小值
            items[index].quantity = quantity
            
            // 如果修改后数量为0或负数，删除该项
            if items[index].quantity <= 0 {
                removeItem(item: items[index])
            }
            
            // 强制发送变更通知
            objectWillChange.send()
        }
    }
    
    // Update item notes
    func updateItemNotes(item: CartItem, notes: String) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].notes = notes
        }
    }
    
    // Update item extra charge
    func updateItemExtraCharge(item: CartItem, extraCharge: Double, substitution: String) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items[index].extraCharge = extraCharge
            items[index].substitution = substitution
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
    
    // Add custom dish
    func addCustomDish(name: String, price: Double, quantity: Int = 1, notes: String = "") {
        // Create a custom menu item
        let customItem = MenuItem(
            id: UUID().uuidString,
            code: "CUSTOM",
            name: name,
            price: .fixed(price),
            category: .custom,
            subcategory: nil,
            description: "自定义菜品",
            items: nil,
            isSpicy: false
        )
        
        // Add to cart
        addItem(menuItem: customItem, quantity: quantity, notes: notes)
    }
    
    // Calculate total extra charge
    func calculateTotalExtraCharge() -> Double {
        return items.map { $0.extraCharge * Double($0.quantity) }.reduce(0, +)
    }
} 