!     =======================================================================
!               THIS SUBROUINTE STEPS FORWARD FOR SOA CONDENSATION
!     =======================================================================
!     NOTE: CONCENTRATIONS KEPT IN [nmol m-3].

      MODULE mod_STEP_SOACOND
      
!     MODULE INTERFACE:
!     =======================================================================      
!     POINTERS FOR CHEM IN WRF:
      USE mod_SSMOSAIC_PARAMS, ONLY: CSAT, PI, MW_SS
      
      CONTAINS
      
!     =======================================================================
!               THIS SUBROUINTE STEPS FORWARD FOR SOA CONDENSATION
!     =======================================================================
      
      SUBROUTINE STEP_SOACOND(moGAS, moAERO, moOLIG, nCOMP, nBINS, DIAM, NUM, DIFFb, Temp, mmdt)
      
!     DECLARATIONS:
!     =======================================================================
      IMPLICIT NONE
      
!     NUMBER OF GAS SPECIES AND
!     AEROSOL BINS:
      INTEGER,INTENT(IN) :: nCOMP
      INTEGER,INTENT(IN) :: nBINS

!     GAS- AND AERSOL-PHASE
!     ARRAYS:
      REAL(8),INTENT(INOUT) :: moGAS(nCOMP)
      REAL(8),INTENT(INOUT) :: moAERO(nCOMP,nBINS)
      REAL(8),INTENT(INOUT) :: moOLIG(nCOMP,nBINS)

!     AEROSOl SIZE BIN DIAMETERS [nm]:
      REAL(8),DIMENSION(nBINS),INTENT(INOUT) :: DIAM

!     AEROSOL NUMBER CONC. [cm-3]:
      REAL(8),DIMENSION(nBINS),INTENT(IN) :: NUM

!     INTEGRATION TIMESTEP:
      REAL(8),INTENT(IN) :: mmdt

!     COUNTERS:
      INTEGER :: i,j,k

!     SATURATION RATIO:
      REAL(8),DIMENSION(nBINS) :: SRATIO
      
!     GAS- AND PARTICLE-PHASE 
!     MASS-TRANSFER COEFF. [m s-1]:
      REAL(8) :: KTg
      REAL(8) :: KTp

!     CONDENSATION SINK [s-1]:
      REAL(8),DIMENSION(nBINS) :: CONDSINK
      
!     GAS- AND PARTICLE-PHASE
!     DIFFUSIVITIES [m2 s-1]:
      REAL(8) :: DIFFg != 4e-6
      REAL(8) :: DIFFb

!     TEMPERATURE [K]:
      REAL(8) :: Temp

      REAL(8) :: CSATi

!     FOR INTEGRATION:      
      REAL(8) :: TOT, SUM1, SUM2
      REAL(8) :: GAS_NEXT
      REAL(8) :: AERO_NEXT(nBINS)      

!     EQUIVALENT DIAMETER 
!     OF THE ORGANIC PHASE [m]:
      REAL(8) :: oeDIAM

!     ORGANIC AEROSOL DENSITY [kg m-3]:
      REAL :: RHO_ORG = 1400.

!     ENTHALPY OF EVAPORATION [kJ mol-1]:
      REAL(8) :: dHVAP
      
      REAL(8),PARAMETER :: PI = 3.1415926

      REAL(8) :: MS
      REAL(8) :: MFP
      REAL(8) :: KNUD
      REAL(8) :: FUCHS

      REAL(8) :: aCOMM = 1.0

!     STEP FORWARD:
!     =======================================================================
      LOOP1: DO j = 1,nCOMP
      
!     >> ENTHALPY OF EVAPORATION:
      dHVAP = 131.0 - 11.0*LOG10(CSAT(j))

!     >> GET SATURATION CONC.
!     && AT CURRENT TEMPERATURE:
!     && NOTE: UNITS FROM [ug m-3] TO [nmol m-3].
      CSATi = CSAT(j)*EXP(dHVAP*1000./8.314*(1./298. - 1./Temp))
!     &&  
      CSATi = CSATi*1e3/MW_SS(j)

!     >> SATURATION RATIO:
!     NOTE: ASSUME BACKGROUND OA MASS?
      DO k = 1,nBINS
         SRATIO(k) = CSATi/MAX(1e-3, SUM(moAERO(:,k)))
      END DO

!     >> CONDENSATION SINK:
      LOOP2: DO k = 1,nBINS

!        ^^ EFFECTIVE DIAMETER
!        && OF THE ORGANIC PHASE: 
!        && NOTE: UNUSED FOR NOW.
         oeDIAM = 6./PI* &
         (((SUM(moAERO(:,k)*MW_SS*1e-3) + SUM(moOLIG(:,k)*MW_SS*1e-3))*1e-9*1e-6/NUM(k)/RHO_ORG)**(1./3.))
!        &&         
         oeDIAM = MAX(1e-9,oeDIAM)

!        ^^ MOLECULAR MEAN SPEED [m s-1]:
         MS = SQRT(8.0*8.314*Temp/(PI*MW_SS(j)*1e-03))

!        ^^ MEAN FREE PATH [m]:
         MFP = 3.0*DIFFg/MS

!        ^^ KNUDSEN NUMBER:
         KNUD = 2.0*MFP/(DIAM(k)*1e-9)

!        ^^ FUCHS-SUTUGIN CORRECTION:
         FUCHS = 0.75*aCOMM*(1.0 + KNUD)/(KNUD*(KNUD + 1.0) + 0.283*aCOMM*KNUD + 0.75*aCOMM)

!        ^^ GAS-PHASE DIFFUSIVITY [m2 s-1]:
         DIFFg = 1.38e-4*44.0/MW_SS(j)

!        ^^ GET THE CONDENSATION SINK:
         KTg = DIFFg/(0.5*DIAM(k)*1e-9)*FUCHS
         KTp = DIFFb/(0.5*DIAM(k)*1e-9)*5.0
!        &&         
         CONDSINK(k) = & 
         1.0/(1.0/KTg + 1.0/KTp*CSATi/(RHO_ORG*1e9))* &
         NUM(k)*1e6*PI*((DIAM(k)*1e-9)**2.0)

      END DO LOOP2
      
!     >> TOTAL SPECIES MASS:
      TOT = moGAS(j) + SUM(moAERO(j,1:nBINS))

!     >> CALCULATE SUM TERMS:
      SUM1 = 0.0
      SUM2 = 0.0

      DO k = 1,nBINS
         SUM1 = &
         SUM1 + moAERO(j,k)/(1.0 + mmdt*CONDSINK(k)*SRATIO(k))

         SUM2 = &
         SUM2 + mmdt*CONDSINK(k)/(1.0 + mmdt*CONDSINK(k)*SRATIO(k))
      END DO      

!     >> GAS AT NEXT TIMESTEP:
      GAS_NEXT = (TOT - SUM1)/(1.0 + SUM2)

!     >> AEROSOL AT NEXT TIMESTEP:
      DO k = 1,nBINS
         AERO_NEXT(k) = (moAERO(j,k) + mmdt*CONDSINK(k)*GAS_NEXT)/ &
                        (1.0 + mmdt*CONDSINK(k)*SRATIO(k))
      END DO

!     >> UPDATE GAS AND AERO ARRAYS:
      moGAS(j) = GAS_NEXT
!     && 
      DO k = 1,nBINS
         moAERO(j,k) = AERO_NEXT(k)
      END DO
      
      END DO LOOP1 ! END LOOP OVER COMPONENTS.
      
      RETURN
      END SUBROUTINE STEP_SOACOND
      
      END MODULE mod_STEP_SOACOND
