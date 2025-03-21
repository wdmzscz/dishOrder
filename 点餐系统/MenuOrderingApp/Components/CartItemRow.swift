import SwiftUI

struct CartItemRow: View {
    @ObservedObject var cartManager: CartManager
    let item: CartItem
    @State private var showingNotesEditor = false
    @State private var showingExtraChargeEditor = false
    @State private var notes: String
    @State private var localQuantity: Int
    @State private var extraCharge: String
    @State private var substitutionReason: String
    
    init(cartManager: CartManager, item: CartItem) {
        self.cartManager = cartManager
        self.item = item
        self._notes = State(initialValue: item.notes)
        self._localQuantity = State(initialValue: item.quantity)
        self._extraCharge = State(initialValue: item.extraCharge == 0 ? "" : String(format: "%.2f", item.extraCharge))
        self._substitutionReason = State(initialValue: item.substitution)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack(alignment: .top, spacing: 12) {
                // Item information
                VStack(alignment: .leading, spacing: 4) {
                    HStack {
                        Text(item.menuItem.name)
                            .font(.headline)
                            .lineLimit(2)
                        
                        // 显示辣图标
                        if item.menuItem.isSpicy {
                            Image(systemName: "flame.fill")
                                .foregroundColor(.red)
                                .font(.caption)
                        }
                    }
                    
                    // 在显示价格的部分，添加原始价格和差价的显示
                    if item.menuItem.code != "EXTRA" {
                        if item.extraCharge != 0 {
                            VStack(alignment: .leading, spacing: 2) {
                                // 显示更新后的价格（已包含差价）
                                Text("\(item.menuItem.displayPrice)")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                    .fontWeight(.medium)
                                
                                // 显示价格差异
                                HStack {
                                    let originalPrice = item.menuItem.primaryPrice - item.extraCharge
                                    Text("原价: $\(String(format: "%.2f", originalPrice))")
                                        .font(.caption2)
                                        .foregroundColor(.secondary)
                                    
                                    if item.extraCharge > 0 {
                                        Text("差价: +$\(String(format: "%.2f", item.extraCharge))")
                                            .font(.caption2)
                                            .foregroundColor(.red)
                                    } else {
                                        Text("差价: -$\(String(format: "%.2f", abs(item.extraCharge)))")
                                            .font(.caption2)
                                            .foregroundColor(.green)
                                    }
                                }
                            }
                        } else {
                            // 普通价格显示（无差价）
                            Text(item.menuItem.displayPrice)
                                .font(.subheadline)
                                .foregroundColor(.blue)
                        }
                    }
                    
                    // 显示替换信息
                    if !item.substitution.isEmpty {
                        if item.substitution.contains("\n") {
                            // 多行替换信息，使用VStack显示每一行
                            VStack(alignment: .leading, spacing: 2) {
                                ForEach(item.substitution.components(separatedBy: "\n"), id: \.self) { line in
                                    Text(line)
                                        .font(.caption)
                                        .foregroundColor(.orange)
                                        .lineLimit(1)
                                }
                            }
                            .padding(.vertical, 2)
                        } else {
                            // 单行替换信息
                            Text(item.substitution)
                                .font(.caption)
                                .foregroundColor(.orange)
                                .lineLimit(2)
                        }
                    }
                    
                    // 显示额外收费
                    if item.extraCharge != 0 {
                        HStack {
                            if item.extraCharge > 0 {
                                Text("补差价: +$\(String(format: "%.2f", item.extraCharge))")
                                    .font(.caption)
                                    .foregroundColor(.red)
                                    .padding(.vertical, 2)
                                    .padding(.horizontal, 6)
                                    .background(Color.red.opacity(0.1))
                                    .cornerRadius(4)
                            } else {
                                Text("减价: -$\(String(format: "%.2f", abs(item.extraCharge)))")
                                    .font(.caption)
                                    .foregroundColor(.green)
                                    .padding(.vertical, 2)
                                    .padding(.horizontal, 6)
                                    .background(Color.green.opacity(0.1))
                                    .cornerRadius(4)
                            }
                            
                            Button(action: {
                                showingExtraChargeEditor = true
                            }) {
                                Image(systemName: "pencil")
                                    .font(.caption)
                                    .foregroundColor(.orange)
                            }
                        }
                    }
                    
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
            
            // 显示套餐内含项目
            if let items = item.menuItem.items, !items.isEmpty {
                VStack(alignment: .leading, spacing: 2) {
                    Text("包含：")
                        .font(.caption2)
                        .fontWeight(.bold)
                        .foregroundColor(.gray)
                    
                    ForEach(items.prefix(3), id: \.self) { subItem in
                        Text("• \(subItem)")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .lineLimit(1)
                    }
                    
                    if items.count > 3 {
                        Text("...")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                .padding(.leading, 8)
                .padding(.top, 2)
            }
            
            // 操作按钮行
            HStack(spacing: 12) {
                // 添加备注按钮
                Button(action: {
                    showingNotesEditor = true
                }) {
                    HStack {
                        Image(systemName: "pencil")
                            .font(.caption)
                        Text(item.notes.isEmpty ? "添加备注" : "修改备注")
                            .font(.caption)
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                }
                .buttonStyle(BorderlessButtonStyle())
                
                // 补差价按钮 - 新增
                Button(action: {
                    showingExtraChargeEditor = true
                }) {
                    HStack {
                        Image(systemName: "dollarsign.circle")
                            .font(.caption)
                        Text(item.extraCharge != 0 ? "修改差价" : "调整价格")
                            .font(.caption)
                    }
                    .padding(.vertical, 6)
                    .padding(.horizontal, 10)
                    .background(Color.orange.opacity(0.15))
                    .foregroundColor(.orange)
                    .cornerRadius(8)
                }
                .buttonStyle(BorderlessButtonStyle())
                
                Spacer()
                
                // 删除按钮
                Button(action: {
                    cartManager.removeItem(item: item)
                }) {
                    Image(systemName: "trash")
                        .font(.caption)
                        .foregroundColor(.red)
                        .padding(.vertical, 6)
                        .padding(.horizontal, 10)
                        .background(Color.red.opacity(0.1))
                        .cornerRadius(8)
                }
                .buttonStyle(BorderlessButtonStyle())
            }
        }
        .padding(.vertical, 8)
        .contextMenu {
            Button(action: {
                showingNotesEditor = true
            }) {
                Label("添加备注", systemImage: "pencil")
            }
            
            Button(action: {
                showingExtraChargeEditor = true
            }) {
                Label("补差价", systemImage: "dollarsign.circle")
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
        .sheet(isPresented: $showingExtraChargeEditor) {
            NavigationView {
                Form {
                    Section(header: Text("调整价格")) {
                        TextField("金额 (正数加价/负数减价)", text: $extraCharge)
                            .keyboardType(.decimalPad)
                        
                        HStack {
                            Button(action: {
                                if let current = Double(extraCharge) {
                                    extraCharge = String(format: "%.2f", -current)
                                } else if extraCharge.isEmpty {
                                    // 如果为空，则不设置默认值
                                }
                            }) {
                                Text("正负切换")
                                    .font(.caption)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 10)
                                    .background(Color.blue.opacity(0.1))
                                    .foregroundColor(.blue)
                                    .cornerRadius(8)
                            }
                            
                            Spacer()
                            
                            Text("提示: 正数表示加价，负数表示减价")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                        .padding(.top, 4)
                        
                        // 替换信息区域 - 使用TextEditor而非TextField以支持多行显示
                        if substitutionReason.contains("更换:") {
                            Text("菜品替换信息")
                                .font(.caption)
                                .foregroundColor(.secondary)
                                .padding(.top, 8)
                            
                            TextEditor(text: $substitutionReason)
                                .frame(minHeight: 100)
                                .font(.caption)
                                .padding(4)
                                .background(Color(.systemGray6))
                                .cornerRadius(8)
                        } else {
                            TextField("原因说明 (例：更换菜品)", text: $substitutionReason)
                                .disableAutocorrection(true)
                        }
                    }
                }
                .navigationBarTitle("调整价格", displayMode: .inline)
                .navigationBarItems(
                    leading: Button("取消") {
                        showingExtraChargeEditor = false
                    },
                    trailing: Button("保存") {
                        let charge = Double(extraCharge) ?? 0.0
                        cartManager.updateItemExtraCharge(
                            item: item, 
                            extraCharge: charge,
                            substitution: substitutionReason
                        )
                        showingExtraChargeEditor = false
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
    }
}

// 用于创建占位文本的ViewModifier
struct PlaceholderStyle: ViewModifier {
    var showPlaceHolder: Bool
    var placeholder: Text
    
    func body(content: Content) -> some View {
        ZStack(alignment: .leading) {
            if showPlaceHolder {
                placeholder
            }
            content
        }
    }
}

// 扩展View，添加placeholder支持
extension View {
    func placeholder(when shouldShow: Bool, alignment: Alignment = .leading, @ViewBuilder placeholder: () -> Text) -> some View {
        modifier(PlaceholderStyle(showPlaceHolder: shouldShow, placeholder: placeholder()))
    }
} 