//Ques 1

struct Weapon {
    let name: String
    let damage: Int
}


class Player {
    var nickname: String
    var life: Int
    var weapon: Weapon
    
    
    init(nickname: String, life: Int, weapon: Weapon ) {
        self.nickname = nickname
        self.life = life
        self.weapon = weapon
    }
    
    func attack(){
        print("Игрок \(nickname) аттаковал оружием \(weapon.name) и нанес урон \(weapon.damage)")
    }
    
}

// Ques 2
class Sniper: Player {
    let zoom: Int
    
    init(zoom: Int, nickname: String, life: Int, weapon: Weapon) {
        self.zoom = zoom
        super.init(nickname: nickname, life: life, weapon: weapon)
    }
    
    func headShot(){
        print("Снайпер \(nickname) шотнул с прицелом x\(zoom) и наносит урон \(weapon.damage * 2) урона!")
    }
}


let ak47 = Weapon(name: "Ak-47", damage: 20)
let kubmakk = Player(nickname: "kubmakk", life: 12, weapon: ak47)
let bogdan = Sniper(zoom: 20, nickname: "negdobis", life: 90, weapon: ak47)

kubmakk.attack()
bogdan.attack()
bogdan.headShot()

// Задача 1: Инвентарь (Array)
var backpack = ["Аптечка", "Патроны", "Броник"]

backpack.append("Энергетик")

// Задача 2: Настройки профиля (Dictionary)

var appSettings: [String: Bool] = [
    "DarkTheme": true,
    "Notification": false,
]

if let userInfo = appSettings["DarkTheme"]{
    print("Темная тема \(userInfo)")
}

// Задача 3: Теги для видео (Set)

var videoTags: Set<String> = ["iOS", "Swift", "Code"]

let swiftTag = "Swift"
let robloxTag = "Roblox"

videoTags.insert(swiftTag)

print(videoTags.count)
videoTags.insert(robloxTag)

print(videoTags.count)

print("foundIndex")



func binarySearch(array: [Int], target: Int) -> Int? {
    
    var left = 0
    var right = array.count - 1
    
    while left <= right {
        
        let mid = (left + right) / 2
        let guess = array[mid]
        
        if guess == target {
            return mid
            
        } else if guess > target {
            right = mid - 1
            
        } else {
            left = mid + 1
        }
    }
    
    return left
}

// Проверяем:
let numbers = [1, 3, 5, 6]
if let foundIndex = binarySearch(array: numbers, target: 5) {
    print(foundIndex)
}

let numbers2 = [1, 3, 5, 6]
if let foundIndex = binarySearch(array: numbers, target: 2) {
    print(foundIndex)
}
let numbers3 = [1, 3, 5, 6]
if let foundIndex = binarySearch(array: numbers, target: 7) {
    print(foundIndex)
}
