

     PROGRAM TEST
       
     INTEGER,TARGET :: AA(5) = (/1,2,3,4,5/)
     INTEGER,TARGET :: BB(5)

     INTEGER,POINTER :: PP(:)
     
     PRINT*, AA

     PP => AA

     PP(3) = 9

     PRINT*, AA


     PRINT*, 'HERE'
     END PROGRAM TEST
