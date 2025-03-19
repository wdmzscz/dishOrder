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
                                Text(cartManager.tableNumber.formatted)
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
                    message: Text("餐桌号: \(cartManager.tableNumber.formatted)\n总价: $\(String(format: "%.2f", cartManager.total))"),
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
    @Binding var tableNumber: TableNumber
    @Environment(\.presentationMode) var presentationMode
    @State private var selectedArea: String
    @State private var selectedNumber: Int
    
    // 可用的区域和对应的桌号范围
    let availableAreas = ["A", "B", "C"]
    let numberRanges = [
        "A": 1...4,
        "B": 1...4,
        "C": 1...5
    ]
    
    init(tableNumber: Binding<TableNumber>) {
        self._tableNumber = tableNumber
        self._selectedArea = State(initialValue: tableNumber.wrappedValue.area)
        self._selectedNumber = State(initialValue: tableNumber.wrappedValue.number)
    }
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 区域选择
                Section(header: Text("选择区域").font(.headline)) {
                    Picker("区域", selection: $selectedArea) {
                        ForEach(availableAreas, id: \.self) { area in
                            Text("区域 \(area)").tag(area)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding(.horizontal)
                }
                
                // 桌号选择
                Section(header: Text("选择桌号").font(.headline)) {
                    Picker("桌号", selection: $selectedNumber) {
                        ForEach(Array(numberRanges[selectedArea] ?? 1...5), id: \.self) { number in
                            Text("\(number)").tag(number)
                        }
                    }
                    .pickerStyle(WheelPickerStyle())
                }
                
                // 预览选择的餐桌号
                Text("当前选择: \(selectedArea)\(selectedNumber)")
                    .font(.title2)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                
                Spacer()
            }
            .padding(.top, 20)
            .navigationBarTitle("选择餐桌", displayMode: .inline)
            .navigationBarItems(
                leading: Button("取消") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("确定") {
                    tableNumber = TableNumber(area: selectedArea, number: selectedNumber)
                    presentationMode.wrappedValue.dismiss()
                }
            )
            // 当区域变化时，确保桌号在有效范围内
            .onChange(of: selectedArea) { newArea in
                if let range = numberRanges[newArea], !range.contains(selectedNumber) {
                    selectedNumber = range.lowerBound
                }
            }
        }
    }
} 