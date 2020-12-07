4a
select I.iname
from Ingredients I
where I.unit_cost<1 or I.iname not in
(select iname from Recipes);


4b
select C.cname,C.price,Cost.cost total_cost
from
Cocktails C join
(select R.cname,sum(I.unit_cost*R.units) as cost
from Recipes R,Ingredients I
where I.iname=R.iname
group by R.cname) Cost
on
C.cname=Cost.cname
where C.price>=Cost.cost*2
;

4c
select C.cname,C.price-Cost.cost as profit
from
Cocktails C join
(select R.cname,sum(I.unit_cost*R.units) as cost,count(R.iname)
from Recipes R,Ingredients I
where I.iname=R.iname
group by R.cname
having count(R.iname)>=2) Cost
on
C.cname=Cost.cname
;

4d
select R1.cname cname1,R2.cname cname2,R1.iname
from Recipes R1,Recipes R2
where R1.cname<R2.cname and R1.iname=R2.iname
order by R1.cname,R2.cname
;

