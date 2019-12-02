Category.create({
  name: "Basic", color: "red", description: "Oh, Hello",
  cards: [
      Card.new(title: "What went well?", order: 1),
      Card.new(title: "What could have gone better?", order: 2),
      Card.new(title: "What did you learn?", order: 3),
      Card.new(title: "Does anything still puzzle you?", order: 4),
    ]
})

Category.create({
    name: "Advanced", color: "orange", description: "Level Up",
    cards: [
        Card.new(title: "What is one word you would use to describe the iteration?", order: 1),
        Card.new(title: "If you could change on thing about the way it went, what would that be?", order: 2),
        Card.new(title: "What compromises were made?", order: 3),
        Card.new(title: "What did you learn?", order: 4),
    ]
})

Category.create({
  name: "Change of Plans",
  color: "yellow",
  description: "Hey, it happens!",
  cards: [
    Card.new(title: "What was supposed to happen?", order: 1),
    Card.new(title: "What actually happened?", order: 2),
    Card.new(title: "Even though the work did not go as planned, " +
           "did we end this iteration successfully?", order: 3),
    Card.new(title: "What was your biggest lesson?", order: 4),
  ],
})