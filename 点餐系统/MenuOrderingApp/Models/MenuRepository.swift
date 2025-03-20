import Foundation

class MenuRepository {
    static let shared = MenuRepository()
    
    var allItems: [MenuItem] = [
// MARK: - Family Dinners
MenuItem(
    id: "FD01", code: "FD01", name: "Dinner for 2",
    price: .fixed(21.95),
    category: .familyDinner,
    subcategory: nil,
    description: "Wonton Soup, Egg Rolls, Chicken Chop Suey, Sweet & Sour Chicken Balls, Chicken Fried Rice & Cookies",
    items: ["Wonton Soup - Egg Rolls", "Chicken Chop Suey - Sweet & Sour Chicken Balls", "Chicken Fried Rice & Cookies"],
    isSpicy: false
),
MenuItem(
    id: "FD02", code: "FD02", name: "Dinner for 3",
    price: .fixed(46.95),
    category: .familyDinner,
    subcategory: nil,
    description: "Wonton Soup, Egg Rolls, Chicken Chop Suey, Sweet & Sour Chicken Balls, Beef with Mixed Vegetables, Chicken Fried Rice & Cookies",
    items: ["Wonton Soup - Egg Rolls", "Chicken Chop Suey - Sweet & Sour Chicken Balls", "Beef with Mixed Vegetables", "Chicken Fried Rice & Cookies"],
    isSpicy: false
),
MenuItem(
    id: "FD03", code: "FD03", name: "Dinner for 4",
    price: .fixed(59.95),
    category: .familyDinner,
    subcategory: nil,
    description: "Wonton Soup, Egg Rolls, Breaded Shrimp, Chicken Chop Suey, Beef with Mixed Vegetables, Sweet & Sour Chicken Balls, Chicken Fried Rice & Cookies",
    items: ["Wonton Soup - Egg Rolls", "Breaded Shrimp - Chicken Chop Suey", "Beef with Mixed Vegetables", "Sweet & Sour Chicken Balls", "Chicken Fried Rice & Cookies"],
    isSpicy: false
),
MenuItem(
    id: "FD04", code: "FD04", name: "Dinner for 5",
    price: .fixed(74.95),
    category: .familyDinner,
    subcategory: nil,
    description: "Wonton Soup, Egg Rolls, Breaded Shrimp, Chicken Chow Mein, Beef with Mixed Vegetables, Sweet & Sour Chicken Balls, Chicken Lo Mein, Chicken Fried Rice & Cookies",
    items: ["Wonton Soup - Egg Rolls", "Breaded Shrimp - Chicken Chow Mein", "Beef with Mixed Vegetables", "Sweet & Sour Chicken Balls - Chicken Lo Mein", "Chicken Fried Rice & Cookies"],
    isSpicy: false
),
MenuItem(
    id: "FD05", code: "FD05", name: "Dinner for 6",
    price: .fixed(87.95),
    category: .familyDinner,
    subcategory: nil,
    description: "Wonton Soup, Egg Rolls, Breaded Shrimp, Beef Chop Suey, Chicken Chow Mein, Honey Garlic Spareribs, Sweet & Sour Chicken Balls, Cantonese Lo Mein, Chicken Fried Rice & Cookies",
    items: ["Wonton Soup - Egg Rolls", "Breaded Shrimp - Beef Chop Suey", "Chicken Chow Mein - Honey Garlic Spareribs", "Sweet & Sour Chicken Balls - Cantonese Lo Mein", "Chicken Fried Rice & Cookies"],
    isSpicy: false
),

// MARK: - Authentic Chinese Style Dinners
MenuItem(
    id: "AD01", code: "AD01", name: "Group Dinner for 2",
    price: .fixed(35.95),
    category: .authenticDinner,
    subcategory: nil,
    description: "2 Wonton Soup, 2 Spring Rolls, Beef with Mixed Vegetables, Sweet & Sour Chicken (Hong Kong Style), Chicken Fried Rice & Cookies",
    items: ["2 Wonton Soup, 2 Spring Rolls", "Beef with Mixed Vegetables", "Sweet & Sour Chicken (Hong Kong Style)", "Chicken Fried Rice & Cookies"],
    isSpicy: false
),
MenuItem(
    id: "AD02", code: "AD02", name: "Group Dinner for 3",
    price: .fixed(52.95),
    category: .authenticDinner,
    subcategory: nil,
    description: "3 Wonton Soup, 3 Spring Rolls, Sweet & Sour Chicken (Hong Kong Style), Lemon Chicken, Beef with Vegetables, Chicken Fried Rice & Cookies",
    items: ["3 Wonton Soup, 3 Spring Rolls", "Sweet & Sour Chicken (Hong Kong Style)", "Lemon Chicken", "Beef with Vegetables", "Chicken Fried Rice & Cookies"],
    isSpicy: false
),
MenuItem(
    id: "AD03", code: "AD03", name: "Group Dinner for 4",
    price: .fixed(66.95),
    category: .authenticDinner,
    subcategory: nil,
    description: "4 Wonton Soup, 4 Spring Rolls, Emperor Beef with Bean Sauce, Sweet & Sour Chicken (Hong Kong Style), Lemon Chicken, Shrimp with Vegetables, Chicken Fried Rice & Cookies",
    items: ["4 Wonton Soup, 4 Spring Rolls", "Emperor Beef with Bean Sauce", "Sweet & Sour Chicken (Hong Kong Style)", "Lemon Chicken", "Shrimp with Vegetables", "Chicken Fried Rice & Cookies"],
    isSpicy: false
),
MenuItem(
    id: "AD04", code: "AD04", name: "Group Dinner for 6",
    price: .fixed(97.95),
    category: .authenticDinner,
    subcategory: nil,
    description: "6 Wonton Soup, 6 Spring Rolls, Emperor Beef with Bean Sauce, Sweet & Sour Chicken (Hong Kong Style), Lemon Chicken, Shrimp with Vegetables, Singapore Noodles (spicy), Spicy Potatoes (spicy), Chicken Fried Rice & Cookies",
    items: ["6 Wonton Soup, 6 Spring Rolls", "Emperor Beef with Bean Sauce", "Sweet & Sour Chicken (Hong Kong Style)", "Lemon Chicken", "Shrimp with Vegetables", "Singapore Noodles (spicy)", "Spicy Potatoes (spicy)", "Chicken Fried Rice & Cookies"],
    isSpicy: true
),
       // MARK: - Combination Dinner for One
MenuItem(
    id: "CD01", code: "CD01", 
    name: "No. 1: Sweet & Sour Chicken Ball & Chicken Chop Suey",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD02", code: "CD02", 
    name: "No. 2: Chicken Chow Mein & Chicken Chop Suey",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD03", code: "CD03", 
    name: "No. 3: Sweet & Sour Chicken Ball",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD04", code: "CD04", 
    name: "No. 4: Chicken Chow Mein",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD05", code: "CD05", 
    name: "No. 5: Sweet & Sour Breaded Shrimp & Chicken Ball",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD06", code: "CD06", 
    name: "No. 6: Chicken or Beef w/ Black Bean Sauce",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD07", code: "CD07", 
    name: "No. 7: Diced Chicken with Almond",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD08", code: "CD08", 
    name: "No. 8: Chicken or Beef w/ Mixed Vegetables",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD09", code: "CD09", 
    name: "No. 9: Sweet & Sour Pork (Hong Kong Style)",
    price: .fixed(15.95),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD10", code: "CD10", 
    name: "No. 10: Sweet & Sour Chicken (Hong Kong Style)",
    price: .fixed(15.95),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD11", code: "CD11", 
    name: "No. 11: Lemon Chicken",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD12", code: "CD12", 
    name: "No. 12: Sweet & Sour Chicken Ball & Chicken Chow Mein",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD13", code: "CD13", 
    name: "No. 13: Vegetable Chop Suey",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD14", code: "CD14", 
    name: "No. 14: Chicken or Beef Chop Suey",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD15", code: "CD15", 
    name: "No. 15: Sweet & Sour Breaded Shrimp",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD16", code: "CD16", 
    name: "No. 16: Dry Garlic Ribs & Beef Chop Suey",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD17", code: "CD17", 
    name: "No. 17: Szechuan Chicken or Beef (spicy)",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CD18", code: "CD18", 
    name: "No. 18: Honey Garlic Spareribs",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD19", code: "CD19", 
    name: "No. 19: Sesame Chicken",
    price: .fixed(15.95),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CD20", code: "CD20", 
    name: "No. 20: General Tao's Chicken (spicy)",
    price: .fixed(15.95),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CD21", code: "CD21", 
    name: "No. 21: Crispy Spicy Ginger Beef (spicy)",
    price: .fixed(15.95),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CD22", code: "CD22", 
    name: "No. 22: Spicy Green Bean (spicy)",
    price: .fixed(14.45),
    category: .combinationDinner,
    subcategory: nil,
    description: "Served with Egg Roll and Chicken Fried Rice",
    items: nil,
    isSpicy: true
),

// MARK: - Deluxe Dinners
MenuItem(
    id: "DD01", code: "DD01", 
    name: "Deluxe Dinner for 2",
    price: .fixed(35.95),
    category: .deluxeDinner,
    subcategory: nil,
    description: "Wonton Soup, Egg Rolls, Chicken Chow Mein, Beef With Mixed Vegetables, Sweet & Sour Chicken Balls, Chicken Fried Rice & Cookies",
    items: ["Wonton Soup, Egg Rolls", "Chicken Chow Mein - Beef With Mixed Vegetables", "Sweet & Sour Chicken Balls", "Chicken Fried Rice & Cookies"],
    isSpicy: false
),
MenuItem(
    id: "DD02", code: "DD02", 
    name: "Deluxe Dinner for 3",
    price: .fixed(52.95),
    category: .deluxeDinner,
    subcategory: nil,
    description: "Wonton Soup, Egg Rolls, Dry Garlic Spareribs, General Tao's Chicken (spicy), Beef with Mixed Vegetables, Chicken Fried Rice & Cookies",
    items: ["Wonton Soup, Egg Rolls", "Dry Garlic Spareribs - General Tao's Chicken (spicy)", "Beef with Mixed Vegetables", "Chicken Fried Rice & Cookies"],
    isSpicy: true
),
MenuItem(
    id: "DD03", code: "DD03", 
    name: "Deluxe Dinner for 4",
    price: .fixed(66.95),
    category: .deluxeDinner,
    subcategory: nil,
    description: "Wonton Soup, Egg Rolls, Dry Garlic Spareribs, General Tao's Chicken (spicy), Beef w/ Mixed Vegetables, Szechuan Shrimp (spicy), Chicken Fried Rice & Cookies",
    items: ["Wonton Soup, Egg Rolls", "Dry Garlic Spareribs - General Tao's Chicken (spicy)", "Beef w/ Mixed Vegetables - Szechuan Shrimp (spicy)", "Chicken Fried Rice & Cookies"],
    isSpicy: true
),
MenuItem(
    id: "DD04", code: "DD04", 
    name: "Deluxe Dinner for 6",
    price: .fixed(97.95),
    category: .deluxeDinner,
    subcategory: nil,
    description: "Wonton Soup, Egg Rolls, Dry Garlic Spareribs, General Tao's Chicken (spicy), Crispy Ginger Beef (spicy), Beef w/ Mixed Vegetables, Cantonese Lo Mein, Szechuan Shrimp (spicy), Chicken Fried Rice & Cookies",
    items: ["Wonton Soup, Egg Rolls", "Dry Garlic Spareribs - General Tao's Chicken (spicy)", "Crispy Ginger Beef (spicy) - Beef w/ Mixed Vegetables", "Cantonese Lo Mein - Szechuan Shrimp (spicy)", "Chicken Fried Rice & Cookies"],
    isSpicy: true
),

        // MARK: - Appetizers
MenuItem(
    id: "AP01", code: "AP01", name: "Egg Roll",
    price: .fixed(2.25),
    category: .appetizer,
    subcategory: nil,
    description: "Classic egg roll with pork and vegetables",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "AP02", code: "AP02", name: "Spring Roll",
    price: .fixed(2.25),
    category: .appetizer,
    subcategory: nil,
    description: "Crispy vegetarian spring roll",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "AP03", code: "AP03", name: "Fried Wonton",
    price: .options(["9 pieces": 5.25, "14 pieces": 8.75]),
    category: .appetizer,
    subcategory: nil,
    description: "Deep-fried pork wonton",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "AP04", code: "AP04", name: "Sliced BBQ Pork",
    price: .fixed(14.95),
    category: .appetizer,
    subcategory: nil,
    description: "Roasted BBQ pork slices",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "AP05", code: "AP05", name: "Dry Garlic Spareribs",
    price: .fixed(13.95),
    category: .appetizer,
    subcategory: nil,
    description: "Crispy spareribs with garlic flavor",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "AP06", code: "AP06", name: "Fried Beef Dumpling",
    price: .options(["9 pieces": 5.25, "12 pieces": 8.75]),
    category: .appetizer,
    subcategory: nil,
    description: "Pan-fried beef dumplings",
    items: nil,
    isSpicy: false
),

// MARK: - Soups
MenuItem(
    id: "SP01", code: "SP01", name: "Chicken Corn Soup",
    price: .options(["pint": 5.25, "quart": 8.25, "bowl": 4.25]),
    category: .soup,
    subcategory: nil,
    description: "Chicken broth with corn and egg",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SP02", code: "SP02", name: "Chicken Noodle Soup",
    price: .options(["pint": 6.25, "quart": 8.25, "bowl": 4.25]),
    category: .soup,
    subcategory: nil,
    description: "Classic chicken noodle soup",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SP03", code: "SP03", name: "Chicken Rice Soup",
    price: .options(["bowl": 3.95]),
    category: .soup,
    subcategory: nil,
    description: "Chicken soup with steamed rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SP04", code: "SP04", name: "Mixed Vegetables Soup",
    price: .options(["bowl": 3.25]),
    category: .soup,
    subcategory: nil,
    description: "Assorted vegetables in clear broth",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SP05", code: "SP05", name: "Egg Drop Soup",
    price: .options(["bowl": 3.25]),
    category: .soup,
    subcategory: nil,
    description: "Silky egg ribbons in chicken broth",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SP06", code: "SP06", name: "Hot and Sour Soup",
    price: .options(["bowl": 4.25, "pint": 8.25, "large": 14.95]),
    category: .soup,
    subcategory: nil,
    description: "Spicy and tangy soup with tofu and mushrooms",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "SP07", code: "SP07", name: "Wonton Soup",
    price: .options(["large": 6.25, "bowl": 3.25]),
    category: .soup,
    subcategory: nil,
    description: "Pork wontons in clear broth",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SP08", code: "SP08", name: "War Wonton Soup",
    price: .options(["large": 13.25, "small": 8.25]),
    category: .soup,
    subcategory: nil,
    description: "Combination soup with shrimp, BBQ pork, chicken, and vegetables",
    items: nil,
    isSpicy: false
),
// MARK: - Chop Suey
MenuItem(
    id: "CS01", code: "CS01", name: "Beef Chop Suey",
    price: .fixed(12.95),
    category: .chopSuey,
    subcategory: nil,
    description: "Beef sautéed with mixed vegetables",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CS02", code: "CS02", name: "B.B.Q. Pork Chop Suey",
    price: .fixed(12.95),
    category: .chopSuey,
    subcategory: nil,
    description: "BBQ pork with mixed vegetables",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CS03", code: "CS03", name: "Chicken Chop Suey",
    price: .fixed(14.95),
    category: .chopSuey,
    subcategory: nil,
    description: "Chicken with mixed vegetables",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CS04", code: "CS04", name: "Special Chop Suey",
    price: .fixed(14.95),
    category: .chopSuey,
    subcategory: nil,
    description: "Combination of meats and seafood",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CS05", code: "CS05", name: "Shrimp Chop Suey",
    price: .fixed(15.95),
    category: .chopSuey,
    subcategory: nil,
    description: "Shrimp with mixed vegetables",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CS06", code: "CS06", name: "Mushroom Chop Suey",
    price: .fixed(12.95),
    category: .chopSuey,
    subcategory: nil,
    description: "Assorted mushrooms with vegetables",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CS07", code: "CS07", name: "Vegetable Chop Suey",
    price: .fixed(12.95),
    category: .chopSuey,
    subcategory: nil,
    description: "Vegetarian mixed vegetables",
    items: nil,
    isSpicy: false
),

// MARK: - Egg Foo Young
MenuItem(
    id: "EF01", code: "EF01", name: "Beef Egg Foo Young",
    price: .fixed(12.95),
    category: .eggFooYoung,
    subcategory: nil,
    description: "Beef omelette with gravy",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "EF02", code: "EF02", name: "Chicken Egg Foo Young",
    price: .fixed(12.95),
    category: .eggFooYoung,
    subcategory: nil,
    description: "Chicken omelette with gravy",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "EF03", code: "EF03", name: "B-B.Q Pork Egg Foo Young",
    price: .fixed(12.95),
    category: .eggFooYoung,
    subcategory: nil,
    description: "BBQ pork omelette with gravy",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "EF04", code: "EF04", name: "Mushroom Egg Foo Young",
    price: .fixed(12.95),
    category: .eggFooYoung,
    subcategory: nil,
    description: "Mushroom omelette with gravy",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "EF05", code: "EF05", name: "Shrimp Egg Foo Young",
    price: .fixed(12.95),
    category: .eggFooYoung,
    subcategory: nil,
    description: "Shrimp omelette with gravy",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "EF06", code: "EF06", name: "Vegetable Egg Foo Young",
    price: .fixed(12.95),
    category: .eggFooYoung,
    subcategory: nil,
    description: "Vegetarian omelette with gravy",
    items: nil,
    isSpicy: false
),

// MARK: - Vegetables
MenuItem(
    id: "VG01", code: "VG01", name: "Szechuan Vegetable (Hot)",
    price: .fixed(12.95),
    category: .vegetable,
    subcategory: nil,
    description: "Spicy Szechuan-style vegetables",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "VG02", code: "VG02", name: "Stir Fried Tender Green Vegetable",
    price: .fixed(13.95),
    category: .vegetable,
    subcategory: nil,
    description: "Baby corn, broccoli, and snow peas",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "VG03", code: "VG03", name: "Stir Fried Mixed Vegetables",
    price: .fixed(12.95),
    category: .vegetable,
    subcategory: nil,
    description: "Seasonal vegetables stir-fried",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "VG04", code: "VG04", name: "Bean Curd with Mixed Vegetables",
    price: .fixed(12.95),
    category: .vegetable,
    subcategory: nil,
    description: "Tofu with mixed vegetables",
    items: nil,
    isSpicy: false
),

// MARK: - Beef
MenuItem(
    id: "BF01", code: "BF01", name: "Beef with Broccoli",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Tender beef sautéed with fresh broccoli",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "BF02", code: "BF02", name: "Beef with Mixed Vegetables",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Beef with assorted seasonal vegetables",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "BF03", code: "BF03", name: "Beef with Mushrooms",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Beef slices with mushrooms",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "BF04", code: "BF04", name: "Beef with Green Peppers & Mushrooms",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Beef with green peppers and mushrooms",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "BF05", code: "BF05", name: "Beef with Tomato",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Beef in tangy tomato sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "BF06", code: "BF06", name: "Beef with Snow Peapods",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Beef with fresh snow peas",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "BF07", code: "BF07", name: "Beef with Black Bean Sauce",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Beef in fermented black bean sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "BF08", code: "BF08", name: "Beef with Ginger & Green Onion",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Beef stir-fried with fresh ginger and scallions",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "BF09", code: "BF09", name: "Spicy Beef (Hot)",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Szechuan-style spicy beef",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "BF10", code: "BF10", name: "Curry Beef (Hot)",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Beef in yellow curry sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "BF11", code: "BF11", name: "Crispy Spicy Ginger Beef",
    price: .fixed(16.95),
    category: .beef,
    subcategory: nil,
    description: "Crispy beef strips with spicy ginger sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "BF12", code: "BF12", name: "Beef with Honey Pepper Sauce (Hot)",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Beef in honey black pepper sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "BF13", code: "BF13", name: "Beef with Black Pepper Sauce (Hot)",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Beef in bold black pepper sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "BF14", code: "BF14", name: "Beef with Chinese Broccoli",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Beef with Chinese broccoli (Gai Lan)",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "BF15", code: "BF15", name: "Szechuan Beef (Hot)",
    price: .fixed(15.95),
    category: .beef,
    subcategory: nil,
    description: "Numbing spicy Szechuan beef",
    items: nil,
    isSpicy: true
),

// MARK: - Chicken
MenuItem(
    id: "CH01", code: "CH01", name: "Sweet & Sour Chicken Ball",
    price: .fixed(14.95),
    category: .chicken,
    subcategory: nil,
    description: "Crispy chicken balls in tangy sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CH02", code: "CH02", name: "Chicken Chow Mein",
    price: .fixed(14.95),
    category: .chicken,
    subcategory: nil,
    description: "Stir-fried noodles with chicken",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CH03", code: "CH03", name: "Chicken with Broccoli",
    price: .fixed(14.95),
    category: .chicken,
    subcategory: nil,
    description: "Chicken breast with fresh broccoli",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CH04", code: "CH04", name: "Chicken with Mixed Vegetables",
    price: .fixed(14.95),
    category: .chicken,
    subcategory: nil,
    description: "Chicken with assorted vegetables",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CH05", code: "CH05", name: "Mushroom Chicken",
    price: .fixed(14.95),
    category: .chicken,
    subcategory: nil,
    description: "Chicken sautéed with mushrooms",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CH06", code: "CH06", name: "Chicken with Snow Peapods",
    price: .fixed(15.95),
    category: .chicken,
    subcategory: nil,
    description: "Chicken with crisp snow peas",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CH07", code: "CH07", name: "Chicken with Black Bean Sauce",
    price: .fixed(15.95),
    category: .chicken,
    subcategory: nil,
    description: "Chicken in savory black bean sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CH08", code: "CH08", name: "Chicken w/ Honey Pepper Sauce (Hot)",
    price: .fixed(15.95),
    category: .chicken,
    subcategory: nil,
    description: "Spicy chicken in honey pepper glaze",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CH09", code: "CH09", name: "Chicken with Black Pepper Sauce (Hot)",
    price: .fixed(15.95),
    category: .chicken,
    subcategory: nil,
    description: "Chicken in bold black pepper sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CH10", code: "CH10", name: "Spicy Chicken (Hot)",
    price: .fixed(15.95),
    category: .chicken,
    subcategory: nil,
    description: "Szechuan-style spicy chicken",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CH11", code: "CH11", name: "Curry Chicken (Hot)",
    price: .fixed(15.95),
    category: .chicken,
    subcategory: nil,
    description: "Chicken in yellow curry sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CH12", code: "CH12", name: "Diced Chicken with Almonds or Cashew Nuts",
    price: .fixed(14.95),
    category: .chicken,
    subcategory: nil,
    description: "Chicken cubes with nuts",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CH13", code: "CH13", name: "Diced Chicken with Yellow Bean Sauce",
    price: .fixed(14.95),
    category: .chicken,
    subcategory: nil,
    description: "Chicken in yellow bean sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CH14", code: "CH14", name: "Sesame Chicken",
    price: .fixed(16.95),
    category: .chicken,
    subcategory: nil,
    description: "Crispy chicken with sesame glaze",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CH15", code: "CH15", name: "Szechuan Chicken (Hot)",
    price: .fixed(15.95),
    category: .chicken,
    subcategory: nil,
    description: "Numbing spicy Szechuan chicken",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CH16", code: "CH16", name: "General Tao's Chicken (Hot)",
    price: .fixed(16.95),
    category: .chicken,
    subcategory: nil,
    description: "Crispy chicken in spicy sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CH17", code: "CH17", name: "Kung Pao Chicken (Hot)",
    price: .fixed(14.95),
    category: .chicken,
    subcategory: nil,
    description: "Classic Kung Pao with peanuts",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CH18", code: "CH18", name: "Deep Fried Chicken Wings",
    price: .fixed(14.95),
    category: .chicken,
    subcategory: nil,
    description: "Crispy fried chicken wings",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CH19", code: "CH19", name: "Honey Chicken Wings",
    price: .fixed(14.95),
    category: .chicken,
    subcategory: nil,
    description: "Sticky honey-glazed wings",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CH20", code: "CH20", name: "Lemon Chicken",
    price: .fixed(16.95),
    category: .chicken,
    subcategory: nil,
    description: "Crispy chicken with lemon sauce",
    items: nil,
    isSpicy: false
),

// MARK: - Seafood
MenuItem(
    id: "SF01", code: "SF01", name: "Breaded Shrimp with Sweet & Sour Sauce or Plum Sauce",
    price: .fixed(16.95),
    category: .seafood,
    subcategory: nil,
    description: "Crispy shrimp with dual sauce options",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SF02", code: "SF02", name: "Stir Fried Shrimp with Peapods",
    price: .fixed(17.95),
    category: .seafood,
    subcategory: nil,
    description: "Shrimp sautéed with snow peas",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SF03", code: "SF03", name: "Stir Fried Shrimp with Broccoli",
    price: .fixed(16.95),
    category: .seafood,
    subcategory: nil,
    description: "Shrimp with fresh broccoli",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SF04", code: "SF04", name: "Stir Fried Shrimp w/ Mixed Vegetables",
    price: .fixed(16.95),
    category: .seafood,
    subcategory: nil,
    description: "Shrimp with seasonal vegetables",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SF05", code: "SF05", name: "Shrimp with Tomato Sauce",
    price: .fixed(16.95),
    category: .seafood,
    subcategory: nil,
    description: "Shrimp in tangy tomato sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SF06", code: "SF06", name: "Shrimp with Lobster Sauce",
    price: .fixed(16.95),
    category: .seafood,
    subcategory: nil,
    description: "Shrimp in rich lobster sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SF07", code: "SF07", name: "Curry Shrimp (Hot)",
    price: .fixed(16.95),
    category: .seafood,
    subcategory: nil,
    description: "Shrimp in yellow curry sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "SF08", code: "SF08", name: "Shrimp with Black Bean Sauce",
    price: .fixed(16.95),
    category: .seafood,
    subcategory: nil,
    description: "Shrimp in fermented black bean sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SF09", code: "SF09", name: "Seafood with Mixed Vegetables",
    price: .fixed(18.95),
    category: .seafood,
    subcategory: nil,
    description: "Assorted seafood with vegetables",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SF10", code: "SF10", name: "Seafood with Snow Peapods",
    price: .fixed(18.95),
    category: .seafood,
    subcategory: nil,
    description: "Seafood with crisp snow peas",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SF11", code: "SF11", name: "Seafood with Black Bean Sauce",
    price: .fixed(18.95),
    category: .seafood,
    subcategory: nil,
    description: "Seafood in black bean sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SF12", code: "SF12", name: "Szechuan Shrimp (Hot)",
    price: .fixed(16.95),
    category: .seafood,
    subcategory: nil,
    description: "Spicy Szechuan-style shrimp",
    items: nil,
    isSpicy: true
),

// MARK: - Sweet and Sour Pork and Ribs
MenuItem(
    id: "SS01", code: "SS01", name: "Stir Fried Sweet & Sour Chicken",
    price: .fixed(14.95),
    category: .sweetAndSour,
    subcategory: nil,
    description: "Chicken in classic sweet & sour sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SS02", code: "SS02", name: "Stir Fried Sweet & Sour Shrimp",
    price: .fixed(17.95),
    category: .sweetAndSour,
    subcategory: nil,
    description: "Shrimp in sweet & sour sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SS03", code: "SS03", name: "Stir Fried Sweet & Sour Beef",
    price: .fixed(15.95),
    category: .sweetAndSour,
    subcategory: nil,
    description: "Beef in sweet & sour sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SS04", code: "SS04", name: "Sweet & Sour Pork (Hong Kong Style)",
    price: .fixed(15.95),
    category: .sweetAndSour,
    subcategory: nil,
    description: "Crispy pork with Hong Kong-style sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SS05", code: "SS05", name: "Sweet & Sour Chicken (Hong Kong Style)",
    price: .fixed(15.95),
    category: .sweetAndSour,
    subcategory: nil,
    description: "Crispy chicken with Hong Kong-style sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SS06", code: "SS06", name: "Sweet & Sour Shrimp (Hong Kong Style)",
    price: .fixed(17.95),
    category: .sweetAndSour,
    subcategory: nil,
    description: "Shrimp with Hong Kong-style sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SS07", code: "SS07", name: "Sweet & Sour Sauce",
    price: .fixed(15.95),
    category: .sweetAndSour,
    subcategory: nil,
    description: "Extra portion of sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SS08", code: "SS08", name: "Honey Garlic Spareribs",
    price: .fixed(15.95),
    category: .sweetAndSour,
    subcategory: nil,
    description: "Tender ribs in honey garlic glaze",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SS09", code: "SS09", name: "Pickled Pork Chops",
    price: .fixed(15.95),
    category: .sweetAndSour,
    subcategory: nil,
    description: "Marinated pork chops",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SS10", code: "SS10", name: "Sliced B.B.Q. Pork",
    price: .fixed(15.95),
    category: .sweetAndSour,
    subcategory: nil,
    description: "Roasted BBQ pork slices",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "SS11", code: "SS11", name: "Spicy Pork Chops",
    price: .fixed(15.95),
    category: .sweetAndSour,
    subcategory: nil,
    description: "Pork chops in chili sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "SS12", code: "SS12", name: "B.B.Q. Pork with Mixed Vegetables",
    price: .fixed(14.95),
    category: .sweetAndSour,
    subcategory: nil,
    description: "BBQ pork with vegetables",
    items: nil,
    isSpicy: false
),

       // MARK: - Fried Noodle
MenuItem(
    id: "FN01", code: "FN01", name: "Cantonese Chow Mein or Lo Mein",
    price: .fixed(16.95),
    category: .noodle,
    subcategory: nil,
    description: "Crispy or soft noodles Cantonese-style",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FN02", code: "FN02", name: "Chicken or Beef or B.B.Q. Pork Chow Mein or Lo Mein",
    price: .fixed(14.95),
    category: .noodle,
    subcategory: nil,
    description: "Choice of protein with noodles",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FN03", code: "FN03", name: "Shrimp Chow Mein or Lo Mein",
    price: .fixed(16.95),
    category: .noodle,
    subcategory: nil,
    description: "Shrimp with noodles",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FN04", code: "FN04", name: "Seafood Chow Mein or Lo Mein",
    price: .fixed(18.95),
    category: .noodle,
    subcategory: nil,
    description: "Assorted seafood with noodles",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FN05", code: "FN05", name: "Vegetable Chow Mein or Lo Mein",
    price: .fixed(15.95),
    category: .noodle,
    subcategory: nil,
    description: "Vegetarian noodles",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FN06", code: "FN06", name: "Shanghai Noodle",
    price: .fixed(14.95),
    category: .noodle,
    subcategory: nil,
    description: "Thick noodles in brown sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FN07", code: "FN07", name: "Singapore Noodles",
    price: .fixed(14.95),
    category: .noodle,
    subcategory: nil,
    description: "Curry-flavored rice noodles",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "FN08", code: "FN08", name: "Rice Noodle with Beef or Chicken (Black Bean Sauce)",
    price: .fixed(14.95),
    category: .noodle,
    subcategory: nil,
    description: "Flat rice noodles with black bean sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FN09", code: "FN09", name: "Rice Noodle with Shrimp or Seafood (Black Bean Sauce)",
    price: .fixed(18.95),
    category: .noodle,
    subcategory: nil,
    description: "Seafood rice noodles in black bean sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FN10", code: "FN10", name: "Rice Noodle with Beef or Chicken and Vegetable",
    price: .fixed(14.95),
    category: .noodle,
    subcategory: nil,
    description: "Rice noodles with vegetables and protein",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FN11", code: "FN11", name: "Rice Noodle with Beef or Chicken in Soy Sauce",
    price: .fixed(14.95),
    category: .noodle,
    subcategory: nil,
    description: "Rice noodles in soy sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FN12", code: "FN12", name: "Stir Fried Noodles with Bean Sprouts & Soy Sauce",
    price: .fixed(13.95),
    category: .noodle,
    subcategory: nil,
    description: "Simple stir-fried noodles with sprouts",
    items: nil,
    isSpicy: false
),

// MARK: - Fried Rice
MenuItem(
    id: "FR01", code: "FR01", name: "B.B.Q. Pork or Beef or Chicken Fried Rice",
    price: .fixed(10.95),
    category: .rice,
    subcategory: nil,
    description: "Classic fried rice with choice of meat",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FR02", code: "FR02", name: "House Special Fried Rice",
    price: .fixed(12.95),
    category: .rice,
    subcategory: nil,
    description: "Combination fried rice with shrimp and BBQ pork",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FR03", code: "FR03", name: "Mushroom Fried Rice",
    price: .fixed(9.95),
    category: .rice,
    subcategory: nil,
    description: "Fried rice with mushrooms",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FR04", code: "FR04", name: "Shrimp Fried Rice",
    price: .fixed(12.95),
    category: .rice,
    subcategory: nil,
    description: "Fried rice with shrimp",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FR05", code: "FR05", name: "Vegetable Fried Rice",
    price: .fixed(9.95),
    category: .rice,
    subcategory: nil,
    description: "Vegetarian fried rice",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "FR06", code: "FR06", name: "Fried Rice with Shrimp and B.B.Q. Pork",
    price: .fixed(12.95),
    category: .rice,
    subcategory: nil,
    description: "Premium combination fried rice",
    items: nil,
    isSpicy: false
),

// MARK: - Chef's Suggestions
MenuItem(
    id: "CF01", code: "CF01", name: "Emperor Beef",
    price: .fixed(16.95),
    category: .chefSuggestion,
    subcategory: nil,
    description: "Prime beef in savory bean sauce",
    items: nil,
    isSpicy: false
),
MenuItem(
    id: "CF02", code: "CF02", name: "Moo Shu Bean Curd with Minced Pork (Hot)",
    price: .fixed(14.95),
    category: .chefSuggestion,
    subcategory: nil,
    description: "Tofu and pork in hoisin sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CF03", code: "CF03", name: "Eggplant with Minced Pork & Garlic Sauce (Hot)",
    price: .fixed(14.95),
    category: .chefSuggestion,
    subcategory: nil,
    description: "Spicy eggplant with garlic sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CF04", code: "CF04", name: "Spicy Green Bean with Minced Pork (Hot)",
    price: .fixed(14.95),
    category: .chefSuggestion,
    subcategory: nil,
    description: "Szechuan-style green beans",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CF05", code: "CF05", name: "Spicy Garlic Seafood (Hong Kong Style)",
    price: .fixed(19.95),
    category: .chefSuggestion,
    subcategory: nil,
    description: "Assorted seafood in garlic chili sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CF06", code: "CF06", name: "Spicy Garlic Squid (Hong Kong Style)",
    price: .fixed(18.95),
    category: .chefSuggestion,
    subcategory: nil,
    description: "Tender squid in garlic sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CF07", code: "CF07", name: "Spicy Garlic Shrimp (Hong Kong Style)",
    price: .fixed(18.95),
    category: .chefSuggestion,
    subcategory: nil,
    description: "Shrimp in spicy garlic sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CF08", code: "CF08", name: "Spicy Garlic Chicken (Hong Kong Style)",
    price: .fixed(15.95),
    category: .chefSuggestion,
    subcategory: nil,
    description: "Chicken with garlic chili glaze",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CF09", code: "CF09", name: "Spicy Garlic Green Bean (Hot)",
    price: .fixed(13.95),
    category: .chefSuggestion,
    subcategory: nil,
    description: "Blistered green beans with garlic",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CF10", code: "CF10", name: "Spicy Garlic Bean Curd (Hot)",
    price: .fixed(13.95),
    category: .chefSuggestion,
    subcategory: nil,
    description: "Tofu in spicy garlic sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CF11", code: "CF11", name: "Spicy Garlic Pork Chops (Hot)",
    price: .fixed(13.95),
    category: .chefSuggestion,
    subcategory: nil,
    description: "Pork chops with garlic chili sauce",
    items: nil,
    isSpicy: true
),
MenuItem(
    id: "CF12", code: "CF12", name: "Tai Chop Suey",
    price: .fixed(16.95),
    category: .chefSuggestion,
    subcategory: nil,
    description: "Chef's signature chop suey",
    items: nil,
    isSpicy: false
)
    ]
}

extension MenuItem {
    static var sampleItems: [MenuItem] {
        return MenuRepository.shared.allItems
    }
}
