import SwiftUI

struct MenuItemCard: View {
    let menuItem: MenuItem
    let addAction: () -> Void
    
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            // 菜品代码
            Text(menuItem.code)
                .font(.caption)
                .foregroundColor(.gray)
            
            // 菜品名称 - 增加显示空间
            Text(menuItem.name)
                .font(.headline)
                .foregroundColor(.primary)
                .lineLimit(3)
                .fixedSize(horizontal: false, vertical: true)
            
            // 价格
            Text("$\(String(format: "%.2f", menuItem.price))")
                .font(.subheadline)
                .foregroundColor(.blue)
                .padding(.bottom, 2)
            
            // 添加按钮 - 独立成单独的元素
            Button(action: addAction) {
                HStack {
                    Image(systemName: "plus.circle.fill")
                    Text("添加")
                }
                .font(.subheadline)
                .padding(.vertical, 6)
                .padding(.horizontal, 12)
                .frame(minWidth: 80)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(8)
            }
            .frame(maxWidth: .infinity, alignment: .center)
            .padding(.top, 2)
        }
        .padding(10)
        .frame(height: 140)
        .background(Color(.systemBackground))
        .cornerRadius(12)
        .shadow(color: Color(.systemGray4).opacity(0.3), radius: 4, x: 0, y: 2)
    }
} 