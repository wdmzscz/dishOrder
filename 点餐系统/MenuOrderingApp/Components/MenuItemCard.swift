import SwiftUI

struct MenuItemCard: View {
    let menuItem: MenuItem
    let cartManager: CartManager // 直接传递引用
    let addAction: () -> Void
    @State private var showingItemDetails = false
    @State private var animatingAdd = false
    @State private var animationOffset: CGSize = .zero
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading, spacing: 8) {
                // 菜品代码
                Text(menuItem.code)
                    .font(.caption)
                    .foregroundColor(.gray)
                    .padding(.bottom, 2)
                
                // 菜品名称和是否辣
                HStack(alignment: .top) {
                    Text(menuItem.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(3)
                        .fixedSize(horizontal: false, vertical: true)
                    
                    if menuItem.isSpicy {
                        Image(systemName: "flame.fill")
                            .foregroundColor(.red)
                            .font(.caption)
                    }
                }
                .padding(.bottom, 4)
                
                // 价格
                Text(menuItem.displayPrice)
                    .font(.subheadline)
                    .foregroundColor(.blue)
                    .padding(.bottom, 4)
                
                // 套餐内含项提示
                if let items = menuItem.items, !items.isEmpty {
                    Button(action: {
                        showingItemDetails = true
                    }) {
                        HStack {
                            Text("套餐详情")
                                .font(.caption)
                                .foregroundColor(.blue)
                            
                            Image(systemName: "info.circle")
                                .font(.caption)
                                .foregroundColor(.blue)
                        }
                    }
                    .padding(.vertical, 2)
                    .sheet(isPresented: $showingItemDetails) {
                        // 直接传递cartManager到套餐详情视图
                        ComboDetailsView(
                            menuItem: menuItem,
                            cartManager: cartManager
                        )
                    }
                }
                
                Spacer()
                
                // 添加按钮
                Button(action: {
                    // 触发动画
                    withAnimation(.spring(response: 0.6, dampingFraction: 0.7, blendDuration: 0.5)) {
                        animatingAdd = true
                        animationOffset = CGSize(width: UIScreen.main.bounds.width/2, height: -UIScreen.main.bounds.height/3)
                    }
                    
                    // 延迟执行实际添加，以便动画效果完成
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                        addAction()
                        // 重置动画状态
                        withAnimation {
                            animatingAdd = false
                            animationOffset = .zero
                        }
                    }
                }) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("添加")
                    }
                    .font(.subheadline)
                    .padding(.vertical, 8)
                    .padding(.horizontal, 12)
                    .frame(minWidth: 80)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(12)
            .frame(minHeight: 150, maxHeight: 200)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color(.systemGray4).opacity(0.3), radius: 4, x: 0, y: 2)
            
            // 添加动画元素
            if animatingAdd {
                // 飞向购物车的数字+1
                Text("+1")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                    .padding(12)
                    .background(Color.green)
                    .clipShape(Circle())
                    .shadow(radius: 3)
                    .offset(animationOffset)
                    .opacity(animatingAdd ? 1 : 0)
            }
        }
    }
}

// 套餐详情弹窗 - 直接接收CartManager
struct ComboDetailsView: View {
    let menuItem: MenuItem
    let cartManager: CartManager // 直接传递引用
    @Environment(\.presentationMode) var presentationMode
    @State private var showingSubstitutionSheet = false
    @State private var selectedItemToSubstitute = ""
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("套餐详情")) {
                    Text(menuItem.name)
                        .font(.headline)
                    
                    if !menuItem.description.isEmpty {
                        Text(menuItem.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.vertical, 4)
                    }
                    
                    Text(menuItem.displayPrice)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .padding(.vertical, 4)
                }
                
                if let items = menuItem.items, !items.isEmpty {
                    Section(header: Text("包含菜品")) {
                        ForEach(items, id: \.self) { item in
                            HStack {
                                Image(systemName: "circle.fill")
                                    .font(.system(size: 6))
                                    .foregroundColor(.gray)
                                    .padding(.trailing, 4)
                                
                                Text(item)
                                    .font(.body)
                                
                                Spacer()
                                
                                Button(action: {
                                    selectedItemToSubstitute = item
                                    showingSubstitutionSheet = true
                                }) {
                                    Text("更换")
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                    }
                }
                
                Section {
                    Button(action: {
                        cartManager.addItem(menuItem: menuItem)
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        HStack {
                            Spacer()
                            Text("添加到购物车")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                }
            }
            .listStyle(InsetGroupedListStyle())
            .navigationBarTitle("套餐详情", displayMode: .inline)
            .navigationBarItems(trailing: Button("关闭") {
                presentationMode.wrappedValue.dismiss()
            })
        }
        .sheet(isPresented: $showingSubstitutionSheet) {
            SimpleSubstitutionView(
                originalDish: selectedItemToSubstitute,
                menuItem: menuItem,
                cartManager: cartManager,
                dismissAction: { 
                    showingSubstitutionSheet = false
                    presentationMode.wrappedValue.dismiss() 
                }
            )
        }
    }
}

// 简化版菜品替换视图 - 已经正确实现
struct SimpleSubstitutionView: View {
    let originalDish: String
    let menuItem: MenuItem
    let cartManager: CartManager
    let dismissAction: () -> Void
    
    @Environment(\.presentationMode) var presentationMode
    @State private var newDishName = ""
    @State private var extraCharge = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("更换菜品")) {
                    Text("原菜品: \(originalDish)")
                        .foregroundColor(.secondary)
                    
                    TextField("新菜品名称", text: $newDishName)
                        .disableAutocorrection(true)
                    
                    TextField("补差价($)", text: $extraCharge)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button(action: {
                        let charge = Double(extraCharge) ?? 0.0
                        let substitutionText = "更换: \(originalDish) → \(newDishName)"
                        
                        // 为原套餐创建自定义版本
                        let customizedPrice = menuItem.primaryPrice + charge
                        let customizedMenuItem = MenuItem(
                            id: "\(menuItem.id)_customized_\(UUID().uuidString)",
                            code: menuItem.code,
                            name: menuItem.name,
                            price: .fixed(customizedPrice),
                            category: menuItem.category,
                            subcategory: menuItem.subcategory,
                            description: menuItem.description,
                            items: menuItem.items?.map { item -> String in
                                if item == originalDish {
                                    return newDishName // 替换菜品名称
                                }
                                return item
                            },
                            isSpicy: menuItem.isSpicy
                        )
                        
                        cartManager.addItem(
                            menuItem: customizedMenuItem, 
                            notes: "菜品更换",
                            extraCharge: charge,
                            substitution: substitutionText
                        )
                        
                        presentationMode.wrappedValue.dismiss()
                        dismissAction()
                    }) {
                        Text("确认更换并添加到购物车")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.blue)
                    }
                    .disabled(newDishName.isEmpty || extraCharge.isEmpty)
                }
            }
            .navigationBarTitle("菜品更换", displayMode: .inline)
            .navigationBarItems(trailing: Button("取消") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
} 