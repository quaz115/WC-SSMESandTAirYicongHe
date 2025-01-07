!     =======================================================================
!               THIS SUBROUINTE STEPS FORWARD FOR OLIGOMERIZATION
!     =======================================================================
!     NOTE: THIS SUBROUTINE ACCOUNTS FOR TERP ONLY NOW.

      MODULE mod_STEP_OLIG
      
!     MODULE INTERFACE:
!     =======================================================================
      USE mod_SSMOSAIC_PARAMS, ONLY: MW_SS, NAVO, PI
      
      CONTAINS
      
!     =======================================================================
!               THIS SUBROUINTE STEPS FORWARD FOR OLIGOMERIZATION
!     =======================================================================
      
      SUBROUTINE STEP_OLIG(moAERO, moOLIG, nCOMP, nBINS, DIAM, NUM, kf, kr, mmdt)
      
!     DECLARATIONS:
!     =======================================================================
      IMPLICIT NONE
      
!     NUMBER OF GAS SPECIES AND
!     AEROSOL BINS:
      INTEGER,INTENT(IN) :: nCOMP
      INTEGER,INTENT(IN) :: nBINS

!     AERSOL-PHASE MONOMER AND
!     OLIGOMER ARRAYS:
      REAL(8),INTENT(INOUT) :: moAERO(nCOMP,nBINS)
      REAL(8),INTENT(INOUT) :: moOLIG(nCOMP,nBINS)

!     AERSOL-PHASE MONOMER AND
!     OLIGOMER ARRAYS [cm-3]:     
      REAL(8) :: jkAERO(nCOMP,nBINS)
      REAL(8) :: jkOLIG(nCOMP,nBINS)
      REAL(8) :: jkTOTO(nCOMP,nBINS)      

      REAL(8) :: jkAERO_NXT(nCOMP,nBINS)
      REAL(8) :: jkOLIG_NXT(nCOMP,nBINS)

      REAL(8) :: kAERO(nBINS)

!     AEROSOL NUMBER CONC. [cm-3]:
      REAL(8),INTENT(IN) :: NUM(nBINS)

!     AEROSOL DIAMETER [nm]:
      REAL(8),INTENT(IN) :: DIAM(nBINS)

!     ORGANIC AEROSOL DENSITY [kg m-3]:
      REAL(8) :: RHO_ORG = 1400.
      
!     OLIGOMERIZATION FORMATION AND
!     DISSOCIATION RATES:
      REAL(8),INTENT(IN) :: kf
      REAL(8),INTENT(IN) :: kr

!     EFFECTIVE FORMATION 
!     RATE [cm3 s-1]:
      REAL(8) :: kf_EFF(nBINS)

!     INTEGRATION TIMESTEP:
      REAL(8),INTENT(IN) :: mmdt

!     COUNTERS:
      INTEGER :: i,j,k

      REAL(8) :: MASS1, MASS2
            
!     CONVERT UNITS AND MAP-IN:
!     =======================================================================
!     NOTE: UNITS FROM [nmol m-3] TO [mol cm-3].

      jkAERO(:,:) = 0.0
      jkOLIG(:,:) = 0.0

      DO j = 1,nCOMP-1
      DO k = 1,nBINS
         jkAERO(j,k) = moAERO(j,k)*1e-9*1e-6
         jkOLIG(j,k) = moOLIG(j,k)*1e-9*1e-6
      END DO
      END DO
      
!     EFFECTIVE OLIGOMERIZATION RATE:
!     =======================================================================
      DO k = 1,nBINS

!        >> MASSES IN [ug m-3]:
         MASS1 = SUM(moAERO(:,k)*MW_SS*1e-3)
         MASS2 = SUM(moOLIG(:,k)*MW_SS*1e-3)

!        >> FIND RATE:
         kf_EFF(k) = &
         kf*NAVO/((MASS1 + MASS1)*1e-9/RHO_ORG)

      END DO

!     STEP FORWARD:
!     =======================================================================
      kAERO = SUM(jkAERO,1)

      jkAERO_NXT(:,:) = 0.0
      jkOLIG_NXT(:,:) = 0.0
      
      DO j = 1,nCOMP-1
      DO k = 1,nBINS
         jkTOTO(j,k) = jkAERO(j,k) + jkOLIG(j,k)
      END DO
      END DO

      DO j = 1,nCOMP-1
      DO k = 1,nBINS
        jkAERO_NXT(j,k) = (jkAERO(j,k) + mmdt*0.5*kr*jkTOTO(j,k))/ &
                          (1.0 + mmdt*kf_EFF(k)*kAERO(k) + mmdt*0.5*kr)

        jkOLIG_NXT(j,k) = (jkTOTO(j,k)*(1.0 + mmdt*kf_EFF(k)*kAERO(k)) - jkAERO(j,k))/ &
                          (1.0 + mmdt*kf_EFF(k)*kAERO(k) + mmdt*0.5*kr)
      END DO
      END DO

!     CONVERT UNITS AND MAP-OUT:
!     =======================================================================
!     NOTE: THIS ACCOUNTS FOR ONLY TERP FOR NOW. VERY IMPORTANT!!!

      DO j = 1,nCOMP-1
      DO k = 1,nBINS


!!!   YICONG HE: UPDATED         
!!         IF (j.LE.13) THEN
            moAERO(j,k) = jkAERO_NXT(j,k)/(1e-9*1e-6) 
            moOLIG(j,k) = jkOLIG_NXT(j,k)/(1e-9*1e-6)
!!         END IF

      END DO
      END DO      
      
      RETURN
      END SUBROUTINE STEP_OLIG
      
      END MODULE mod_STEP_OLIG
