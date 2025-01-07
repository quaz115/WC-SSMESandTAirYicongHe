
     PROGRAM TEST

     CALL RUNME()

     CALL RUNME()

     CALL RUNME()

     END PROGRAM TEST


     SUBROUTINE RUNME
       
     INTEGER,SAVE :: CTR
     
     CTR = CTR + 1

     PRINT*, "CTR = ", CTR
     
     RETURN
     END SUBROUTINE RUNME
