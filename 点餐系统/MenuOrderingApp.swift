import SwiftUI

@main
struct MenuOrderingApp: App {
    @StateObject private var cartManager = CartManager()
    @StateObject private var orderManager = OrderManager()
    
    var body: some Scene {
        WindowGroup {
            TabView {
                MenuView(cartManager: cartManager, orderManager: orderManager)
                    .tabItem {
                        Label("菜单", systemImage: "list.dash")
                    }
                
                OrdersView(orderManager: orderManager)
                    .tabItem {
                        Label("订单", systemImage: "doc.text")
                    }
            }
            .accentColor(.blue)
        }
    }
} 