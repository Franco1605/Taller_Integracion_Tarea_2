
hamburguesa = Hamburger.create({
  nombre: Faker::Lorem.sentence,
  precio: Faker::Lorem.sentence,
  descripcion: Faker::Lorem.sentence,
  imagen: Faker::Lorem.sentence,
})


ingrediente= Ingredient.create({
  nombre: Faker::Lorem.sentence,
  descripcion: Faker::Lorem.sentence,
})

hamburguesa.ingredientes = hamburguesa.ingredientes << ingrediente.id
hamburguesa.save

hamburguesa_final= HamburgersIngredient.create({hamburger_id: hamburguesa.id, ingredient_id: ingrediente.id})