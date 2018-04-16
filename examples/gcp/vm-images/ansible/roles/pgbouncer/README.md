## Extract userslist.txt

This should be automated in a task, although I find this pretty nasty to inject.


```sql
        COPY ( 
            SELECT '"' || rolname || '" "' ||  
                   coalesce(rolpassword, '') || '"' 
              FROM pg_authid 
        ) 
        TO '/etc/pgbouncer/userlist.txt'; 
```
