with recursive descendant(parent,child) as (
    select parent,child from parent_of
    union
    select D.parent,P.child
        from descendant D,parent_of P
        where D.child=P.parent)

select D.parent ancestor,
    P1.gender,
    count(*) num_descendants
from descendant D,person P1
where D.child=P1.name
group by ancestor,gender
order by ancestor,gender,num_descendants;
