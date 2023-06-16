declare
    cursor c is 
        select * from produto where id in (1,2,3);
begin
    for i in c loop
        update produto set status = 0 where id = i.id;
    end loop;
    commit;
end;