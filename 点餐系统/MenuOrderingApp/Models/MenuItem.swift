import Foundation

struct MenuItem: Identifiable {
    let id: String
    let code: String
    let name: String
    let price: Double
    let category: Category
    let imageURL: String
    let description: String
    
    enum Category: String, CaseIterable, Identifiable {
        case appetizer = "前菜"
        case beef = "牛肉"
        case chicken = "鸡肉"
        case seafood = "海鲜"
        case vegetable = "蔬菜"
        case noodle = "面食"
        case sweetSour = "酸甜"
        case combo = "套餐"
        case beverage = "饮料"
        case extra = "额外"
        
        var id: String { self.rawValue }
    }
} 