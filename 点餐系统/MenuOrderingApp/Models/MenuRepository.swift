import Foundation

class MenuRepository {
    // 菜单数据
    static let shared = MenuRepository()
    
    var allItems: [MenuItem] = [
        // Family Dinners
        MenuItem(id: "FD01", code: "FD01", name: "Dinner for 2", price: .fixed(21.95), category: .familyDinner, subcategory: nil, description: "Family dinner meal for 2 people", items: ["Wonton Soup - Egg Rolls", "Chicken Chop Suey - Sweet & Sour Chicken Balls", "Chicken Fried Rice & Cookies"], isSpicy: false),
        
        MenuItem(id: "FD02", code: "FD02", name: "Dinner for 3", price: .fixed(46.95), category: .familyDinner, subcategory: nil, description: "Family dinner meal for 3 people", items: ["Wonton Soup - Egg Rolls", "Chicken Chop Suey - Sweet & Sour Chicken Balls", "Beef with Mixed Vegetables", "Chicken Fried Rice & Cookies"], isSpicy: false),
        
        MenuItem(id: "FD03", code: "FD03", name: "Dinner for 4", price: .fixed(59.95), category: .familyDinner, subcategory: nil, description: "Family dinner meal for 4 people", items: ["Wonton Soup - Egg Rolls", "Breaded Shrimp - Chicken Chop Suey", "Beef with Mixed Vegetables", "Sweet & Sour Chicken Balls", "Chicken Fried Rice & Cookies"], isSpicy: false),
        
        MenuItem(id: "FD04", code: "FD04", name: "Dinner for 5", price: .fixed(74.95), category: .familyDinner, subcategory: nil, description: "Family dinner meal for 5 people", items: ["Wonton Soup - Egg Rolls", "Breaded Shrimp - Chicken Chow Mein", "Beef with Mixed Vegetables", "Sweet & Sour Chicken Balls - Chicken Lo Mein", "Chicken Fried Rice & Cookies"], isSpicy: false),
        
        MenuItem(id: "FD05", code: "FD05", name: "Dinner for 6", price: .fixed(87.95), category: .familyDinner, subcategory: nil, description: "Family dinner meal for 6 people", items: ["Wonton Soup - Egg Rolls", "Breaded Shrimp - Beef Chop Suey", "Chicken Chow Mein - Honey Garlic Spareribs", "Sweet & Sour Chicken Balls - Cantonese Lo Mein", "Chicken Fried Rice & Cookies"], isSpicy: false),
        
        // Authentic Chinese Style Dinners
        MenuItem(id: "AD01", code: "AD01", name: "Group Dinner for 2", price: .fixed(35.95), category: .authenticDinner, subcategory: nil, description: "Authentic Chinese style dinner for 2 people", items: ["2 Wonton Soup, 2 Spring Rolls", "Beef with Mixed Vegetables", "Sweet & Sour Chicken (Hong Kong Style)", "Chicken Fried Rice & Cookies"], isSpicy: false),
        
        MenuItem(id: "AD02", code: "AD02", name: "Group Dinner for 3", price: .fixed(52.95), category: .authenticDinner, subcategory: nil, description: "Authentic Chinese style dinner for 3 people", items: ["3 Wonton Soup, 3 Spring Rolls", "Sweet & Sour Chicken (Hong Kong Style)", "Lemon Chicken", "Beef with Vegetables", "Chicken Fried Rice & Cookies"], isSpicy: false),
        
        MenuItem(id: "AD03", code: "AD03", name: "Group Dinner for 4", price: .fixed(66.95), category: .authenticDinner, subcategory: nil, description: "Authentic Chinese style dinner for 4 people", items: ["4 Wonton Soup, 4 Spring Rolls", "Emperor Beef with Bean Sauce", "Sweet & Sour Chicken (Hong Kong Style)", "Lemon Chicken", "Shrimp with Vegetables", "Chicken Fried Rice & Cookies"], isSpicy: false),
        
        MenuItem(id: "AD04", code: "AD04", name: "Group Dinner for 6", price: .fixed(97.95), category: .authenticDinner, subcategory: nil, description: "Authentic Chinese style dinner for 6 people", items: ["6 Wonton Soup, 6 Spring Rolls", "Emperor Beef with Bean Sauce", "Sweet & Sour Chicken (Hong Kong Style)", "Lemon Chicken", "Shrimp with Vegetables", "Singapore Noodles (spicy)", "Spicy Potatoes (spicy)", "Chicken Fried Rice & Cookies"], isSpicy: true),
        
        // Combination Dinner for One
        MenuItem(id: "CD01", code: "CD01", name: "No. 1: Sweet & Sour Chicken Ball & Chicken Chop Suey", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD02", code: "CD02", name: "No. 2: Chicken Chow Mein & Chicken Chop Suey", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD03", code: "CD03", name: "No. 3: Sweet & Sour Chicken Ball", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD04", code: "CD04", name: "No. 4: Chicken Chow Mein", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD05", code: "CD05", name: "No. 5: Sweet & Sour Breaded Shrimp & Chicken Ball", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD06", code: "CD06", name: "No. 6: Chicken or Beef w/ Black Bean Sauce", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD07", code: "CD07", name: "No. 7: Diced Chicken with Almond", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD08", code: "CD08", name: "No. 8: Chicken or Beef w/ Mixed Vegetables", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD09", code: "CD09", name: "No. 9: Sweet & Sour Pork (Hong Kong Style)", price: .fixed(15.95), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD10", code: "CD10", name: "No. 10: Sweet & Sour Chicken (Hong Kong Style)", price: .fixed(15.95), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD11", code: "CD11", name: "No. 11: Lemon Chicken", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD12", code: "CD12", name: "No. 12: Sweet & Sour Chicken Ball & Chicken Chow Mein", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD13", code: "CD13", name: "No. 13: Vegetable Chop Suey", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD14", code: "CD14", name: "No. 14: Chicken or Beef Chop Suey", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD15", code: "CD15", name: "No. 15: Sweet & Sour Breaded Shrimp", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD16", code: "CD16", name: "No. 16: Dry Garlic Ribs & Beef Chop Suey", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD17", code: "CD17", name: "No. 17: Szechuan Chicken or Beef (spicy)", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: true),
        
        MenuItem(id: "CD18", code: "CD18", name: "No. 18: Honey Garlic Spareribs", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD19", code: "CD19", name: "No. 19: Sesame Chicken", price: .fixed(15.95), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: false),
        
        MenuItem(id: "CD20", code: "CD20", name: "No. 20: General Tao's Chicken (spicy)", price: .fixed(15.95), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: true),
        
        MenuItem(id: "CD21", code: "CD21", name: "No. 21: Crispy Spicy Ginger Beef (spicy)", price: .fixed(15.95), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: true),
        
        MenuItem(id: "CD22", code: "CD22", name: "No. 22: Spicy Green Bean (spicy)", price: .fixed(14.45), category: .combinationDinner, subcategory: nil, description: "Served with Egg Roll and Chicken Fried Rice", items: nil, isSpicy: true),
        
        // Deluxe Dinners
        MenuItem(id: "DD01", code: "DD01", name: "Deluxe Dinner for 2", price: .fixed(35.95), category: .deluxeDinner, subcategory: nil, description: "Deluxe dinner meal for 2 people", items: ["Wonton Soup, Egg Rolls", "Chicken Chow Mein - Beef With Mixed Vegetables", "Sweet & Sour Chicken Balls", "Chicken Fried Rice & Cookies"], isSpicy: false),
        
        MenuItem(id: "DD02", code: "DD02", name: "Deluxe Dinner for 3", price: .fixed(52.95), category: .deluxeDinner, subcategory: nil, description: "Deluxe dinner meal for 3 people", items: ["Wonton Soup, Egg Rolls", "Dry Garlic Spareribs - General Tao's Chicken (spicy)", "Beef with Mixed Vegetables", "Chicken Fried Rice & Cookies"], isSpicy: true),
        
        MenuItem(id: "DD03", code: "DD03", name: "Deluxe Dinner for 4", price: .fixed(66.95), category: .deluxeDinner, subcategory: nil, description: "Deluxe dinner meal for 4 people", items: ["Wonton Soup, Egg Rolls", "Dry Garlic Spareribs - General Tao's Chicken (spicy)", "Beef w/ Mixed Vegetables - Szechuan Shrimp (spicy)", "Chicken Fried Rice & Cookies"], isSpicy: true),
        
        MenuItem(id: "DD04", code: "DD04", name: "Deluxe Dinner for 6", price: .fixed(97.95), category: .deluxeDinner, subcategory: nil, description: "Deluxe dinner meal for 6 people", items: ["Wonton Soup, Egg Rolls", "Dry Garlic Spareribs - General Tao's Chicken (spicy)", "Crispy Ginger Beef (spicy) - Beef w/ Mixed Vegetables", "Cantonese Lo Mein - Szechuan Shrimp (spicy)", "Chicken Fried Rice & Cookies"], isSpicy: true),
        
        // Appetizers
        MenuItem(id: "AP01", code: "AP01", name: "Egg Roll", price: .fixed(2.25), category: .appetizer, subcategory: nil, description: "Classic egg roll appetizer", items: nil, isSpicy: false),
        
        MenuItem(id: "AP02", code: "AP02", name: "Spring Roll", price: .fixed(2.25), category: .appetizer, subcategory: nil, description: "Traditional spring roll", items: nil, isSpicy: false),
        
        MenuItem(id: "AP03", code: "AP03", name: "Fried Wonton", price: .options(["9 pieces": 5.25, "14 pieces": 8.75]), category: .appetizer, subcategory: nil, description: "Crispy fried wontons", items: nil, isSpicy: false),
        
        MenuItem(id: "AP04", code: "AP04", name: "Sliced BBQ Pork", price: .fixed(14.95), category: .appetizer, subcategory: nil, description: "Sliced barbecue pork", items: nil, isSpicy: false),
        
        MenuItem(id: "AP05", code: "AP05", name: "Dry Garlic Spareribs", price: .fixed(13.95), category: .appetizer, subcategory: nil, description: "Spareribs with garlic seasoning", items: nil, isSpicy: false),
        
        MenuItem(id: "AP06", code: "AP06", name: "Fried Beef Dumpling", price: .options(["9 pieces": 5.25, "12 pieces": 8.75]), category: .appetizer, subcategory: nil, description: "Fried dumplings with beef filling", items: nil, isSpicy: false),
        
        // Soups
        MenuItem(id: "SP01", code: "SP01", name: "Chicken Corn Soup", price: .options(["pint": 5.25, "quart": 8.25, "bowl": 4.25]), category: .soup, subcategory: nil, description: "Chicken soup with corn", items: nil, isSpicy: false),
        
        MenuItem(id: "SP02", code: "SP02", name: "Chicken Noodle Soup", price: .options(["pint": 6.25, "quart": 8.25, "bowl": 4.25]), category: .soup, subcategory: nil, description: "Classic chicken noodle soup", items: nil, isSpicy: false),
        
        MenuItem(id: "SP03", code: "SP03", name: "Chicken Rice Soup", price: .options(["bowl": 3.95]), category: .soup, subcategory: nil, description: "Chicken soup with rice", items: nil, isSpicy: false),
        
        MenuItem(id: "SP04", code: "SP04", name: "Mixed Vegetables Soup", price: .options(["bowl": 3.25]), category: .soup, subcategory: nil, description: "Vegetable soup", items: nil, isSpicy: false),
        
        MenuItem(id: "SP05", code: "SP05", name: "Egg Drop Soup", price: .options(["bowl": 3.25]), category: .soup, subcategory: nil, description: "Classic egg drop soup", items: nil, isSpicy: false),
        
        MenuItem(id: "SP06", code: "SP06", name: "Hot and Sour Soup", price: .options(["bowl": 4.25, "pint": 8.25, "large": 14.95]), category: .soup, subcategory: nil, description: "Spicy and sour soup", items: nil, isSpicy: true),
        
        MenuItem(id: "SP07", code: "SP07", name: "Wonton Soup", price: .options(["large": 6.25, "bowl": 3.25]), category: .soup, subcategory: nil, description: "Soup with wontons", items: nil, isSpicy: false),
        
        MenuItem(id: "SP08", code: "SP08", name: "War Wonton Soup", price: .options(["large": 13.25, "small": 8.25]), category: .soup, subcategory: nil, description: "Shrimp, BBQ Pork, Chicken & Vegetables", items: nil, isSpicy: false),
        
        // Chop Suey
        MenuItem(id: "CS01", code: "CS01", name: "Beef Chop Suey", price: .fixed(12.95), category: .chopSuey, subcategory: nil, description: "Beef with mixed vegetables", items: nil, isSpicy: false),
        
        // Beef
        MenuItem(id: "BF01", code: "BF01", name: "Beef with Broccoli", price: .fixed(15.95), category: .beef, subcategory: nil, description: "Sliced beef with broccoli", items: nil, isSpicy: false),
        
        MenuItem(id: "BF02", code: "BF02", name: "Beef with Mixed Vegetables", price: .fixed(15.95), category: .beef, subcategory: nil, description: "Beef with mixed vegetables", items: nil, isSpicy: false),
        
        MenuItem(id: "BF03", code: "BF03", name: "Szechuan Beef (Hot)", price: .fixed(15.95), category: .beef, subcategory: nil, description: "Spicy Szechuan style beef", items: nil, isSpicy: true),
        
        // Chicken
        MenuItem(id: "CH01", code: "CH01", name: "Sweet & Sour Chicken Ball", price: .fixed(14.95), category: .chicken, subcategory: nil, description: "Sweet and sour chicken balls", items: nil, isSpicy: false),
        
        MenuItem(id: "CH02", code: "CH02", name: "Chicken Chow Mein", price: .fixed(14.95), category: .chicken, subcategory: nil, description: "Chicken chow mein", items: nil, isSpicy: false),
        
        MenuItem(id: "CH03", code: "CH03", name: "General Tao's Chicken (Hot)", price: .fixed(16.95), category: .chicken, subcategory: nil, description: "Spicy General Tao's chicken", items: nil, isSpicy: true),
        
        // Seafood
        MenuItem(id: "SF01", code: "SF01", name: "Breaded Shrimp with Sweet & Sour Sauce", price: .fixed(16.95), category: .seafood, subcategory: nil, description: "Breaded shrimp with sweet and sour sauce", items: nil, isSpicy: false),
        
        MenuItem(id: "SF02", code: "SF02", name: "Stir Fried Shrimp with Peapods", price: .fixed(17.95), category: .seafood, subcategory: nil, description: "Shrimp stir fried with peapods", items: nil, isSpicy: false),
        
        // Sweet and Sour
        MenuItem(id: "SS01", code: "SS01", name: "Stir Fried Sweet & Sour Chicken", price: .fixed(14.95), category: .sweetAndSour, subcategory: nil, description: "Sweet and sour chicken stir fry", items: nil, isSpicy: false),
        
        // Fried Noodle
        MenuItem(id: "FN01", code: "FN01", name: "Cantonese Chow Mein", price: .fixed(16.95), category: .noodle, subcategory: nil, description: "Cantonese style chow mein", items: nil, isSpicy: false),
        
        // Fried Rice
        MenuItem(id: "FR01", code: "FR01", name: "B.B.Q. Pork or Beef or Chicken Fried Rice", price: .fixed(10.95), category: .rice, subcategory: nil, description: "Fried rice with your choice of protein", items: nil, isSpicy: false),
        
        MenuItem(id: "FR02", code: "FR02", name: "House Special Fried Rice", price: .fixed(12.95), category: .rice, subcategory: nil, description: "House special fried rice", items: nil, isSpicy: false),
        
        MenuItem(id: "FR03", code: "FR03", name: "Shrimp Fried Rice", price: .fixed(12.95), category: .rice, subcategory: nil, description: "Fried rice with shrimp", items: nil, isSpicy: false)
    ]
}

// 扩展MenuItem使用新的数据源
extension MenuItem {
    static var sampleItems: [MenuItem] {
        return MenuRepository.shared.allItems
    }
} 