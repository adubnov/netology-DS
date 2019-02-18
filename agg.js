use movies

# - подсчитайте число элементов в созданной коллекции
db.tags.count()

# - подсчитайте число фильмов с конкретным тегом - `woman`
db.tags.count({'name': 'woman'})

# - используя группировку данных ($groupby) вывести top-3 самых распространённых тегов
db.tags.aggregate([{$group: {_id: "$name", tag_count: { $sum: 1 }}},{$sort:{tag_count: -1}},{$limit: 5}])





