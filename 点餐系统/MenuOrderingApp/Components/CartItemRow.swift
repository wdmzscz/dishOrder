import SwiftUI

struct CartItemRow: View {
    @ObservedObject var cartManager: CartManager
    let item: CartItem
    @State private var showingNotesEditor = false
    @State private var notes: String
    @State private var localQuantity: Int
    
    init(cartManager: CartManager, item: CartItem) {
        self.cartManager = cartManager
        self.item = item
        self._notes = State(initialValue: item.notes)
        self._localQuantity = State(initialValue: item.quantity)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Item information
            VStack(alignment: .leading, spacing: 4) {
                Text(item.menuItem.name)
                    .font(.headline)
                    .lineLimit(2)
                
                Text("$\(String(format: "%.2f", item.menuItem.price))")
                    .font(.subheadline)
                    .foregroundColor(.blue)
                
                if !item.notes.isEmpty {
                    Text("备注: \(item.notes)")
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(1)
                }
            }
            
            Spacer()
            
            // 重新实现数量控制UI
            HStack(spacing: 16) {
                // 减号按钮 - 减小数量
                Button {
                    let newQuantity = max(0, localQuantity - 1)
                    if newQuantity == 0 {
                        cartManager.removeItem(item: item)
                    } else {
                        // 禁用onReceive的监听，防止状态被重置
                        // 直接更新CartManager
                        cartManager.updateItemQuantity(item: item, quantity: newQuantity)
                        // 更新后再设置本地状态
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                            localQuantity = newQuantity
                        }
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.blue)
                }
                .buttonStyle(BorderlessButtonStyle()) // 确保按钮可以独立点击
                
                // 显示数量
                Text("\(localQuantity)")
                    .font(.headline)
                    .frame(minWidth: 30)
                    .multilineTextAlignment(.center)
                
                // 加号按钮 - 增加数量
                Button {
                    let newQuantity = localQuantity + 1
                    // 直接更新CartManager，不依赖本地状态同步
                    cartManager.updateItemQuantity(item: item, quantity: newQuantity)
                    
                    // 直接设置本地状态，不等待数据同步
                    localQuantity = newQuantity
                } label: {
                    Image(systemName: "plus.circle.fill")
                        .resizable()
                        .frame(width: 28, height: 28)
                        .foregroundColor(.blue)
                }
                .buttonStyle(BorderlessButtonStyle()) // 确保按钮可以独立点击
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(8)
        }
        .padding(.vertical, 8)
        .contextMenu {
            Button(action: {
                showingNotesEditor = true
            }) {
                Label("添加备注", systemImage: "pencil")
            }
            
            Button(action: {
                cartManager.removeItem(item: item)
            }) {
                Label("删除", systemImage: "trash")
            }
        }
        .sheet(isPresented: $showingNotesEditor) {
            NavigationView {
                VStack {
                    TextField("添加特殊要求", text: $notes)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding()
                    
                    Spacer()
                }
                .navigationBarTitle("添加备注", displayMode: .inline)
                .navigationBarItems(
                    leading: Button("取消") {
                        showingNotesEditor = false
                    },
                    trailing: Button("保存") {
                        cartManager.updateItemNotes(item: item, notes: notes)
                        showingNotesEditor = false
                    }
                )
            }
        }
        // 只在初始加载时同步一次数据
        .onAppear {
            if let updatedItem = cartManager.items.first(where: { $0.id == item.id }) {
                self.localQuantity = updatedItem.quantity
            }
        }
        // 移除onReceive监听，避免状态被重置
    }
} 