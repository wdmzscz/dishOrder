import SwiftUI

struct MenuView: View {
    @ObservedObject var cartManager: CartManager
    @ObservedObject var orderManager: OrderManager
    @State private var searchText = ""
    @State private var selectedCategory: MenuItem.Category? = nil
    @State private var showingCart = false
    @State private var showingTableSelector = false
    @State private var showingCustomDishSheet = false
    
    private var filteredItems: [MenuItem] {
        var menuItems: [MenuItem] = []
        
        // 自定义类别特殊处理
        if let category = selectedCategory {
            if category == .custom {
                menuItems = cartManager.customDishes
            } else {
                menuItems = MenuItem.sampleItems.filter { $0.category == category }
            }
        } else {
            // 全部类别
            menuItems = MenuItem.sampleItems
        }
        
        // 搜索过滤
        if searchText.isEmpty {
            return menuItems
        } else {
            return menuItems.filter { $0.name.localizedCaseInsensitiveContains(searchText) }
        }
    }
    
    private var groupedItems: [MenuItem.Category: [MenuItem]] {
        Dictionary(grouping: filteredItems) { $0.category }
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search bar
                SearchBar(text: $searchText)
                    .padding(.horizontal)
                    .padding(.bottom, 8)
                
                // Category tabs
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 12) {
                        CategoryButton(
                            title: "全部",
                            isSelected: selectedCategory == nil,
                            action: { selectedCategory = nil }
                        )
                        
                        ForEach(MenuItem.Category.allCases) { category in
                            CategoryButton(
                                title: category.displayName,
                                isSelected: selectedCategory == category,
                                action: { selectedCategory = category }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 8)
                
                // Menu items grid
                if filteredItems.isEmpty {
                    Spacer()
                    Text("没有找到菜品")
                        .font(.title)
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    if selectedCategory != nil {
                        // 如果是自定义菜品类别，使用特殊布局
                        if selectedCategory == .custom {
                            ScrollView {
                                LazyVStack(spacing: 16) {
                                    ForEach(filteredItems) { item in
                                        CustomDishItemRow(item: item, cartManager: cartManager)
                                    }
                                }
                                .padding()
                                .padding(.bottom, 80)
                            }
                        } else {
                            // 其他类别正常展示为网格
                            ScrollView {
                                LazyVGrid(columns: [
                                    GridItem(.flexible()),
                                    GridItem(.flexible())
                                ], spacing: 20) {
                                    ForEach(filteredItems) { item in
                                        MenuItemCard(
                                            menuItem: item,
                                            cartManager: cartManager
                                        ) {
                                            cartManager.addItem(menuItem: item)
                                        }
                                        .frame(height: item.items != nil ? 200 : 170)
                                    }
                                }
                                .padding()
                                // Add extra padding at bottom for cart button
                                .padding(.bottom, 80)
                            }
                        }
                    } else {
                        // Show as sections by category if no category filter
                        ScrollView {
                            VStack(alignment: .leading, spacing: 24) {
                                ForEach(MenuItem.Category.allCases) { category in
                                    if let items = groupedItems[category], !items.isEmpty {
                                        VStack(alignment: .leading, spacing: 12) {
                                            Text(category.displayName)
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .padding(.horizontal)
                                            
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                HStack(spacing: 20) {
                                                    ForEach(items) { item in
                                                        MenuItemCard(
                                                            menuItem: item,
                                                            cartManager: cartManager
                                                        ) {
                                                            cartManager.addItem(menuItem: item)
                                                        }
                                                        .frame(width: 200)
                                                    }
                                                }
                                                .padding(.horizontal)
                                            }
                                        }
                                    }
                                }
                            }
                            .padding(.vertical)
                            // Add extra padding at bottom for cart button
                            .padding(.bottom, 80)
                        }
                    }
                }
            }
            .navigationBarTitle("点餐系统", displayMode: .inline)
            .navigationBarItems(
                leading: Image(systemName: "fork.knife")
                    .font(.title2),
                trailing: HStack {
                    Button(action: {
                        showingCustomDishSheet = true
                    }) {
                        Image(systemName: "plus.circle")
                            .font(.title2)
                    }
                    
                    Spacer().frame(width: 20)
                    
                    Button(action: {
                        showingTableSelector = true
                    }) {
                        HStack {
                            Text("餐桌 \(cartManager.tableNumber.formatted)")
                            Image(systemName: "chevron.down")
                        }
                    }
                    
                    Spacer().frame(width: 20)
                    
                    Button(action: {
                        showingCart = true
                    }) {
                        ZStack(alignment: .topTrailing) {
                            Image(systemName: "cart.fill")
                                .font(.title2)
                            
                            if !cartManager.items.isEmpty {
                                Text("\(cartManager.items.map { $0.quantity }.reduce(0, +))")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 18, height: 18)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: -8)
                            }
                        }
                    }
                }
            )
            .sheet(isPresented: $showingCart) {
                CartView(cartManager: cartManager, orderManager: orderManager)
            }
            .sheet(isPresented: $showingTableSelector) {
                TableSelector(tableNumber: $cartManager.tableNumber)
            }
            .sheet(isPresented: $showingCustomDishSheet) {
                CustomDishView(cartManager: cartManager)
            }
            
            // Cart button fixed at bottom
            VStack {
                Spacer()
                
                if !cartManager.items.isEmpty {
                    Button(action: {
                        showingCart = true
                    }) {
                        HStack {
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: "cart.fill")
                                    .font(.title3)
                                
                                Text("\(cartManager.items.map { $0.quantity }.reduce(0, +))")
                                    .font(.caption2)
                                    .fontWeight(.bold)
                                    .foregroundColor(.white)
                                    .frame(width: 18, height: 18)
                                    .background(Color.red)
                                    .clipShape(Circle())
                                    .offset(x: 8, y: -8)
                            }
                            .padding(.trailing, 4)
                            
                            Text("查看购物车")
                                .fontWeight(.semibold)
                            
                            Spacer()
                            
                            Text("$\(String(format: "%.2f", cartManager.total))")
                                .fontWeight(.bold)
                        }
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                        .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                        .padding()
                    }
                }
            }
            .ignoresSafeArea(edges: .bottom)
        }
        .accentColor(.blue)
    }
}

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack {
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)
            
            TextField("搜索菜品", text: $text)
                .foregroundColor(.primary)
            
            if !text.isEmpty {
                Button(action: {
                    text = ""
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
            }
        }
        .padding(8)
        .background(Color(.systemGray6))
        .cornerRadius(10)
    }
}

struct CategoryButton: View {
    let title: String
    let isSelected: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(title)
                .fontWeight(isSelected ? .bold : .regular)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
                .background(isSelected ? Color.blue : Color(.systemGray6))
                .foregroundColor(isSelected ? .white : .primary)
                .cornerRadius(20)
        }
    }
}

// 自定义菜品视图
struct CustomDishView: View {
    @ObservedObject var cartManager: CartManager
    @Environment(\.presentationMode) var presentationMode
    
    @State private var dishName = ""
    @State private var price = ""
    @State private var quantity = 1
    @State private var notes = ""
    @State private var saveToCustom = true
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("自定义菜品信息")) {
                    TextField("菜品名称", text: $dishName)
                        .disableAutocorrection(true)
                    
                    TextField("价格($)", text: $price)
                        .keyboardType(.decimalPad)
                    
                    Stepper(value: $quantity, in: 1...99) {
                        Text("数量: \(quantity)")
                    }
                    
                    TextField("备注", text: $notes)
                        .disableAutocorrection(true)
                }
                
                Section {
                    Toggle("保存到自定义菜品列表", isOn: $saveToCustom)
                        .foregroundColor(.secondary)
                }
                
                Section {
                    Button(action: {
                        let dishPrice = Double(price) ?? 0.0
                        cartManager.addCustomDish(
                            name: dishName,
                            price: dishPrice,
                            quantity: quantity,
                            notes: notes,
                            saveToCustom: saveToCustom
                        )
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("添加到购物车")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.blue)
                    }
                    .disabled(dishName.isEmpty || price.isEmpty || Double(price) == nil)
                }
            }
            .navigationBarTitle("添加自定义菜品", displayMode: .inline)
            .navigationBarItems(trailing: Button("取消") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

// 自定义菜品行项目
struct CustomDishItemRow: View {
    let item: MenuItem
    @ObservedObject var cartManager: CartManager
    @State private var showingEditSheet = false
    @State private var confirmDelete = false
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.name)
                    .font(.headline)
                
                Text(item.displayPrice)
                    .foregroundColor(.blue)
                    .font(.subheadline)
            }
            
            Spacer()
            
            // 添加按钮
            Button(action: {
                cartManager.addItem(menuItem: item)
            }) {
                Text("添加")
                    .font(.subheadline)
                    .padding(.vertical, 6)
                    .padding(.horizontal, 12)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
            }
            
            // 编辑按钮
            Button(action: {
                showingEditSheet = true
            }) {
                Image(systemName: "pencil")
                    .font(.body)
                    .foregroundColor(.gray)
                    .padding(8)
            }
            
            // 删除按钮
            Button(action: {
                confirmDelete = true
            }) {
                Image(systemName: "trash")
                    .font(.body)
                    .foregroundColor(.red)
                    .padding(8)
            }
        }
        .padding()
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color(.systemGray4).opacity(0.3), radius: 4, x: 0, y: 2)
        .sheet(isPresented: $showingEditSheet) {
            EditCustomDishView(cartManager: cartManager, dish: item)
        }
        .alert(isPresented: $confirmDelete) {
            Alert(
                title: Text("确认删除"),
                message: Text("确定要删除\"\(item.name)\"吗？此操作不可撤销。"),
                primaryButton: .destructive(Text("删除")) {
                    cartManager.removeCustomDish(dish: item)
                },
                secondaryButton: .cancel(Text("取消"))
            )
        }
    }
}

// 编辑自定义菜品视图
struct EditCustomDishView: View {
    @ObservedObject var cartManager: CartManager
    let dish: MenuItem
    @Environment(\.presentationMode) var presentationMode
    
    @State private var dishName: String
    @State private var price: String
    
    init(cartManager: CartManager, dish: MenuItem) {
        self.cartManager = cartManager
        self.dish = dish
        self._dishName = State(initialValue: dish.name)
        self._price = State(initialValue: String(format: "%.2f", dish.primaryPrice))
    }
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("编辑自定义菜品")) {
                    TextField("菜品名称", text: $dishName)
                        .disableAutocorrection(true)
                    
                    TextField("价格($)", text: $price)
                        .keyboardType(.decimalPad)
                }
                
                Section {
                    Button(action: {
                        let dishPrice = Double(price) ?? 0.0
                        
                        // 移除旧菜品
                        cartManager.removeCustomDish(dish: dish)
                        
                        // 添加更新后的菜品
                        cartManager.addCustomDish(
                            name: dishName,
                            price: dishPrice,
                            quantity: 0, // 不添加到购物车
                            saveToCustom: true
                        )
                        
                        presentationMode.wrappedValue.dismiss()
                    }) {
                        Text("保存修改")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.blue)
                    }
                    .disabled(dishName.isEmpty || price.isEmpty || Double(price) == nil)
                }
            }
            .navigationBarTitle("编辑菜品", displayMode: .inline)
            .navigationBarItems(trailing: Button("取消") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
} 