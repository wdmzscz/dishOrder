import SwiftUI

struct CartView: View {
    @ObservedObject var cartManager: CartManager
    @ObservedObject var orderManager: OrderManager
    @Environment(\.presentationMode) var presentationMode
    @State private var isCheckingOut = false
    @State private var showingConfirmation = false
    @State private var showTableSelector = false
    @State private var showAddExtraCharge = false
    @State private var extraChargeAmount = ""
    @State private var extraChargeReason = ""
    
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
                        
                        // 显示补差价总额 - 改为计算属性以确保实时更新
                        let totalExtraCharge = cartManager.calculateTotalExtraCharge()
                        if totalExtraCharge != 0 {
                            HStack {
                                if totalExtraCharge > 0 {
                                    Text("补差价总额")
                                        .foregroundColor(.orange)
                                    Spacer()
                                    Text("+$\(String(format: "%.2f", totalExtraCharge))")
                                        .foregroundColor(.red)
                                } else {
                                    Text("减价总额")
                                        .foregroundColor(.green)
                                    Spacer()
                                    Text("-$\(String(format: "%.2f", abs(totalExtraCharge)))")
                                        .foregroundColor(.green)
                                }
                            }
                        }
                        
                        Button(action: {
                            showAddExtraCharge = true
                        }) {
                            HStack {
                                Image(systemName: "dollarsign.circle.fill")
                                Text("调整整单价格")
                                Spacer()
                                Image(systemName: "chevron.right")
                            }
                            .padding(12)
                            .background(Color.orange.opacity(0.1))
                            .foregroundColor(.orange)
                            .cornerRadius(8)
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
                TableSelector(tableNumber: $cartManager.tableNumber)
            }
            .sheet(isPresented: $showAddExtraCharge) {
                GlobalExtraChargeView(
                    cartManager: cartManager,
                    extraChargeAmount: $extraChargeAmount,
                    extraChargeReason: $extraChargeReason
                )
            }
            .alert(isPresented: $showingConfirmation) {
                Alert(
                    title: Text("确认订单"),
                    message: Text("餐桌号: \(cartManager.tableNumber.formatted)\n总价: $\(String(format: "%.2f", cartManager.total))"),
                    primaryButton: .default(Text("确认")) {
                        orderManager.addOrder(from: cartManager)
                        cartManager.clearCart()
                        presentationMode.wrappedValue.dismiss()

                        // 强制刷新视图
                        cartManager.objectWillChange.send()
                    },
                    secondaryButton: .cancel(Text("取消")) {
                        isCheckingOut = false
                    }
                )
            }
        }
    }
}

// 整单补差价视图
struct GlobalExtraChargeView: View {
    @ObservedObject var cartManager: CartManager
    @Binding var extraChargeAmount: String
    @Binding var extraChargeReason: String
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("调整价格")) {
                    TextField("金额 (正数加价/负数减价)", text: $extraChargeAmount)
                        .keyboardType(.decimalPad)
                    
                    HStack {
                        Button(action: {
                            if let current = Double(extraChargeAmount) {
                                extraChargeAmount = String(format: "%.2f", -current)
                            }
                        }) {
                            Text("正负切换")
                                .font(.caption)
                                .padding(.vertical, 6)
                                .padding(.horizontal, 10)
                                .background(Color.blue.opacity(0.1))
                                .foregroundColor(.blue)
                                .cornerRadius(8)
                        }
                        
                        Spacer()
                        
                        Text("提示: 正数表示加价，负数表示减价")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding(.top, 4)
                    
                    TextField("原因说明", text: $extraChargeReason)
                        .disableAutocorrection(true)
                }
                
                Section {
                    Button(action: {
                        if let amount = Double(extraChargeAmount), amount != 0 {
                            // 创建一个虚拟菜品用于价格调整
                            let name = amount > 0 ? "整单补差价" : "整单减价"
                            
                            let customItem = MenuItem(
                                id: UUID().uuidString,
                                code: "EXTRA",
                                name: name,
                                price: .fixed(0.0),  // 设置价格为0，只通过extraCharge计算
                                category: .custom,
                                subcategory: nil,
                                description: amount > 0 ? "整单补差价" : "整单减价",
                                items: nil,
                                isSpicy: false
                            )
                            
                            // 添加到购物车
                            cartManager.addItem(
                                menuItem: customItem, 
                                notes: extraChargeReason.isEmpty ? (amount > 0 ? "补差价" : "减价") : extraChargeReason,
                                extraCharge: amount,
                                substitution: amount > 0 ? "补差价" : "减价"
                            )
                            
                            // 重置字段
                            extraChargeAmount = ""
                            extraChargeReason = ""
                            
                            // 关闭视图
                            presentationMode.wrappedValue.dismiss()

                            // 强制刷新视图
                            cartManager.objectWillChange.send()
                        }
                    }) {
                        Text("确认调整")
                            .frame(maxWidth: .infinity, alignment: .center)
                            .foregroundColor(.blue)
                    }
                    .disabled(Double(extraChargeAmount) == nil || Double(extraChargeAmount) ?? 0 == 0)
                }
            }
            .navigationBarTitle("调整整单价格", displayMode: .inline)
            .navigationBarItems(trailing: Button("取消") {
                presentationMode.wrappedValue.dismiss()
            })
        }
    }
}

// 桌号选择器
struct TableSelector: View {
    @Binding var tableNumber: TableNumber
    @Environment(\.presentationMode) var presentationMode
    
    @State private var selectedArea = "A"
    @State private var selectedNumber = 1
    @State private var showingCustomTableName = false
    @State private var customTableName = ""
    
    // 可用的区域和对应的桌号范围
    let availableAreas = ["A", "B", "C"]
    let numberRanges = [
        "A": 1...10,
        "B": 1...15,
        "C": 1...8
    ]
    
    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                // 自定义桌号选项
                Toggle("使用自定义桌号", isOn: $showingCustomTableName)
                    .padding(.horizontal)
                
                if showingCustomTableName {
                    // 自定义桌号输入
                    VStack(alignment: .leading, spacing: 10) {
                        Text("输入自定义桌号:")
                            .font(.headline)
                        
                        TextField("例如: A1-B2拼桌", text: $customTableName)
                            .textFieldStyle(RoundedBorderTextFieldStyle())
                            .disableAutocorrection(true)
                            .padding(.horizontal)
                        
                        Text("提示: 自定义桌号适用于拼桌等特殊情况")
                            .font(.caption)
                            .foregroundColor(.gray)
                            .padding(.horizontal)
                    }
                    .padding(.horizontal)
                } else {
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
                }
                
                Spacer()
            }
            .padding(.top, 20)
            .navigationBarTitle("选择餐桌", displayMode: .inline)
            .navigationBarItems(
                leading: Button("取消") {
                    presentationMode.wrappedValue.dismiss()
                },
                trailing: Button("确定") {
                    if showingCustomTableName {
                        var newTableNumber = TableNumber(area: "X", number: 0)
                        newTableNumber.customName = customTableName
                        tableNumber = newTableNumber
                    } else {
                        tableNumber = TableNumber(area: selectedArea, number: selectedNumber)
                    }
                    presentationMode.wrappedValue.dismiss()
                }
                .disabled(showingCustomTableName && customTableName.isEmpty)
            )
            .onAppear {
                // 初始化已有的桌号或自定义桌号
                if !tableNumber.customName.isEmpty {
                    customTableName = tableNumber.customName
                    showingCustomTableName = true
                } else {
                    selectedArea = tableNumber.area
                    selectedNumber = tableNumber.number
                    showingCustomTableName = false
                }
            }
            // 当区域变化时，确保桌号在有效范围内
            .onChange(of: selectedArea) { oldArea, newArea in
                if let range = numberRanges[newArea], !range.contains(selectedNumber) {
                    selectedNumber = range.lowerBound
                }
            }
        }
    }
} 