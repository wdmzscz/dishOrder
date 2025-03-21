import Foundation

struct MenuItem: Identifiable {
    let id: String
    let code: String
    let name: String
    let price: Price
    let category: Category
    let subcategory: String?
    let description: String
    let items: [String]?  // 用于套餐中包含的项目列表
    let isSpicy: Bool
    
    enum Category: String, CaseIterable, Identifiable {
        case appetizer = "Appetizers"
        case soup = "Soups"
        case chopSuey = "Chop Suey"
        case eggFooYoung = "Egg Foo Young"
        case vegetable = "Vegetables"
        case beef = "Beef"
        case chicken = "Chicken"
        case seafood = "Seafood"
        case sweetAndSour = "Sweet and Sour Pork and Ribs"
        case noodle = "Fried Noodle"
        case rice = "Fried Rice"
        case chefSuggestion = "Chef's Suggestions"
        case familyDinner = "Family Dinners"
        case authenticDinner = "Authentic Chinese Style Dinners"
        case combinationDinner = "Combination Dinner for One"
        case deluxeDinner = "Deluxe Dinners"
        case custom = "Custom Dishes"
        
        // Chinese display name for each category
        var displayName: String {
            switch self {
            case .appetizer: return "开胃菜"
            case .soup: return "汤类"
            case .chopSuey: return "炒杂菜"
            case .eggFooYoung: return "芙蓉蛋"
            case .vegetable: return "蔬菜"
            case .beef: return "牛肉"
            case .chicken: return "鸡肉"
            case .seafood: return "海鲜"
            case .sweetAndSour: return "酸甜类"
            case .noodle: return "炒面"
            case .rice: return "炒饭"
            case .chefSuggestion: return "厨师推荐"
            case .familyDinner: return "家庭套餐"
            case .authenticDinner: return "正宗中餐"
            case .combinationDinner: return "单人套餐"
            case .deluxeDinner: return "豪华套餐"
            case .custom: return "自定义菜品"
            }
        }
        
        var id: String { self.rawValue }
    }
    
    // 支持不同价格类型：固定价格或多个价格选项
    enum Price {
        case fixed(Double)
        case options([String: Double])
        
        var displayPrice: String {
            switch self {
            case .fixed(let price):
                return String(format: "$%.2f", price)
            case .options(let options):
                if options.count == 1, let price = options.values.first {
                    return String(format: "$%.2f", price)
                } else if options.isEmpty {
                    return "价格待定"
                } else {
                    // 当有多个价格选项时，显示价格范围
                    let sortedPrices = options.values.sorted()
                    if let minPrice = sortedPrices.first, let maxPrice = sortedPrices.last, minPrice != maxPrice {
                        return String(format: "$%.2f - $%.2f", minPrice, maxPrice)
                    } else if let price = sortedPrices.first {
                        return String(format: "$%.2f", price)
                    } else {
                        return "价格待定"
                    }
                }
            }
        }
        
        var primaryPrice: Double {
            switch self {
            case .fixed(let price):
                return price
            case .options(let options):
                if let price = options.values.first {
                    return price
                } else {
                    return 0.0
                }
            }
        }
        
        // 返回价格选项列表
        var priceOptions: [(key: String, value: Double)] {
            switch self {
            case .fixed(let price):
                return [("标准", price)]
            case .options(let options):
                return options.map { (key: $0.key, value: $0.value) }.sorted(by: { $0.value < $1.value })
            }
        }
    }
    
    // 用于显示的价格
    var displayPrice: String {
        return price.displayPrice
    }
    
    // 用于排序和计算的价格
    var primaryPrice: Double {
        return price.primaryPrice
    }
    
    // 用于标识该项是否为子项目
    var isSubItem: Bool {
        return subcategory != nil
    }
} 