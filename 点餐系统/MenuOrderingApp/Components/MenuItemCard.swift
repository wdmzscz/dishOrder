import SwiftUI

struct MenuItemCard: View {
    let menuItem: MenuItem
    let cartManager: CartManager // 直接传递引用
    let addAction: () -> Void
    @State private var showingItemDetails = false
    @State private var animatingAdd = false
    @State private var showingPriceOptions = false
    @State private var selectedPriceOption: (key: String, value: Double)? = nil
    @State private var buttonScale: CGFloat = 1.0
    @State private var badgeOffset: CGSize = .zero // 使用新的偏移量变量
    
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
                    
                    // 重置徽章位置
                    badgeOffset = .zero
                    
                    // 显示徽章
                    animatingAdd = true
                    
                    // 使用显式的动画，设置飞向右上方的偏移量
                    withAnimation(.easeOut(duration: 0.8)) {
                        badgeOffset = CGSize(width: 100, height: -150)
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
                        
                        // 延迟隐藏徽章，等动画完成
                        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                            animatingAdd = false
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
            
            // 添加徽章动画
            if animatingAdd {
                AddBadgeView()
                    .offset(badgeOffset)
                    .zIndex(100)
            }
        }
        .sheet(isPresented: $showingPriceOptions) {
            PriceOptionsView(
                options: priceOptions,
                selectedOption: $selectedPriceOption,
                itemName: menuItem.name,
                menuItem: menuItem,
                cartManager: cartManager
            )
        }
    }
}

// 添加徽章视图
struct AddBadgeView: View {
    var body: some View {
        Text("+1")
            .font(.headline.weight(.bold))
            .foregroundColor(.white)
            .padding(12)
            .background(Color.green)
            .clipShape(Circle())
            .shadow(color: Color.black.opacity(0.3), radius: 5, x: 0, y: 3)
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
    @State private var badgeOffset: CGSize = .zero
    @State private var buttonScale: CGFloat = 1.0
    // 跟踪已替换的菜品和对应的套餐价格变化
    @State private var customizedMenuItem: MenuItem? = nil
    // 累计的差价
    @State private var totalPriceDifference: Double = 0.0
    // 保存已替换的菜品信息
    @State private var replacedItems: [String: String] = [:]
    
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
                        
                        // 显示当前价格（原价加差价）
                        let updatedPrice = menuItem.primaryPrice + totalPriceDifference
                        Text("$\(String(format: "%.2f", updatedPrice))")
                            .font(.subheadline)
                            .foregroundColor(.blue)
                            .padding(.vertical, 4)
                        
                        // 显示原价和累计差价信息
                        HStack {
                            Text("原价: \(menuItem.displayPrice)")
                                .font(.caption)
                                .foregroundColor(.secondary)
                            
                            Spacer()
                            
                            Text("差价: \(totalPriceDifference > 0 ? "+" : "")\(String(format: "$%.2f", totalPriceDifference))")
                                .font(.caption)
                                .foregroundColor(totalPriceDifference > 0 ? .red : totalPriceDifference < 0 ? .green : .secondary)
                        }
                    }
                    
                    if let items = menuItem.items, !items.isEmpty {
                        Section(header: Text("包含菜品")) {
                            ForEach(items, id: \.self) { item in
                                HStack {
                                    Image(systemName: "circle.fill")
                                        .font(.system(size: 6))
                                        .foregroundColor(.gray)
                                        .padding(.trailing, 4)
                                    
                                    // 如果菜品已被替换，显示新菜品名称
                                    if let replacement = replacedItems[item] {
                                        Text("\(item) → \(replacement)")
                                            .font(.body)
                                            .foregroundColor(.orange)
                                    } else {
                                        Text(item)
                                            .font(.body)
                                    }
                                    
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
                            
                            // 重置徽章位置
                            badgeOffset = .zero
                            
                            // 显示徽章
                            animatingAdd = true
                            
                            // 使用显式的动画，设置飞向右上方的偏移量
                            withAnimation(.easeOut(duration: 0.8)) {
                                badgeOffset = CGSize(width: 100, height: -150)
                            }
                            
                            // 延迟执行实际添加，以便动画效果完成
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                                // 检查是否有自定义套餐（已经过替换）
                                if let customized = customizedMenuItem {
                                    // 构建完整的替换信息文本
                                    var substitutionTexts: [String] = []
                                    for (originalDish, newDish) in replacedItems {
                                        substitutionTexts.append("更换: \(originalDish) → \(newDish)")
                                    }
                                    let substitutionText = substitutionTexts.joined(separator: "\n")
                                    
                                    // 构建价格差异文本，显示在名称中
                                    let diffText = totalPriceDifference != 0 ? 
                                        " (差价: \(totalPriceDifference > 0 ? "+" : "")\(String(format: "%.2f", totalPriceDifference)))" : 
                                        ""
                                    
                                    // 创建一个新的MenuItem，包含完整的替换信息
                                    let updatedMenuItem = MenuItem(
                                        id: "\(menuItem.id)_customized_\(UUID().uuidString)",
                                        code: menuItem.code,
                                        name: "\(menuItem.name)\(diffText)",
                                        price: .fixed(menuItem.primaryPrice), // 保持原价，不包含差价
                                        category: menuItem.category,
                                        subcategory: menuItem.subcategory,
                                        description: menuItem.description,
                                        items: menuItem.items?.map { item in
                                            if let replacement = replacedItems[item] {
                                                return replacement // 替换为新菜品名称
                                            }
                                            return item
                                        },
                                        isSpicy: menuItem.isSpicy
                                    )
                                    
                                    // 使用自定义套餐，增加说明
                                    cartManager.addItem(
                                        menuItem: updatedMenuItem, 
                                        notes: "菜品更换",
                                        extraCharge: totalPriceDifference,
                                        substitution: substitutionText
                                    )
                                } else {
                                    // 使用原始套餐
                                    cartManager.addItem(menuItem: menuItem)
                                }
                                
                                // 重置动画状态并关闭弹窗
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                    animatingAdd = false
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
                
                // 添加徽章动画
                if animatingAdd {
                    AddBadgeView()
                        .offset(badgeOffset)
                        .zIndex(100)
                }
            }
            .navigationBarTitle("套餐详情", displayMode: .inline)
            .navigationBarItems(trailing: Button("关闭") {
                presentationMode.wrappedValue.dismiss()
            })
            .onReceive(NotificationCenter.default.publisher(for: Notification.Name("DismissComboDetailsView"))) { _ in
                // 收到通知时关闭视图
                presentationMode.wrappedValue.dismiss()
            }
        }
        .sheet(isPresented: $showingSubstitutionSheet) {
            SimpleSubstitutionView(
                originalDish: selectedItemToSubstitute,
                menuItem: menuItem,
                cartManager: cartManager,
                currentPriceDifference: totalPriceDifference, // 传递当前累计的差价
                onCustomization: { customItem, newDishName, priceDifference in
                    // 更新已替换菜品信息
                    replacedItems[selectedItemToSubstitute] = newDishName
                    
                    // 累加差价
                    totalPriceDifference += priceDifference
                    
                    // 保存自定义套餐
                    self.customizedMenuItem = customItem
                },
                dismissAction: { 
                    showingSubstitutionSheet = false
                }
            )
        }
    }
}

// 简化版菜品替换视图
struct SimpleSubstitutionView: View {
    let originalDish: String
    let menuItem: MenuItem
    let cartManager: CartManager
    let currentPriceDifference: Double // 接收当前累计的差价
    let onCustomization: (MenuItem, String, Double) -> Void // 更新回调，传递：自定义套餐、新菜品名称、差价
    let dismissAction: () -> Void
    
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedNewDish: MenuItem? = nil
    @State private var searchText = ""
    @State private var showingMenuItemPicker = true
    @State private var extraCharge: Double = 0.0
    @State private var manualExtraCharge = ""
    @State private var isPositiveDiff = true // 差价是否为正（加钱）
    @State private var animatingAdd = false
    @State private var badgeOffset: CGSize = .zero
    @State private var buttonScale: CGFloat = 1.0
    
    // 获取原菜品的价格，不再提供默认值
    private func getOriginalDishPrice() -> Double? {
        // 尝试从菜单中查找原始菜品
        for item in MenuRepository.shared.allItems {
            if item.name == originalDish || item.name.contains(originalDish) {
                return item.primaryPrice
            }
        }
        
        // 找不到匹配项时，返回nil
        return nil
    }
    
    // 计算价格差异
    private func calculatePriceDifference() -> Double? {
        guard let selectedNewDish = selectedNewDish else { return nil }
        guard let originalPrice = getOriginalDishPrice() else { return nil }
        return selectedNewDish.primaryPrice - originalPrice
    }
    
    var body: some View {
        if showingMenuItemPicker {
            // 菜单选择视图
            MenuItemPickerView(
                searchText: $searchText, 
                selectedItem: $selectedNewDish, 
                onDismiss: {
                    showingMenuItemPicker = false
                    if selectedNewDish == nil {
                        // 如果没有选择，关闭整个替换视图
                        presentationMode.wrappedValue.dismiss()
                    }
                },
                excludeComboItems: true // 排除套餐
            )
        } else {
            // 确认替换视图
            NavigationView {
                ZStack {
                    Form {
                        Section(header: Text("更换菜品")) {
                            HStack {
                                Text("原菜品: \(originalDish)")
                                Spacer()
                                if let price = getOriginalDishPrice() {
                                    Text("$\(String(format: "%.2f", price))")
                                        .foregroundColor(.secondary)
                                } else {
                                    Text("未找到价格")
                                        .foregroundColor(.red)
                                }
                            }
                            
                            if let newDish = selectedNewDish {
                                HStack {
                                    Text("新菜品: \(newDish.name)")
                                    Spacer()
                                    
                                    // 添加重新选择按钮
                                    Button(action: {
                                        // 返回到菜品选择界面
                                        showingMenuItemPicker = true
                                    }) {
                                        Text("重选")
                                            .font(.caption)
                                            .padding(.vertical, 4)
                                            .padding(.horizontal, 8)
                                            .background(Color.blue.opacity(0.1))
                                            .foregroundColor(.blue)
                                            .cornerRadius(4)
                                    }
                                }
                                
                                Text(newDish.displayPrice)
                                    .foregroundColor(.blue)

                                if let priceDiff = calculatePriceDifference() {
                                    // 自动计算到的差价
                                    HStack {
                                        Text("补差价:")
                                        Spacer()
                                        Text(priceDiff > 0 ? "+$\(String(format: "%.2f", priceDiff))" : 
                                             priceDiff < 0 ? "-$\(String(format: "%.2f", abs(priceDiff)))" : "$0.00")
                                            .foregroundColor(priceDiff > 0 ? .red : priceDiff < 0 ? .green : .primary)
                                    }
                                } else {
                                    // 手动输入差价
                                    VStack(spacing: 10) {
                                        HStack {
                                            Text("补差价:")
                                            TextField("手动输入", text: $manualExtraCharge)
                                                .keyboardType(.decimalPad)
                                        }
                                        
                                        // 添加正负选择按钮
                                        HStack {
                                            Text("差价类型:")
                                            Spacer()
                                            Picker("", selection: $isPositiveDiff) {
                                                Text("加钱").tag(true)
                                                Text("退钱").tag(false)
                                            }
                                            .pickerStyle(SegmentedPickerStyle())
                                            .frame(width: 140)
                                        }
                                    }
                                }
                                
                                // 显示更新后的套餐价格
                                HStack {
                                    Text("当前套餐价格:")
                                    Spacer()
                                    let currentPrice = menuItem.primaryPrice + currentPriceDifference
                                    Text("$\(String(format: "%.2f", currentPrice))")
                                        .foregroundColor(.secondary)
                                }
                                
                                HStack {
                                    Text("更新后价格:")
                                    Spacer()
                                    let updatedPrice = getCurrentPrice() + calculateNewDifference()
                                    Text("$\(String(format: "%.2f", updatedPrice))")
                                        .foregroundColor(.blue)
                                        .fontWeight(.medium)
                                }
                            }
                        }
                        
                        Section {
                            // 确认更换按钮 - 只替换菜品，返回到套餐详情页面
                            Button(action: {
                                confirmSubstitution(addToCart: false)
                            }) {
                                Text("确认更换")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .foregroundColor(.blue)
                            }
                            .disabled(selectedNewDish == nil || (getOriginalDishPrice() == nil && manualExtraCharge.isEmpty))
                            
                            // 添加到购物车按钮 - 替换并添加到购物车
                            Button(action: {
                                confirmSubstitution(addToCart: true)
                            }) {
                                Text("确认更换并添加到购物车")
                                    .frame(maxWidth: .infinity, alignment: .center)
                                    .foregroundColor(.blue)
                            }
                            .disabled(selectedNewDish == nil || (getOriginalDishPrice() == nil && manualExtraCharge.isEmpty))
                        }
                    }
                    
                    // 添加徽章动画
                    if animatingAdd {
                        AddBadgeView()
                            .offset(badgeOffset)
                            .zIndex(100)
                    }
                }
                .navigationBarTitle("菜品更换", displayMode: .inline)
                .navigationBarItems(trailing: Button("取消") {
                    presentationMode.wrappedValue.dismiss()
                })
                .onAppear {
                    // 获取原菜品价格
                    if getOriginalDishPrice() == nil {
                        // 如果找不到原菜品价格，尝试从菜单中查找
                        for item in MenuRepository.shared.allItems {
                            if item.name == originalDish || item.name.contains(originalDish) {
                                // 使用菜单中的价格
                                extraCharge = item.primaryPrice - menuItem.primaryPrice
                                break
                            }
                        }
                    }
                }
            }
        }
    }
    
    // 获取当前套餐价格（包含已有差价）
    private func getCurrentPrice() -> Double {
        return menuItem.primaryPrice + currentPriceDifference
    }
    
    // 计算本次替换产生的新差价
    private func calculateNewDifference() -> Double {
        let diff: Double
        if let calculatedDiff = calculatePriceDifference() {
            diff = calculatedDiff
        } else if let manualDiff = Double(manualExtraCharge) {
            // 应用正负选择
            diff = isPositiveDiff ? manualDiff : -manualDiff
        } else {
            diff = 0
        }
        return diff
    }
    
    // 获取最终价格
    private func getFinalPrice() -> Double {
        return getCurrentPrice() + calculateNewDifference()
    }
    
    private func confirmSubstitution(addToCart: Bool) {
        guard let newDish = selectedNewDish else { return }
        
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
        
        if addToCart {
            // 添加到购物车时显示动画
            animatingAdd = true
            badgeOffset = .zero
            
            withAnimation(.easeOut(duration: 0.8)) {
                badgeOffset = CGSize(width: 100, height: -150)
            }
        }
        
        // 确定本次替换的差价（不包含之前的累计差价）
        let newDifferenceOnly: Double
        if let calculatedDiff = calculatePriceDifference() {
            newDifferenceOnly = calculatedDiff
        } else if let manualDiff = Double(manualExtraCharge) {
            // 应用正负选择
            newDifferenceOnly = isPositiveDiff ? manualDiff : -manualDiff
        } else {
            newDifferenceOnly = 0
        }
        
        // 准备数据
        let substitutionText = "更换: \(originalDish) → \(newDish.name)"
        let extraChargeText = newDifferenceOnly != 0 ? " (差价: \(newDifferenceOnly > 0 ? "+" : "")\(String(format: "%.2f", newDifferenceOnly)))" : ""
        
        // 为原套餐创建自定义版本
        let customizedMenuItem = MenuItem(
            id: "\(menuItem.id)_customized_\(UUID().uuidString)",
            code: menuItem.code,
            name: "\(menuItem.name)\(extraChargeText)",
            price: .fixed(menuItem.primaryPrice), // 保持原价，不包含差价
            category: menuItem.category,
            subcategory: menuItem.subcategory,
            description: menuItem.description,
            items: menuItem.items?.map { item -> String in
                if item == originalDish {
                    return newDish.name // 替换菜品名称
                }
                return item
            },
            isSpicy: menuItem.isSpicy
        )
        
        // 调用回调更新套餐详情页面的价格，只传递这次替换的新差价
        onCustomization(customizedMenuItem, newDish.name, newDifferenceOnly)
        
        if addToCart {
            // 延迟执行实际添加，以便动画效果完成
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.7) {
                cartManager.addItem(
                    menuItem: customizedMenuItem, 
                    notes: "菜品更换",
                    extraCharge: newDifferenceOnly,
                    substitution: substitutionText
                )
                
                // 重置动画状态并关闭弹窗
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    animatingAdd = false
                    
                    // 关闭整个视图树，返回到菜单主页
                    // 首先关闭当前的替换菜品视图
                    presentationMode.wrappedValue.dismiss()
                    
                    // 然后关闭套餐详情视图，调用dismissAction
                    dismissAction()
                    
                    // 最后关闭套餐详情本身的presentationMode
                    // 使用NotificationCenter发送一个通知，告诉ComboDetailsView关闭自己
                    NotificationCenter.default.post(name: Notification.Name("DismissComboDetailsView"), object: nil)
                }
            }
        } else {
            // 只替换菜品，不添加到购物车
            presentationMode.wrappedValue.dismiss() // 只关闭替换菜品视图
            // 不调用dismissAction()，所以套餐详情视图会保持打开状态
        }
    }
}

// 菜单选择视图
struct MenuItemPickerView: View {
    @Binding var searchText: String
    @Binding var selectedItem: MenuItem?
    let onDismiss: () -> Void
    let excludeComboItems: Bool // 是否排除套餐
    @State private var filteredItems: [MenuItem] = []
    @State private var selectedCategory: String = "全部"
    
    private var categories: [String] {
        var categorySet = Set<String>()
        MenuRepository.shared.allItems.forEach { 
            categorySet.insert($0.category.displayName)
        }
        return ["全部"] + Array(categorySet).sorted()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                // 搜索栏
                TextField("搜索菜品", text: $searchText)
                    .padding(7)
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .padding(.horizontal)
                    .onChange(of: searchText) { _, _ in
                        updateFilteredItems()
                    }
                
                // 分类选择器
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(categories, id: \.self) { category in
                            Button(action: {
                                selectedCategory = category
                                updateFilteredItems()
                            }) {
                                Text(category)
                                    .padding(.vertical, 6)
                                    .padding(.horizontal, 12)
                                    .background(
                                        selectedCategory == category ?
                                        Color.blue : Color(.systemGray6)
                                    )
                                    .foregroundColor(
                                        selectedCategory == category ?
                                        Color.white : Color.primary
                                    )
                                    .cornerRadius(12)
                            }
                        }
                    }
                    .padding()
                }
                
                // 菜品列表
                List(filteredItems) { item in
                    Button(action: {
                        selectedItem = item
                        onDismiss()
                    }) {
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .fontWeight(.medium)
                                
                                Text(item.code)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            
                            Spacer()
                            
                            Text(item.displayPrice)
                                .foregroundColor(.blue)
                        }
                    }
                    .foregroundColor(.primary)
                }
            }
            .navigationBarTitle("选择替换菜品", displayMode: .inline)
            .navigationBarItems(trailing: Button("取消") {
                onDismiss()
            })
            .onAppear {
                updateFilteredItems()
            }
        }
    }
    
    private func updateFilteredItems() {
        var items = MenuRepository.shared.allItems
        
        // 如果需要排除套餐，过滤掉items不为nil的菜品
        if excludeComboItems {
            items = items.filter { $0.items == nil }
        }
        
        if searchText.isEmpty && selectedCategory == "全部" {
            filteredItems = items
            return
        }
        
        filteredItems = items.filter { item in
            let matchesSearch = searchText.isEmpty || 
                               item.name.localizedCaseInsensitiveContains(searchText) ||
                               item.code.localizedCaseInsensitiveContains(searchText)
            
            let matchesCategory = selectedCategory == "全部" || item.category.displayName == selectedCategory
            
            return matchesSearch && matchesCategory
        }
    }
}

// 价格选项选择视图
struct PriceOptionsView: View {
    let options: [(key: String, value: Double)]
    @Binding var selectedOption: (key: String, value: Double)?
    let itemName: String
    let menuItem: MenuItem
    let cartManager: CartManager
    @State private var animatingAdd = false
    @State private var badgeOffset: CGSize = .zero
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            ZStack {
                List {
                    Section(header: Text("选择价格规格")) {
                        ForEach(options, id: \.key) { option in
                            Button(action: {
                                selectedOption = option
                                
                                // 创建一个自定义的MenuItem，包含选中的价格信息
                                let customMenuItem = MenuItem(
                                    id: "\(menuItem.id)_\(option.key)",
                                    code: menuItem.code,
                                    name: "\(menuItem.name) (\(option.key))",
                                    price: .fixed(option.value),
                                    category: menuItem.category,
                                    subcategory: menuItem.subcategory,
                                    description: menuItem.description,
                                    items: menuItem.items,
                                    isSpicy: menuItem.isSpicy
                                )
                                
                                // 显示添加动画
                                animatingAdd = true
                                withAnimation(.easeOut(duration: 0.8)) {
                                    badgeOffset = CGSize(width: 100, height: -150)
                                }
                                
                                // 延迟执行添加到购物车，以便用户可以看到动画
                                DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                                    // 直接添加到购物车
                                    cartManager.addItem(menuItem: customMenuItem)
                                    
                                    // 延迟关闭价格选择视图
                                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                                        animatingAdd = false
                                        presentationMode.wrappedValue.dismiss()
                                    }
                                }
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
                
                // 添加徽章动画
                if animatingAdd {
                    AddBadgeView()
                        .offset(badgeOffset)
                        .zIndex(100)
                }
            }
            .navigationBarTitle("\(itemName) - 价格选择", displayMode: .inline)
            .navigationBarItems(trailing: Button("取消") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
} 