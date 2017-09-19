//: Playground - noun: a place where people can play

struct AdventurePathCard {
    let adventures: [AdventureCard]
}

struct AdventureCard {
    let name: String
    let scenarios: [ScenarioCard]
    let reward: Any
}

struct ScenarioCard {
    let name: String
    let locations: [LocationCard]
    let villain: VillianCard
    let henchmens: [HenchmenCard]
    let modifier: Any
    let reward: Any
}

struct LocationCard {
    let name: String
    let monsters: Int
    let barriers: Int
    let weapons: Int
    let spells: Int
    let armor: Int
    let items: Int
    let allies: Int
    let blessings: Int
    let inLocation: Any
    let whenClosing: Any
    let whenClosed: Any
}

struct VillianCard {
    let name: String
    let traits: [Trait]
    let kind: Any
    let victory: Any
    let powers: [Any]
}

struct HenchmenCard {
    let name: String
    let traits: [Trait]
    let kind: Any
    let victory: Any
    let powers: [Any]
}

struct CharacterCard {
    let name: String
    let traits: [Trait]
    let skills: [SkillType: SkillValue]
    let cards: CardList
    let handSize: Int
    let favoriteCardType: FavoriteCardType
    let proficiency: [Any]
    let powers: [Any]
}

indirect enum SkillValue {
    case dice(Int)
    case value(Int)
    case relative(SkillType)
    case sumOf([SkillValue])
    
    static let d4 = SkillValue.dice(4)
    static let d6 = SkillValue.dice(6)
    static let d8 = SkillValue.dice(8)
    static let d10 = SkillValue.dice(10)
    static let d12 = SkillValue.dice(12)
    
    static let strength = SkillValue.relative(.strength)
    static let dexterity = SkillValue.relative(.dexterity)
    static let constitution = SkillValue.relative(.constitution)
    static let intelligence = SkillValue.relative(.intelligence)
    static let wisdom = SkillValue.relative(.wisdom)
    static let charisma = SkillValue.relative(.charisma)
    
    static func + (left: SkillValue, right: SkillValue) -> SkillValue {
        return .sumOf([left, right])
    }
    
    static func + (left: SkillValue, right: Int) -> SkillValue {
        return left + SkillValue.value(right)
    }
}

enum SkillType: Hashable {
    // basic
    case strength
    case dexterity
    case constitution
    case intelligence
    case wisdom
    case charisma
    // compund
    case knowledge
    case arcane
    case diplomacy
    case belief
}

struct CardList {
    let weapons: Int
    let spells: Int
    let armor: Int
    let items: Int
    let allies: Int
    let blessings: Int
}

enum FavoriteCardType {
    case weapon, spell, armor, item, ally, blessing, any, none
}

enum Trait {
    case male, female
    case man, halfling
    case rogue, bandit, bard
}

// TODO: Add Feats
let Лем = CharacterCard(
    name: "Лем",
    traits: [.male, .halfling, .bard],
    skills: [
        .strength: .d4,
        .dexterity: .d8,
        .constitution: .d6,
        .intelligence: .d6,
        .knowledge: .intelligence + 3,
        .wisdom: .d6,
        .charisma: .d10,
        .arcane: .charisma + 1,
        .diplomacy: .charisma + 3,
        .belief: .charisma + 1 ],
    cards: CardList(
        weapons: 1,
        spells: 4,
        armor: 0,
        items: 2,
        allies: 3,
        blessings: 5),
    handSize: 6,
    favoriteCardType: .any,
    proficiency: [],
    powers: [
        "Один раз за проверку можете перезарядить карту, чтобы добавить 1d4 (☐ +1) (☐ +2) к проверке, которую проходит другой персонаж в вашей локации",
        "В начале вашего хода можете поменять 1 карту с руки на 1 карту того же типа из вашей стопки сброса"
    ]
)

let Лес = LocationCard(
    name: "Лес",
    monsters: 4,
    barriers: 2,
    weapons: 1,
    spells: 0,
    armor: 0,
    items: 2,
    allies: 0,
    blessings: 0,
    inLocation: "Непобежденные монстры (кроме прислужников и злодеев) изгоняются",
    whenClosing: "Пройдите проверку мудрости или выживания со сложностью 6",
    whenClosed: "Нет эффекта"
)

let Набережная = LocationCard(
    name: "Набережная",
    monsters: 4,
    barriers: 2,
    weapons: 0,
    spells: 0,
    armor: 0,
    items: 1,
    allies: 2,
    blessings: 0,
    inLocation: "Сыграв оружие, вычтите 1 из результата каждого брошенного кубика",
    whenClosing: "Призовите и победите карту прислужника 'Разбойник'",
    whenClosed: "Когда закрывается локация, все персонажи в локации сбрасывают по карте"
)

let Ферма = LocationCard(
    name: "Ферма",
    monsters: 3,
    barriers: 1,
    weapons: 1,
    spells: 0,
    armor: 0,
    items: 3,
    allies: 1,
    blessings: 0,
    inLocation: "Если вы сбрасываете компаньона, то вместо этого захороните его",
    whenClosing: "Призовите и победите случайного монстра",
    whenClosed: "Нет эффекта"
)

let Деревянный_Мост = LocationCard(
    name: "Деревянный мост",
    monsters: 3,
    barriers: 1,
    weapons: 0,
    spells: 0,
    armor: 1,
    items: 0,
    allies: 3,
    blessings: 1,
    inLocation: "Можете сбросить 2 карты чтобы прервать столкновение",
    whenClosing: "Пройдите проверку ловкости или скрытности со сложностью 6",
    whenClosed: "Заканчивая ход в этой локации, можете захоронить карту с руки, чтобы перезарядить карту из вашей стопки сброса")

let Академия = LocationCard(
    name: "Академия",
    monsters: 1,
    barriers: 1,
    weapons: 0,
    spells: 5,
    armor: 0,
    items: 1,
    allies: 1,
    blessings: 0,
    inLocation: "Если во время первого исследования на вашем ходу вы не столкнулись не с заклинаниями, то после исследования можете исследовать снова",
    whenClosing: "Пройдите проверку интеллекта или чар со сложностью 6",
    whenClosed: "Закрывая локацию, можете замешать заклинание из вашей стопки сброса в вашу колоду")

let Темница = LocationCard(
    name: "Темница",
    monsters: 3,
    barriers: 2,
    weapons: 0,
    spells: 0,
    armor: 1,
    items: 1,
    allies: 2,
    blessings: 0,
    inLocation: "Вместо того чтобы проходить проверку приобредения находки по указаному навыку, можете провести проверку ловкости или механики со сложностью 8",
    whenClosing: "Пройдите проверку харизмы или дипломатии со сложностью 6",
    whenClosed: "Закрывая локацию можете замешать компаньона из вашей стопки сброса в вашу колоду"
)

let Гарнизон = LocationCard(
    name: "Гарнизон",
    monsters: 3,
    barriers: 0,
    weapons: 3,
    spells: 0,
    armor: 2,
    items: 0,
    allies: 1,
    blessings: 0,
    inLocation: "Если вы столкнулись с монстром (кроме прислужников и злодеев) каждый персонаж в этой локации призывает такого же монстра и вступает с ним в столкновение",
    whenClosing: "Призовите и победите карту прислужника 'Разбойник'. Сложность боевой проверки увеличина на 2",
    whenClosed: "Закрывая локацию не изгоняйте оставшееся в ней оружие и броню, а замешайте обратно в колоду этой локации"
)

let Гиблая_Пещера = LocationCard(
    name: "Гиблая пещера",
    monsters: 2,
    barriers: 1,
    weapons: 2,
    spells: 0,
    armor: 2,
    items: 2,
    allies: 0,
    blessings: 0,
    inLocation: "Чтобы переместится или быть перемещенным из этой локации, вы обязаны пройти проверку выносливости или стойкости со сложностью 6",
    whenClosing: "Пройдите проверку мудрости или выживания со сложностью 6",
    whenClosed: "Нет эффекта"
)

let Джабрайл_Виски = VillianCard(
    name: "Джабрайл Виски",
    traits: [.man, .rogue],
    kind: "Монстр",
    victory: "Бой, 10",
    powers: ["Перед столкновением перезарядите 2 любые карты с руки"]
)

let Разбойник = HenchmenCard(
    name: "Разбойник",
    traits: [.man, .bandit],
    kind: "Монстр",
    victory: "Бой, 8",
    powers: ["Перед столкновением перезарядите 1 любую карту с руки",
             "Если побежден, можете немедленно провести проверку закрытия этой локации"]
)

let Рубиих = ScenarioCard(
    name: "Рубиих",
    locations: [ Лес,
                 Набережная,
                 Ферма,
                 Деревянный_Мост,
                 Академия,
                 Темница,
                 Гарнизон,
                 Гиблая_Пещера ],
    villain: Джабрайл_Виски,
    henchmens: [ Разбойник ],
    modifier: "Если способность монстра обязывает вас перезарядить одну или несколько карт, сделайте это, а затем возьмите такое же количество карт",
    reward: "Каждый персонаж берет случайный предмет из коробки"
)














