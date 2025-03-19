import SwiftUI

struct MenuItemCard: View {
    let menuItem: MenuItem
    let addAction: () -> Void
    @State private var showingItemDetails = false
    
    var body: some View {
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
                    ComboDetailsView(menuItem: menuItem)
                }
            }
            
            Spacer()
            
            // 添加按钮
            Button(action: addAction) {
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
    }
}

// 套餐详情弹窗
struct ComboDetailsView: View {
    let menuItem: MenuItem
    @Environment(\.presentationMode) var presentationMode
    
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
                            }
                            .padding(.vertical, 4)
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
    }
} 