import SwiftUI

struct MenuItemCard: View {
    let menuItem: MenuItem
    let addAction: () -> Void
    
    var body: some View {
        Button(action: addAction) {
            VStack(alignment: .leading, spacing: 8) {
                // Image placeholder - using system icon instead of actual images
                // This makes the app work without requiring all image assets
                ZStack {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .aspectRatio(1.5, contentMode: .fit)
                        .cornerRadius(8)
                    
                    // Use system icon as placeholder instead of trying to load potentially missing images
                    Image(systemName: "fork.knife")
                        .font(.largeTitle)
                        .foregroundColor(.gray)
                        .overlay(
                            Text(menuItem.name.prefix(1))
                                .font(.headline)
                                .foregroundColor(.white)
                                .padding(4)
                                .background(Circle().fill(Color.blue))
                                .offset(x: 0, y: 10)
                        )
                }
                
                VStack(alignment: .leading, spacing: 4) {
                    Text(menuItem.name)
                        .font(.headline)
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Text("$\(String(format: "%.2f", menuItem.price))")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                
                Spacer()
                
                Button(action: addAction) {
                    HStack {
                        Image(systemName: "plus.circle.fill")
                        Text("添加")
                    }
                    .font(.subheadline)
                    .padding(6)
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                }
                .frame(maxWidth: .infinity, alignment: .trailing)
            }
            .padding(12)
            .background(Color(.systemBackground))
            .cornerRadius(12)
            .shadow(color: Color(.systemGray4).opacity(0.3), radius: 4, x: 0, y: 2)
        }
        .buttonStyle(PlainButtonStyle())
    }
} 