import Foundation
import SwiftUI

// 定义餐桌号码结构
struct TableNumber: Equatable, Hashable {
    var area: String  // 区域: A, B, C
    var number: Int   // 号码: 1-5
    var customName: String = "" // 自定义桌号名称
    
    // 格式化为显示用的字符串
    var formatted: String {
        if !customName.isEmpty {
            return customName
        }
        return "\(area)\(number)"
    }
    
    // 默认餐桌
    static let defaultTable = TableNumber(area: "A", number: 1)
}

class CartManager: ObservableObject {
    @Published var items: [CartItem] = []
    @Published var tableNumber: TableNumber = TableNumber.defaultTable
    @Published var customDishes: [MenuItem] = []
    
    // 添加单例，用于在环境对象缺失时提供备用实例
    static let shared = CartManager()
    
    // Ontario tax rates
    private let hstRate = 0.13 // 13% HST in Ontario
    
    // 初始化方法，从UserDefaults加载自定义菜品
    init() {
        loadCustomDishes()
    }
    
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
        // 标准化替换信息，确保替换和价格信息正确关联
        let cleanSubstitution = substitution.isEmpty && extraCharge != 0 ? 
                             (extraCharge > 0 ? "补差价" : "减价") : 
                             substitution
        
        // 不再修改 MenuItem 的价格，保持原价
        // 差价通过 CartItem 的 extraCharge 字段单独记录
        
        // Check if item already exists in cart
        if let index = items.firstIndex(where: { $0.menuItem.id == menuItem.id && $0.notes == notes && $0.extraCharge == extraCharge && $0.substitution == cleanSubstitution }) {
            // If all properties match, update quantity
            items[index].quantity += quantity
        } else {
            // Add new item to cart
            items.append(CartItem(
                menuItem: menuItem, 
                quantity: quantity, 
                notes: notes,
                extraCharge: extraCharge,
                substitution: cleanSubstitution
            ))
        }
        
        // 强制触发UI更新
        objectWillChange.send()
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
    
    // Add custom dish and save it
    func addCustomDish(name: String, price: Double, quantity: Int = 1, notes: String = "", saveToCustom: Bool = true) {
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
        
        // 如果需要保存到自定义菜品列表
        if saveToCustom {
            // 检查是否已存在相同名称的自定义菜品
            if !customDishes.contains(where: { $0.name == name }) {
                customDishes.append(customItem)
                saveCustomDishes()
            }
        }
        
        // Add to cart
        addItem(menuItem: customItem, quantity: quantity, notes: notes)
    }
    
    // 从自定义菜品列表中删除菜品
    func removeCustomDish(dish: MenuItem) {
        customDishes.removeAll { $0.id == dish.id }
        saveCustomDishes()
    }
    
    // 保存自定义菜品到UserDefaults
    private func saveCustomDishes() {
        let encoder = JSONEncoder()
        if let encodedDishes = try? encoder.encode(customDishes.map { CustomDishData(from: $0) }) {
            UserDefaults.standard.set(encodedDishes, forKey: "customDishes")
        }
    }
    
    // 从UserDefaults加载自定义菜品
    private func loadCustomDishes() {
        if let savedDishes = UserDefaults.standard.data(forKey: "customDishes") {
            let decoder = JSONDecoder()
            if let loadedDishes = try? decoder.decode([CustomDishData].self, from: savedDishes) {
                customDishes = loadedDishes.map { $0.toMenuItem() }
            }
        }
    }
    
    // Calculate total extra charge
    func calculateTotalExtraCharge() -> Double {
        return items.map { $0.extraCharge * Double($0.quantity) }.reduce(0, +)
    }
}

// 自定义菜品数据结构（用于编码解码）
struct CustomDishData: Codable {
    let id: String
    let name: String
    let price: Double
    
    init(from menuItem: MenuItem) {
        self.id = menuItem.id
        self.name = menuItem.name
        self.price = menuItem.primaryPrice
    }
    
    func toMenuItem() -> MenuItem {
        return MenuItem(
            id: id,
            code: "CUSTOM",
            name: name,
            price: .fixed(price),
            category: .custom,
            subcategory: nil,
            description: "自定义菜品",
            items: nil,
            isSpicy: false
        )
    }
} 