import Foundation

class MenuRepository {
    // 菜单数据
    static let shared = MenuRepository()
    
    var allItems: [MenuItem] = [
        // 前菜 Appetizers
        MenuItem(id: "AP01", code: "AP01", name: "Egg Roll 蛋卷", price: 2.25, category: .appetizer, imageURL: "eggroll", description: "传统中式蛋卷"),
        MenuItem(id: "AP02", code: "AP02", name: "Spring Roll 春卷", price: 2.25, category: .appetizer, imageURL: "springroll", description: "传统中式春卷"),
        MenuItem(id: "AP03", code: "AP03", name: "Fried Wonton (8) 炸云吞 (8个)", price: 5.25, category: .appetizer, imageURL: "friedwonton", description: "酥脆可口的炸云吞"),
        MenuItem(id: "AP04", code: "AP04", name: "Fried Wonton (14) 炸云吞 (14个)", price: 8.75, category: .appetizer, imageURL: "friedwonton", description: "酥脆可口的炸云吞"),
        MenuItem(id: "AP05", code: "AP05", name: "Sliced BBQ Pork (S) 叉烧肉 (小)", price: 12.95, category: .appetizer, imageURL: "bbqpork", description: "香甜可口的叉烧肉"),
        MenuItem(id: "AP06", code: "AP06", name: "Sliced BBQ Pork (L) 叉烧肉 (大)", price: 14.95, category: .appetizer, imageURL: "bbqpork", description: "香甜可口的叉烧肉"),
        MenuItem(id: "AP07", code: "AP07", name: "Fried Beef Dumpling (6) 炸牛肉饺 (6个)", price: 5.25, category: .appetizer, imageURL: "dumpling", description: "美味的炸牛肉饺"),
        MenuItem(id: "AP08", code: "AP08", name: "Fried Beef Dumpling (12) 炸牛肉饺 (12个)", price: 8.75, category: .appetizer, imageURL: "dumpling", description: "美味的炸牛肉饺"),
        MenuItem(id: "AP09", code: "AP09", name: "Dry Garlic Spareribs 蒜香排骨", price: 14.95, category: .appetizer, imageURL: "spareribs", description: "香脆可口的蒜香排骨"),
        
        // 蔬菜 Vegetables
        MenuItem(id: "VG01", code: "VG01", name: "Szechuan Vegetable (Spicy) 四川风味素菜（辣）", price: 12.95, category: .vegetable, imageURL: "szechuanveg", description: "四川风味的辣味素菜"),
        MenuItem(id: "VG02", code: "VG02", name: "Sauteed Three Kinds Vegetable 三蔬炒", price: 13.95, category: .vegetable, imageURL: "mixedveg", description: "三种蔬菜炒制"),
        MenuItem(id: "VG03", code: "VG03", name: "Sauteed Mixed Vegetable 什锦素菜", price: 12.95, category: .vegetable, imageURL: "mixedveg", description: "什锦素菜炒制"),
        MenuItem(id: "VG04", code: "VG04", name: "Bean Curd w/ Mixed Vegetable 素菜豆腐", price: 12.95, category: .vegetable, imageURL: "tofuveg", description: "豆腐配什锦素菜"),
        
        // 牛肉 Beef
        MenuItem(id: "BF01", code: "BF01", name: "Beef w/ Broccoli 西兰花牛肉", price: 15.95, category: .beef, imageURL: "beefbroccoli", description: "牛肉配西兰花"),
        MenuItem(id: "BF02", code: "BF02", name: "Beef w/ Mixed Vege 素菜牛肉", price: 15.95, category: .beef, imageURL: "beefveg", description: "牛肉配什锦素菜"),
        MenuItem(id: "BF03", code: "BF03", name: "Beef w/ Mushrooms 蘑菇牛肉", price: 15.95, category: .beef, imageURL: "beefmushroom", description: "牛肉配蘑菇"),
        MenuItem(id: "BF04", code: "BF04", name: "Beef w/ Pepper & Mushroom 青椒蘑菇牛肉", price: 15.95, category: .beef, imageURL: "beefpeppermushroom", description: "牛肉配青椒和蘑菇"),
        MenuItem(id: "BF05", code: "BF05", name: "Beef w/ Tomato 番茄牛肉", price: 15.95, category: .beef, imageURL: "beeftomato", description: "牛肉配番茄"),
        MenuItem(id: "BF06", code: "BF06", name: "Beef w/ Snow Peapods 雪豆牛肉", price: 15.95, category: .beef, imageURL: "beefsnowpea", description: "牛肉配雪豆"),
        MenuItem(id: "BF07", code: "BF07", name: "Beef w/ Black Bean Sauce 豆豉牛肉", price: 15.95, category: .beef, imageURL: "beefblackbean", description: "豆豉酱牛肉"),
        MenuItem(id: "BF08", code: "BF08", name: "Beef w/ Ginger & Green Onion 姜葱牛肉", price: 15.95, category: .beef, imageURL: "beefginger", description: "姜葱牛肉"),
        MenuItem(id: "BF09", code: "BF09", name: "Satay Beef (Hot) 沙嗲牛肉（辣）", price: 15.95, category: .beef, imageURL: "sataybeef", description: "沙嗲风味辣牛肉"),
        MenuItem(id: "BF10", code: "BF10", name: "Curry Beef (Hot) 咖喱牛肉（辣）", price: 16.95, category: .beef, imageURL: "currybeef", description: "咖喱风味辣牛肉"),
        MenuItem(id: "BF11", code: "BF11", name: "Crispy Spicy Ginger Beef 香脆姜汁牛肉", price: 15.95, category: .beef, imageURL: "gingerbeef", description: "香脆姜汁牛肉，外脆里嫩"),
        MenuItem(id: "BF12", code: "BF12", name: "Beef w/ Honey Pepper Sauce (Hot) 蜜汁胡椒牛肉（辣）", price: 15.95, category: .beef, imageURL: "beefhoneypepper", description: "蜜汁胡椒酱牛肉"),
        MenuItem(id: "BF13", code: "BF13", name: "Beef w/ Black Pepper Sauce (Hot) 黑胡椒牛肉（辣）", price: 15.95, category: .beef, imageURL: "beefblackpepper", description: "黑胡椒酱牛肉"),
        MenuItem(id: "BF14", code: "BF14", name: "Beef w/ Chinese Broccoli 芥兰牛肉", price: 15.95, category: .beef, imageURL: "beefchinesebroccoli", description: "牛肉配芥兰"),
        MenuItem(id: "BF15", code: "BF15", name: "Szechuan Beef (Spicy) 四川牛肉（辣）", price: 15.95, category: .beef, imageURL: "szechuanbeef", description: "四川风味辣牛肉"),
        MenuItem(id: "BF16", code: "BF16", name: "Beef w/ Pepper 青椒牛肉", price: 14.95, category: .beef, imageURL: "beefpepper", description: "牛肉配青椒"),
        
        // 鸡肉 Chicken
        MenuItem(id: "CH01", code: "CH01", name: "Sweet and Sour Chicken Ball 甜酸鸡球", price: 14.95, category: .chicken, imageURL: "sweetsourball", description: "酥脆可口的甜酸鸡球"),
        MenuItem(id: "CH02", code: "CH02", name: "Chicken Soo Guy 酥炸鸡块", price: 14.95, category: .chicken, imageURL: "sooguy", description: "酥炸鸡块，外脆里嫩"),
        MenuItem(id: "CH03", code: "CH03", name: "Chicken w/ Broccoli 西兰花鸡肉", price: 14.95, category: .chicken, imageURL: "chickenbroccoli", description: "鸡肉配西兰花"),
        MenuItem(id: "CH04", code: "CH04", name: "Chicken w/ Mixed Vegetables 素菜鸡肉", price: 14.95, category: .chicken, imageURL: "chickenveg", description: "鸡肉配什锦素菜"),
        MenuItem(id: "CH05", code: "CH05", name: "Mushrooms Guy Pan 蘑菇鸡片", price: 14.95, category: .chicken, imageURL: "chickenmushroom", description: "鸡片配蘑菇"),
        MenuItem(id: "CH06", code: "CH06", name: "Chicken w/ Snow Peapods 雪豆鸡肉", price: 15.95, category: .chicken, imageURL: "chickensnowpea", description: "鸡肉配雪豆"),
        MenuItem(id: "CH07", code: "CH07", name: "Chicken w/ Black Bean Sauce 豆豉鸡肉", price: 15.95, category: .chicken, imageURL: "chickenblackbean", description: "豆豉酱鸡肉"),
        MenuItem(id: "CH08", code: "CH08", name: "Chicken w/ Honey Pepper Sauce (Hot) 蜜汁胡椒鸡肉（辣）", price: 15.95, category: .chicken, imageURL: "chickenhoneypepper", description: "蜜汁胡椒酱鸡肉"),
        MenuItem(id: "CH09", code: "CH09", name: "Chicken w/ Black Pepper Sauce (Hot) 黑胡椒鸡肉（辣）", price: 15.95, category: .chicken, imageURL: "chickenblackpepper", description: "黑胡椒酱鸡肉"),
        MenuItem(id: "CH10", code: "CH10", name: "Satay Chicken (Hot) 沙嗲鸡肉（辣）", price: 15.95, category: .chicken, imageURL: "sataychicken", description: "沙嗲风味辣鸡肉"),
        MenuItem(id: "CH11", code: "CH11", name: "Curry Chicken (Hot) 咖喱鸡肉（辣）", price: 15.95, category: .chicken, imageURL: "currychicken", description: "咖喱风味辣鸡肉"),
        MenuItem(id: "CH12", code: "CH12", name: "Diced Chicken w/ Almonds 杏仁鸡丁", price: 15.95, category: .chicken, imageURL: "chickenalmond", description: "杏仁炒鸡丁"),
        MenuItem(id: "CH13", code: "CH13", name: "Diced Chicken w/ Cashew Nuts 腰果鸡丁", price: 16.95, category: .chicken, imageURL: "chickencashew", description: "腰果炒鸡丁"),
        MenuItem(id: "CH14", code: "CH14", name: "Diced Chicken w/ Yellow Bean Sauce 黄豆酱鸡丁", price: 15.95, category: .chicken, imageURL: "chickenyellowbean", description: "黄豆酱鸡丁"),
        MenuItem(id: "CH15", code: "CH15", name: "Sesame Chicken 芝麻鸡", price: 16.95, category: .chicken, imageURL: "sesamechicken", description: "芝麻鸡，香脆可口"),
        MenuItem(id: "CH16", code: "CH16", name: "Szechuan Chicken (Spicy) 四川鸡肉（辣）", price: 16.95, category: .chicken, imageURL: "szechuanchicken", description: "四川风味辣鸡肉"),
        MenuItem(id: "CH17", code: "CH17", name: "General Tao's Chicken (Spicy) 左宗棠鸡（辣）", price: 14.95, category: .chicken, imageURL: "generaltao", description: "经典左宗棠鸡，香辣可口"),
        MenuItem(id: "CH18", code: "CH18", name: "Kung Po Chicken (Spicy) 宫保鸡丁（辣）", price: 14.95, category: .chicken, imageURL: "kungpao", description: "经典宫保鸡丁，麻辣鲜香"),
        MenuItem(id: "CH19", code: "CH19", name: "Honey Chicken Wings 蜜汁鸡翅", price: 14.95, category: .chicken, imageURL: "honeywings", description: "蜜汁鸡翅，甜香可口"),
        MenuItem(id: "CH20", code: "CH20", name: "Lemon Chicken 柠檬鸡", price: 16.95, category: .chicken, imageURL: "lemonchicken", description: "柠檬鸡，酸甜可口"),
        MenuItem(id: "CH23", code: "CH23", name: "Deep Fried Chicken Wings 炸鸡翅", price: 14.95, category: .chicken, imageURL: "friedwings", description: "香脆炸鸡翅"),
        
        // 海鲜 Seafood
        MenuItem(id: "SF01", code: "SF01", name: "Breaded Shrimp w/ Sweet and Sour Sauce 甜酸炸虾", price: 16.95, category: .seafood, imageURL: "shrimpsweet", description: "酥脆炸虾配甜酸酱"),
        MenuItem(id: "SF02", code: "SF02", name: "Breaded Shrimp w/ Plum Sauce 梅子酱炸虾", price: 16.95, category: .seafood, imageURL: "shrimpplum", description: "酥脆炸虾配梅子酱"),
        MenuItem(id: "SF03", code: "SF03", name: "Breaded Shrimp w/ Lemon Sauce 柠檬酱炸虾", price: 16.95, category: .seafood, imageURL: "shrimplemon", description: "酥脆炸虾配柠檬酱"),
        MenuItem(id: "SF04", code: "SF04", name: "Sauteed Shrimp w/ Broccoli 西兰花虾仁", price: 16.95, category: .seafood, imageURL: "shrimpbroccoli", description: "虾仁配西兰花"),
        MenuItem(id: "SF05", code: "SF05", name: "Sauteed Shrimp w/ Peapods 雪豆虾仁", price: 17.95, category: .seafood, imageURL: "shrimppeapod", description: "虾仁配雪豆"),
        MenuItem(id: "SF06", code: "SF06", name: "Sauteed Shrimp w/ Mixed Vegetables 素菜虾仁", price: 16.95, category: .seafood, imageURL: "shrimpveg", description: "虾仁配什锦素菜"),
        MenuItem(id: "SF07", code: "SF07", name: "Sauteed Shrimp w/ Tomato Sauce 番茄酱虾仁", price: 16.95, category: .seafood, imageURL: "shrimptomato", description: "番茄酱炒虾仁"),
        MenuItem(id: "SF08", code: "SF08", name: "Shrimp w/ Lobster Sauce 龙虾汁虾仁", price: 16.95, category: .seafood, imageURL: "shrimplobster", description: "龙虾汁虾仁"),
        MenuItem(id: "SF09", code: "SF09", name: "Curry Shrimp (Hot) 咖喱虾（辣）", price: 16.95, category: .seafood, imageURL: "curryshrimp", description: "咖喱风味辣虾"),
        MenuItem(id: "SF10", code: "SF10", name: "Shrimp w/ Black Bean Sauce 豆豉虾", price: 16.95, category: .seafood, imageURL: "shrimpblackbean", description: "豆豉酱虾"),
        MenuItem(id: "SF11", code: "SF11", name: "Seafood w/ Mixed Vegetables 素菜海鲜", price: 18.95, category: .seafood, imageURL: "seafoodmixed", description: "什锦海鲜配素菜"),
        MenuItem(id: "SF12", code: "SF12", name: "Seafood w/ Snow Peapods 雪豆海鲜", price: 18.95, category: .seafood, imageURL: "seafoodpeapod", description: "海鲜配雪豆"),
        MenuItem(id: "SF13", code: "SF13", name: "Seafood w/ Black Bean Sauce 豆豉海鲜", price: 18.95, category: .seafood, imageURL: "seafoodblackbean", description: "豆豉酱海鲜"),
        MenuItem(id: "SF14", code: "SF14", name: "Szechuan Shrimp (Hot) 四川虾（辣）", price: 16.95, category: .seafood, imageURL: "szechuanshrimp", description: "四川风味辣虾"),
        
        // 酸甜 Sweet & Sour
        MenuItem(id: "SS01", code: "SS01", name: "Sauteed Sweet & Sour Chicken 甜酸鸡", price: 16.95, category: .sweetSour, imageURL: "sweetsourchi", description: "炒甜酸鸡"),
        MenuItem(id: "SS02", code: "SS02", name: "Sauteed Sweet & Sour Shrimp 甜酸虾", price: 17.95, category: .sweetSour, imageURL: "sweetsourshrimp", description: "炒甜酸虾"),
        MenuItem(id: "SS03", code: "SS03", name: "Sauteed Sweet & Sour Beef 甜酸牛肉", price: 15.95, category: .sweetSour, imageURL: "sweetsourbeef", description: "炒甜酸牛肉"),
        MenuItem(id: "SS04", code: "SS04", name: "Sweet & Sour Pork (HK Style) 港式甜酸猪肉", price: 15.95, category: .sweetSour, imageURL: "sweetsourpork", description: "港式甜酸猪肉"),
        MenuItem(id: "SS05", code: "SS05", name: "Sweet & Sour Chicken (HK Style) 港式甜酸鸡", price: 15.95, category: .sweetSour, imageURL: "sweetsourchi", description: "港式甜酸鸡"),
        MenuItem(id: "SS06", code: "SS06", name: "Sweet & Sour Shrimp (HK Style) 港式甜酸虾", price: 17.95, category: .sweetSour, imageURL: "sweetsourshrimp", description: "港式甜酸虾"),
        MenuItem(id: "SS07", code: "SS07", name: "Sweet & Sour Sauce 甜酸酱", price: 2.5, category: .extra, imageURL: "sweetsauce", description: "甜酸酱"),
        
        // 面食 Noodles
        MenuItem(id: "FN01", code: "FN01", name: "Cantonese Chow Mein 广东炒面", price: 16.95, category: .noodle, imageURL: "cantonesechow", description: "广东风味炒面"),
        MenuItem(id: "FN02", code: "FN02", name: "Cantonese Lo Mein 广东捞面", price: 16.95, category: .noodle, imageURL: "cantoneselow", description: "广东风味捞面"),
        MenuItem(id: "FN03", code: "FN03", name: "Chicken Chow Mein 鸡肉炒面", price: 14.95, category: .noodle, imageURL: "chickenchow", description: "鸡肉炒面"),
        MenuItem(id: "FN04", code: "FN04", name: "Chicken Lo Mein 鸡肉捞面", price: 14.95, category: .noodle, imageURL: "chickenlo", description: "鸡肉捞面"),
        MenuItem(id: "FN05", code: "FN05", name: "Beef Chow Mein 牛肉炒面", price: 14.95, category: .noodle, imageURL: "beefchow", description: "牛肉炒面"),
        MenuItem(id: "FN06", code: "FN06", name: "Beef Lo Mein 牛肉捞面", price: 14.95, category: .noodle, imageURL: "beeflo", description: "牛肉捞面"),
        MenuItem(id: "FN07", code: "FN07", name: "BBQ Pork Chow Mein 叉烧炒面", price: 14.95, category: .noodle, imageURL: "porkchow", description: "叉烧炒面"),
        MenuItem(id: "FN08", code: "FN08", name: "BBQ Pork Lo Mein 叉烧捞面", price: 14.95, category: .noodle, imageURL: "porklo", description: "叉烧捞面"),
        MenuItem(id: "FN09", code: "FN09", name: "Shrimp Chow Mein 虾仁炒面", price: 16.95, category: .noodle, imageURL: "shrimpchow", description: "虾仁炒面"),
        MenuItem(id: "FN10", code: "FN10", name: "Shrimp Lo Mein 虾仁捞面", price: 16.95, category: .noodle, imageURL: "shrimplo", description: "虾仁捞面"),
        MenuItem(id: "FN11", code: "FN11", name: "Seafood Chow Mein 海鲜炒面", price: 18.95, category: .noodle, imageURL: "seafoodchow", description: "海鲜炒面"),
        MenuItem(id: "FN12", code: "FN12", name: "Seafood Lo Mein 海鲜捞面", price: 18.95, category: .noodle, imageURL: "seafoodlo", description: "海鲜捞面"),
        MenuItem(id: "FN13", code: "FN13", name: "Vegetable Chow Mein 素菜炒面", price: 13.95, category: .noodle, imageURL: "vegchow", description: "素菜炒面"),
        MenuItem(id: "FN14", code: "FN14", name: "Vegetable Lo Mein 素菜捞面", price: 13.95, category: .noodle, imageURL: "veglo", description: "素菜捞面"),
        MenuItem(id: "FN15", code: "FN15", name: "Shanghai Noodle 上海面", price: 14.95, category: .noodle, imageURL: "shanghai", description: "上海风味面"),
        MenuItem(id: "FN16", code: "FN16", name: "Singapore Noodle 新加坡炒米粉", price: 14.95, category: .noodle, imageURL: "singapore", description: "新加坡风味炒米粉"),
        MenuItem(id: "FN17", code: "FN17", name: "Rice Noodle w/ Beef (Black Bean Sauce) 豆豉牛肉河粉", price: 14.95, category: .noodle, imageURL: "ricenoodlebeef", description: "豆豉牛肉河粉"),
        MenuItem(id: "FN18", code: "FN18", name: "Rice Noodle w/ Chicken (Black Bean Sauce) 豆豉鸡肉河粉", price: 14.95, category: .noodle, imageURL: "ricenoodlechicken", description: "豆豉鸡肉河粉"),
        MenuItem(id: "FN19", code: "FN19", name: "Rice Noodle w/ Shrimp (Black Bean Sauce) 豆豉虾仁河粉", price: 18.95, category: .noodle, imageURL: "ricenoodleshrimp", description: "豆豉虾仁河粉"),
        MenuItem(id: "FN20", code: "FN20", name: "Rice Noodle w/ Seafood (Black Bean Sauce) 豆豉海鲜河粉", price: 18.95, category: .noodle, imageURL: "ricenoodleseafood", description: "豆豉海鲜河粉"),
        
        // 套餐 Combos
        MenuItem(id: "FD02", code: "FD02", name: "Dinner For 2 两人套餐", price: 31.95, category: .combo, imageURL: "dinner2", description: "两人套餐"),
        MenuItem(id: "FD03", code: "FD03", name: "Dinner For 3 三人套餐", price: 46.95, category: .combo, imageURL: "dinner3", description: "三人套餐"),
        MenuItem(id: "FD04", code: "FD04", name: "Dinner For 4 四人套餐", price: 59.95, category: .combo, imageURL: "dinner4", description: "四人套餐"),
        MenuItem(id: "FD05", code: "FD05", name: "Dinner For 5 五人套餐", price: 74.95, category: .combo, imageURL: "dinner5", description: "五人套餐"),
        MenuItem(id: "FD06", code: "FD06", name: "Dinner For 6 六人套餐", price: 87.95, category: .combo, imageURL: "dinner6", description: "六人套餐"),
        MenuItem(id: "CB01", code: "CB01", name: "No. 1 Ch Ball & Ch Chop Suey 套餐1: 鸡球和鸡杂碎", price: 14.45, category: .combo, imageURL: "combo1", description: "鸡球和鸡杂碎"),
        MenuItem(id: "CB02", code: "CB02", name: "No. 2 Soo Guy & Ch Chop Suey 套餐2: 酥炸鸡块和鸡杂碎", price: 14.45, category: .combo, imageURL: "combo2", description: "酥炸鸡块和鸡杂碎"),
        MenuItem(id: "CB03", code: "CB03", name: "No. 3 Sweet & Sour Chicken Ball 套餐3: 甜酸鸡球", price: 14.45, category: .combo, imageURL: "combo3", description: "甜酸鸡球"),
        MenuItem(id: "CB19", code: "CB19", name: "No. 19 Sesame Chicken 套餐19: 芝麻鸡", price: 15.95, category: .combo, imageURL: "combo19", description: "芝麻鸡"),
        MenuItem(id: "CB20", code: "CB20", name: "No. 20 General Tao's Chicken 套餐20: 左宗棠鸡", price: 15.95, category: .combo, imageURL: "combo20", description: "左宗棠鸡，经典中式辣鸡"),
        MenuItem(id: "CB21", code: "CB21", name: "No. 21 Crispy Spicy Ginger Beef 套餐21: 香脆姜汁牛肉", price: 14.45, category: .combo, imageURL: "combo21", description: "香脆姜汁牛肉"),
        
        // 饮料 Beverages
        MenuItem(id: "BV01", code: "BV01", name: "Soft Drink 软饮料", price: 2.25, category: .beverage, imageURL: "softdrink", description: "各种软饮料"),
        MenuItem(id: "BV02", code: "BV02", name: "Iced Tea 冰茶", price: 2.95, category: .beverage, imageURL: "icedtea", description: "清爽冰茶"),
        MenuItem(id: "BV03", code: "BV03", name: "Beer 啤酒", price: 5.5, category: .beverage, imageURL: "beer", description: "啤酒"),
        MenuItem(id: "BV04", code: "BV04", name: "Imported Beer 进口啤酒", price: 6.5, category: .beverage, imageURL: "importbeer", description: "进口啤酒"),
        MenuItem(id: "BV05", code: "BV05", name: "White/Red Wine (Glass) 白/红葡萄酒(杯)", price: 6.85, category: .beverage, imageURL: "wine", description: "杯装葡萄酒"),
        MenuItem(id: "BV07", code: "BV07", name: "Tea (Chinese) 中式茶", price: 2.0, category: .beverage, imageURL: "chinesetea", description: "传统中式茶"),
        MenuItem(id: "BV08", code: "BV08", name: "Tea 茶", price: 2.0, category: .beverage, imageURL: "tea", description: "茶"),
        MenuItem(id: "BV09", code: "BV09", name: "Coffee 咖啡", price: 2.95, category: .beverage, imageURL: "coffee", description: "咖啡"),
        MenuItem(id: "BV10", code: "BV10", name: "Orange Juice 橙汁", price: 2.95, category: .beverage, imageURL: "orange", description: "鲜榨橙汁"),
        MenuItem(id: "BV11", code: "BV11", name: "Apple Juice 苹果汁", price: 4.25, category: .beverage, imageURL: "apple", description: "苹果汁"),
        
        // 额外 Extras
        MenuItem(id: "EX01", code: "EX01", name: "Extra Beef 额外牛肉", price: 4.0, category: .extra, imageURL: "extrabeef", description: "额外添加牛肉"),
        MenuItem(id: "EX02", code: "EX02", name: "Extra Chicken 额外鸡肉", price: 3.0, category: .extra, imageURL: "extrachicken", description: "额外添加鸡肉"),
        MenuItem(id: "EX03", code: "EX03", name: "Extra Shrimp 额外虾仁", price: 6.0, category: .extra, imageURL: "extrashrimp", description: "额外添加虾仁"),
        MenuItem(id: "EX04", code: "EX04", name: "Extra Seafood 额外海鲜", price: 7.0, category: .extra, imageURL: "extraseafood", description: "额外添加海鲜"),
        MenuItem(id: "EX06", code: "EX06", name: "Extra Broccoli 额外西兰花", price: 2.0, category: .extra, imageURL: "extrabroccoli", description: "额外添加西兰花"),
        MenuItem(id: "EX13", code: "EX13", name: "White Rice (L) 白饭(大)", price: 6.0, category: .extra, imageURL: "rice", description: "大份白饭"),
        MenuItem(id: "EX19", code: "EX19", name: "Extra Black Bean Sauce 额外豆豉酱", price: 1.0, category: .extra, imageURL: "bbeansauce", description: "额外豆豉酱")
    ]
}

// 扩展MenuItem使用新的数据源
extension MenuItem {
    static var sampleItems: [MenuItem] {
        return MenuRepository.shared.allItems
    }
} 