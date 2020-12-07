1a
select J.job,J.grade,CS.candidate,count(*) cnt
from Jobs J cross join Candidates_Skills CS,Jobs_Skills JS
where J.job=JS.job and J.grade=JS.grade and JS.skill=CS.skill and CS.years>=JS.years
group by J.job,J.grade,CS.candidate
having count(*)>=2
order by J.job,J.grade;

1b
select P.job,P.grade,P.company,C.candidate,C.salary candidate_salary
from Positions P, Candidates C
where C.salary<=P.salary
order by P.job,P.grade,P.company,C.salary asc;

1c
select JS.skill,JS.years
from (select distinct skill,years from Jobs_Skills) JS left join Candidates_Skills CS
on JS.skill=CS.skill and CS.years>=JS.years
group by (JS.skill,JS.years)
having  count(CS.years)=0;


1d
select JS.skill,max(CS.years) max_years,round(avg(CS.years),1) avg_years,count(CS.years) cnt
from (select distinct skill from Jobs_Skills) JS left join Candidates_Skills CS
on JS.skill=CS.skill
group by JS.skill;

1e
select CA1.candidate candidate1,CA2.candidate candidate2
from
(select C1.candidate candidate,C1.years+C2.years years,C.salary from Candidates_Skills C1 join Candidates_skills C2 on C1.skill='Java' and
C2.skill='DB' and C1.candidate=C2.candidate,Candidates C
where C1.candidate=C.candidate) CA1
cross join
(select C1.candidate candidate,C1.years+C2.years years,C.salary from Candidates_Skills C1 join Candidates_skills C2 on C1.skill='Java' and
C2.skill='DB' and C1.candidate=C2.candidate,Candidates C
where C1.candidate=C.candidate) CA2
where
CA1.years>CA2.years and CA1.salary<CA2.salary
;

1f
select C1.candidate candidate1,C2.candidate candidate2
from
Candidates_Skills C1 cross join Candidates_Skills C2
where
C1.skill='DB' and C1.years>=3 and C2.skill='DB' and C2.years>=3 and C1.candidate<C2.candidate;
