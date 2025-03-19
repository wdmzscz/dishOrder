import SwiftUI

struct CartItemRow: View {
    @ObservedObject var cartManager: CartManager
    let item: CartItem
    @State private var showingNotesEditor = false
    @State private var notes: String
    
    init(cartManager: CartManager, item: CartItem) {
        self.cartManager = cartManager
        self.item = item
        self._notes = State(initialValue: item.notes)
    }
    
    var body: some View {
        HStack(alignment: .top, spacing: 12) {
            // Item information
            VStack(alignment: .leading, spacing: 4) {
                Text(item.menuItem.name)
                    .font(.headline)
                
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
            
            // Quantity controls
            HStack(spacing: 8) {
                Button(action: {
                    if item.quantity > 1 {
                        cartManager.updateItemQuantity(item: item, quantity: item.quantity - 1)
                    }
                }) {
                    Image(systemName: "minus.circle.fill")
                        .font(.title3)
                        .foregroundColor(.blue)
                }
                
                Text("\(item.quantity)")
                    .font(.headline)
                    .frame(minWidth: 30)
                
                Button(action: {
                    cartManager.updateItemQuantity(item: item, quantity: item.quantity + 1)
                }) {
                    Image(systemName: "plus.circle.fill")
                        .font(.title3)
                        .foregroundColor(.blue)
                }
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
    }
} 