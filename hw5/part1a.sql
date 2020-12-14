with recursive descendant(parent,child) as (
    select parent,child from parent_of
    union
    select D.parent,P.child
        from descendant D,parent_of P
        where D.child=P.parent)
select parent ancestor,child descendant from descendant D,person P1,person P2
where D.parent=P1.name and D.child=P2.name and P1.gender=P2.gender
order by ancestor,descendant;
