import SwiftUI

struct MenuItemCard: View {
    let menuItem: MenuItem
    let cartManager: CartManager // 直接传递引用
    let addAction: () -> Void
    @State private var showingItemDetails = false
    @State private var animatingAdd = false
    @State private var animationOffset: CGSize = .zero
    @State private var showingPriceOptions = false
    @State private var selectedPriceOption: (key: String, value: Double)? = nil
    @State private var buttonScale: CGFloat = 1.0
    
    // 获取价格选项数组
    var priceOptions: [(key: String, value: Double)] {
        return menuItem.price.priceOptions
    }
    
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
                
                // 价格显示
                if case .options = menuItem.price, priceOptions.count > 1 {
                    // 有多个价格选项时
                    if let selected = selectedPriceOption {
                        HStack {
                            Text("\(selected.key): $\(String(format: "%.2f", selected.value))")
                                .font(.subheadline)
                                .foregroundColor(.blue)
                            
                            Button(action: {
                                showingPriceOptions = true
                            }) {
                                Image(systemName: "chevron.down")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.bottom, 4)
                    } else {
                        Button(action: {
                            showingPriceOptions = true
                        }) {
                            HStack {
                                Text("选择价格规格")
                                    .font(.subheadline)
                                    .foregroundColor(.blue)
                                
                                Image(systemName: "chevron.down")
                                    .font(.caption)
                                    .foregroundColor(.blue)
                            }
                        }
                        .padding(.bottom, 4)
                    }
                } else {
                    // 单一价格
                    Text(menuItem.displayPrice)
                        .font(.subheadline)
                        .foregroundColor(.blue)
                        .padding(.bottom, 4)
                }
                
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
                    // 如果有价格选项但用户未选择，弹出选择界面
                    if case .options = menuItem.price, priceOptions.count > 1, selectedPriceOption == nil {
                        showingPriceOptions = true
                        return
                    }
                    
                    // 按钮按下效果
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.6, blendDuration: 0.1)) {
                        buttonScale = 0.9
                    }
                    
                    // 按钮恢复效果
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                        withAnimation(.spring(response: 0.2, dampingFraction: 0.6, blendDuration: 0.1)) {
                            buttonScale = 1.0
                        }
                    }
                    
                    // 触发添加动画
                    withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
                        animatingAdd = true
                        // 使用更明显的位移
                        animationOffset = CGSize(width: 100, height: -150)
                    }
                    
                    // 延迟执行实际添加，以便动画效果完成
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                        if let selected = selectedPriceOption {
                            // 添加带选择价格的菜品
                            let customMenuItem = MenuItem(
                                id: "\(menuItem.id)_\(selected.key)",
                                code: menuItem.code,
                                name: "\(menuItem.name) (\(selected.key))",
                                price: .fixed(selected.value),
                                category: menuItem.category,
                                subcategory: menuItem.subcategory,
                                description: menuItem.description,
                                items: menuItem.items,
                                isSpicy: menuItem.isSpicy
                            )
                            cartManager.addItem(menuItem: customMenuItem)
                        } else {
                            // 添加普通价格菜品
                            addAction()
                        }
                        
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
                .scaleEffect(buttonScale)
                .frame(maxWidth: .infinity, alignment: .center)
            }
            .padding(12)
            .frame(minHeight: 150, maxHeight: 200)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color(.systemGray4).opacity(0.3), radius: 4, x: 0, y: 2)
        }
        .overlay(
            // 将动画元素移到overlay中，确保它不会被其他视图遮挡
            Group {
                if animatingAdd {
                    // 动画元素
                    Text("+1")
                        .font(.headline.weight(.bold))
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color.green)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                        .offset(animationOffset)
                        .transition(.scale.combined(with: .opacity))
                }
            }
        )
        .sheet(isPresented: $showingPriceOptions) {
            PriceOptionsView(
                options: priceOptions,
                selectedOption: $selectedPriceOption,
                itemName: menuItem.name
            )
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
    @State private var animatingAdd = false
    @State private var animationOffset: CGSize = .zero
    @State private var buttonScale: CGFloat = 1.0
    
    var body: some View {
        NavigationView {
            ZStack {
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
                            // 按钮按下效果
                            withAnimation(.spring(response: 0.2, dampingFraction: 0.6, blendDuration: 0.1)) {
                                buttonScale = 0.9
                            }
                            
                            // 按钮恢复效果
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.spring(response: 0.2, dampingFraction: 0.6, blendDuration: 0.1)) {
                                    buttonScale = 1.0
                                }
                            }
                            
                            // 触发添加动画
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
                                animatingAdd = true
                                animationOffset = CGSize(width: 100, height: -150)
                            }
                            
                            // 延迟执行实际添加，以便动画效果完成
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                cartManager.addItem(menuItem: menuItem)
                                
                                // 重置动画状态并关闭弹窗
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation {
                                        animatingAdd = false
                                        animationOffset = .zero
                                    }
                                    presentationMode.wrappedValue.dismiss()
                                }
                            }
                        }) {
                            HStack {
                                Spacer()
                                Text("添加到购物车")
                                    .fontWeight(.semibold)
                                Spacer()
                            }
                        }
                        .scaleEffect(buttonScale)
                    }
                }
                .listStyle(InsetGroupedListStyle())
                
                // 添加动画元素
                if animatingAdd {
                    Text("+1")
                        .font(.headline.weight(.bold))
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color.green)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                        .offset(animationOffset)
                        .transition(.scale.combined(with: .opacity))
                        .zIndex(1000)
                }
            }
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
    @State private var animatingAdd = false
    @State private var animationOffset: CGSize = .zero
    @State private var buttonScale: CGFloat = 1.0
    
    var body: some View {
        NavigationView {
            ZStack {
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
                            // 按钮按下效果
                            withAnimation(.spring(response: 0.2, dampingFraction: 0.6, blendDuration: 0.1)) {
                                buttonScale = 0.9
                            }
                            
                            // 按钮恢复效果
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
                                withAnimation(.spring(response: 0.2, dampingFraction: 0.6, blendDuration: 0.1)) {
                                    buttonScale = 1.0
                                }
                            }
                            
                            // 触发添加动画
                            withAnimation(.spring(response: 0.5, dampingFraction: 0.7, blendDuration: 0.3)) {
                                animatingAdd = true
                                animationOffset = CGSize(width: 100, height: -150)
                            }
                            
                            // 准备数据
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
                            
                            // 延迟执行实际添加，以便动画效果完成
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                cartManager.addItem(
                                    menuItem: customizedMenuItem, 
                                    notes: "菜品更换",
                                    extraCharge: charge,
                                    substitution: substitutionText
                                )
                                
                                // 重置动画状态并关闭弹窗
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    withAnimation {
                                        animatingAdd = false
                                        animationOffset = .zero
                                    }
                                    presentationMode.wrappedValue.dismiss()
                                    dismissAction()
                                }
                            }
                        }) {
                            Text("确认更换并添加到购物车")
                                .frame(maxWidth: .infinity, alignment: .center)
                                .foregroundColor(.blue)
                        }
                        .scaleEffect(buttonScale)
                        .disabled(newDishName.isEmpty || extraCharge.isEmpty)
                    }
                }
                
                // 添加动画元素
                if animatingAdd {
                    Text("+1")
                        .font(.headline.weight(.bold))
                        .foregroundColor(.white)
                        .padding(15)
                        .background(Color.green)
                        .clipShape(Circle())
                        .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
                        .offset(animationOffset)
                        .transition(.scale.combined(with: .opacity))
                        .zIndex(1000)
                }
            }
            .navigationBarTitle("菜品更换", displayMode: .inline)
            .navigationBarItems(trailing: Button("取消") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

// 价格选项选择视图
struct PriceOptionsView: View {
    let options: [(key: String, value: Double)]
    @Binding var selectedOption: (key: String, value: Double)?
    let itemName: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("选择价格规格")) {
                    ForEach(options, id: \.key) { option in
                        Button(action: {
                            selectedOption = option
                            presentationMode.wrappedValue.dismiss()
                        }) {
                            HStack {
                                Text(option.key)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                Text("$\(String(format: "%.2f", option.value))")
                                    .foregroundColor(.blue)
                                    .fontWeight(.semibold)
                                
                                if selectedOption?.key == option.key {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                    }
                }
            }
            .navigationBarTitle("\(itemName) - 价格选择", displayMode: .inline)
            .navigationBarItems(trailing: Button("取消") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
} 