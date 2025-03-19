import Foundation

struct Order: Identifiable {
    let id = UUID()
    let tableNumber: Int
    let items: [CartItem]
    let subtotal: Double
    let tax: Double
    let total: Double
    let timestamp: Date
    
    init(tableNumber: Int, items: [CartItem], subtotal: Double, tax: Double) {
        self.tableNumber = tableNumber
        self.items = items
        self.subtotal = subtotal
        self.tax = tax
        self.total = subtotal + tax
        self.timestamp = Date()
    }
}

// Order manager to handle completed orders
class OrderManager: ObservableObject {
    @Published var completedOrders: [Order] = []
    
    func addOrder(from cart: CartManager) {
        let newOrder = Order(
            tableNumber: cart.tableNumber,
            items: cart.items,
            subtotal: cart.subtotal,
            tax: cart.taxAmount
        )
        
        completedOrders.append(newOrder)
    }
    
    // 删除指定订单
    func deleteOrder(orderId: UUID) {
        completedOrders.removeAll { $0.id == orderId }
    }
    
    // 删除指定索引的订单
    func deleteOrder(at indexSet: IndexSet) {
        completedOrders.remove(atOffsets: indexSet)
    }
} 