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
                        NavigationLink(destination: OrderDetailView(order: order, orderManager: orderManager)) {
                            OrderRow(order: order)
                        }
                    }
                    .onDelete(perform: deleteOrders)
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("订单列表", displayMode: .large)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                }
            }
        }
    }
    
    func deleteOrders(at offsets: IndexSet) {
        // 获取排序后的订单
        let sortedOrders = orderManager.completedOrders.sorted(by: { $0.timestamp > $1.timestamp })
        
        // 找出要删除的订单ID
        let orderIdsToDelete = offsets.map { sortedOrders[$0].id }
        
        // 依次删除每个订单
        for orderId in orderIdsToDelete {
            orderManager.deleteOrder(orderId: orderId)
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
    let orderManager: OrderManager
    let dateFormatter: DateFormatter
    @Environment(\.presentationMode) var presentationMode
    @State private var showingDeleteAlert = false
    
    init(order: Order, orderManager: OrderManager) {
        self.order = order
        self.orderManager = orderManager
        
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
            
            // 添加删除订单按钮
            Section {
                Button(action: {
                    showingDeleteAlert = true
                }) {
                    HStack {
                        Image(systemName: "trash")
                            .foregroundColor(.red)
                        Text("删除订单")
                            .foregroundColor(.red)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                }
            }
        }
        .listStyle(InsetGroupedListStyle())
        .navigationBarTitle("订单详情", displayMode: .inline)
        .alert(isPresented: $showingDeleteAlert) {
            Alert(
                title: Text("确认删除"),
                message: Text("您确定要删除此订单吗？此操作无法撤销。"),
                primaryButton: .destructive(Text("删除")) {
                    // 删除订单并返回上一级页面
                    orderManager.deleteOrder(orderId: order.id)
                    presentationMode.wrappedValue.dismiss()
                },
                secondaryButton: .cancel(Text("取消"))
            )
        }
    }
} 