import SwiftUI

struct OrdersView: View {
    @ObservedObject var orderManager: OrderManager
    
    var body: some View {
        NavigationView {
            List {
                if orderManager.completedOrders.isEmpty {
                    Text("暂无订单")
                        .font(.headline)
                        .foregroundColor(.gray)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding()
                        .listRowInsets(EdgeInsets())
                } else {
                    ForEach(orderManager.completedOrders.sorted(by: { $0.timestamp > $1.timestamp })) { order in
                        NavigationLink(destination: OrderDetailView(order: order)) {
                            OrderRow(order: order)
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("订单列表", displayMode: .large)
        }
    }
}

struct OrderRow: View {
    let order: Order
    let dateFormatter: DateFormatter
    
    init(order: Order) {
        self.order = order
        
        let formatter = DateFormatter()
        formatter.dateStyle = .short
        formatter.timeStyle = .short
        self.dateFormatter = formatter
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            HStack {
                Text("餐桌 #\(order.tableNumber)")
                    .font(.headline)
                
                Spacer()
                
                Text(dateFormatter.string(from: order.timestamp))
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            
            Text("\(order.items.count) 个菜品")
                .font(.subheadline)
                .foregroundColor(.gray)
            
            HStack {
                Text("总价:")
                    .font(.subheadline)
                
                Text("$\(String(format: "%.2f", order.total))")
                    .font(.headline)
                    .foregroundColor(.blue)
            }
        }
        .padding(.vertical, 4)
    }
}

struct OrderDetailView: View {
    let order: Order
    let dateFormatter: DateFormatter
    
    init(order: Order) {
        self.order = order
        
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .medium
        self.dateFormatter = formatter
    }
    
    var body: some View {
        List {
            Section(header: Text("订单信息")) {
                HStack {
                    Text("餐桌号")
                    Spacer()
                    Text("#\(order.tableNumber)")
                        .font(.headline)
                }
                
                HStack {
                    Text("时间")
                    Spacer()
                    Text(dateFormatter.string(from: order.timestamp))
                        .font(.subheadline)
                }
            }
            
            Section(header: Text("菜品列表")) {
                ForEach(order.items) { item in
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text(item.menuItem.name)
                                .font(.headline)
                            
                            if !item.notes.isEmpty {
                                Text("备注: \(item.notes)")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                        }
                        
                        Spacer()
                        
                        VStack(alignment: .trailing) {
                            Text("\(item.quantity) × $\(String(format: "%.2f", item.menuItem.price))")
                                .font(.subheadline)
                            
                            Text("$\(String(format: "%.2f", item.subtotal))")
                                .font(.headline)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            
            Section(header: Text("价格详情")) {
                HStack {
                    Text("小计")
                    Spacer()
                    Text("$\(String(format: "%.2f", order.subtotal))")
                }
                
                HStack {
                    Text("税金 (13%)")
                    Spacer()
                    Text("$\(String(format: "%.2f", order.tax))")
                }
                
                HStack {
                    Text("总计")
                        .font(.headline)
                    Spacer()
                    Text("$\(String(format: "%.2f", order.total))")
                        .font(.headline)
                        .foregroundColor(.blue)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("订单详情", displayMode: .inline)
    }
} 