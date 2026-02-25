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
