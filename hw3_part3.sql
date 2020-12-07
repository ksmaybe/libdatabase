3a
select distinct D1.dish
from
Dishes D1 join Dishes D2
on D1.dish=D2.dish, Foods F1,Foods F2
where
D1.food=F1.food and F1.category='meat' and D2.food=F2.food and F2.category='veg'
order by D1.dish asc
;

3b
select F1.category
from
Foods F1
where
F1.category not in (
select F.category from
Dishes D join Foods F
on D.food=F.food);


3c
select D.dish,count(D.food) num_ingredients,sum(F.calories) total_calories from
Dishes D join Foods F
on D.food=F.food
group by D.dish;

3d
select D.dish,sum(F.calories) total_calories from
Dishes D join Foods F
on D.food=F.food
group by D.dish
having count(D.food)=3 and sum(F.calories)>=200
;

