import SwiftUI

struct MenuView: View {
    @ObservedObject var cartManager: CartManager
    @ObservedObject var orderManager: OrderManager
    @State private var searchText = ""
    @State private var selectedCategory: MenuItem.Category? = nil
    @State private var showingCart = false
    @State private var showingTableSelector = false
    
    private var filteredItems: [MenuItem] {
        let items = MenuItem.sampleItems
        
        // Filter by search text
        let searchFiltered = searchText.isEmpty ? items : items.filter {
            $0.name.lowercased().contains(searchText.lowercased()) || 
            $0.code.lowercased().contains(searchText.lowercased())
        }
        
        // Filter by category
        if let category = selectedCategory {
            return searchFiltered.filter { $0.category == category }
        } else {
            return searchFiltered
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
                                title: category.rawValue,
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
                        // Show as a grid if filtered by category
                        ScrollView {
                            LazyVGrid(columns: [
                                GridItem(.flexible()),
                                GridItem(.flexible()),
                                GridItem(.flexible())
                            ], spacing: 16) {
                                ForEach(filteredItems) { item in
                                    MenuItemCard(menuItem: item) {
                                        cartManager.addItem(menuItem: item)
                                    }
                                }
                            }
                            .padding()
                            // Add extra padding at bottom for cart button
                            .padding(.bottom, 80)
                        }
                    } else {
                        // Show as sections by category if no category filter
                        ScrollView {
                            VStack(alignment: .leading, spacing: 16) {
                                ForEach(MenuItem.Category.allCases) { category in
                                    if let items = groupedItems[category], !items.isEmpty {
                                        VStack(alignment: .leading, spacing: 8) {
                                            Text(category.rawValue)
                                                .font(.title2)
                                                .fontWeight(.bold)
                                                .padding(.horizontal)
                                            
                                            ScrollView(.horizontal, showsIndicators: false) {
                                                HStack(spacing: 16) {
                                                    ForEach(items) { item in
                                                        MenuItemCard(menuItem: item) {
                                                            cartManager.addItem(menuItem: item)
                                                        }
                                                        .frame(width: 180)
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
                        showingTableSelector = true
                    }) {
                        HStack {
                            Text("餐桌 #\(cartManager.tableNumber)")
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
                TableSelectorView(tableNumber: $cartManager.tableNumber)
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