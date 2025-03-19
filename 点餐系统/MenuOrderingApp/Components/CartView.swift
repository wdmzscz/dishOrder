import SwiftUI

struct CartView: View {
    @ObservedObject var cartManager: CartManager
    @ObservedObject var orderManager: OrderManager
    @Environment(\.presentationMode) var presentationMode
    @State private var isCheckingOut = false
    @State private var showingConfirmation = false
    @State private var showTableSelector = false
    
    var body: some View {
        NavigationView {
            VStack {
                if cartManager.items.isEmpty {
                    Spacer()
                    Text("购物车为空")
                        .font(.title)
                        .foregroundColor(.gray)
                    Spacer()
                } else {
                    List {
                        ForEach(cartManager.items) { item in
                            CartItemRow(cartManager: cartManager, item: item)
                        }
                    }
                    .listStyle(InsetGroupedListStyle())
                    
                    VStack(spacing: 16) {
                        HStack {
                            Text("餐桌号")
                                .font(.headline)
                            
                            Spacer()
                            
                            HStack {
                                Text("\(cartManager.tableNumber)")
                                    .font(.headline)
                                
                                Button(action: {
                                    showTableSelector = true
                                }) {
                                    Image(systemName: "pencil.circle.fill")
                                        .foregroundColor(.blue)
                                }
                            }
                        }
                        
                        Divider()
                        
                        HStack {
                            Text("小计")
                            Spacer()
                            Text("$\(String(format: "%.2f", cartManager.subtotal))")
                        }
                        
                        HStack {
                            Text("税金 (13%)")
                            Spacer()
                            Text("$\(String(format: "%.2f", cartManager.taxAmount))")
                        }
                        
                        HStack {
                            Text("总计")
                                .font(.headline)
                            Spacer()
                            Text("$\(String(format: "%.2f", cartManager.total))")
                                .font(.headline)
                        }
                        
                        Button(action: {
                            isCheckingOut = true
                            showingConfirmation = true
                        }) {
                            Text("提交订单")
                                .font(.headline)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .disabled(isCheckingOut)
                    }
                    .padding()
                    .background(Color(.systemBackground))
                }
            }
            .navigationBarTitle("购物车", displayMode: .inline)
            .navigationBarItems(
                leading: Button("关闭") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
            .sheet(isPresented: $showTableSelector) {
                TableSelectorView(tableNumber: $cartManager.tableNumber)
            }
            .alert(isPresented: $showingConfirmation) {
                Alert(
                    title: Text("确认订单"),
                    message: Text("餐桌号: \(cartManager.tableNumber)\n总价: $\(String(format: "%.2f", cartManager.total))"),
                    primaryButton: .default(Text("确认")) {
                        orderManager.addOrder(from: cartManager)
                        cartManager.clearCart()
                        presentationMode.wrappedValue.dismiss()
                    },
                    secondaryButton: .cancel(Text("取消")) {
                        isCheckingOut = false
                    }
                )
            }
        }
    }
}

struct TableSelectorView: View {
    @Binding var tableNumber: Int
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedTable: Int
    
    init(tableNumber: Binding<Int>) {
        self._tableNumber = tableNumber
        self._selectedTable = State(initialValue: tableNumber.wrappedValue)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Picker("餐桌号", selection: $selectedTable) {
                    ForEach(1...30, id: \.self) { number in
                        Text("\(number)").tag(number)
                    }
                }
                .pickerStyle(WheelPickerStyle())
                
                Spacer()
            }
            .navigationBarTitle("选择餐桌", displayMode: .inline)
            .navigationBarItems(
                leading: Button("取消") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("确定") {
                    tableNumber = selectedTable
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
} 