! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
! 
! Parameter Module File
! 
! Generated by KPP-2.1 symbolic chemistry Kinetics PreProcessor
!       (http://www.cs.vt.edu/~asandu/Software/KPP)
! KPP is distributed under GPL, the general public licence
!       (http://www.gnu.org/copyleft/gpl.html)
! (C) 1995-1997, V. Damian & A. Sandu, CGRER, Univ. Iowa
! (C) 1997-2005, A. Sandu, Michigan Tech, Virginia Tech
!     With important contributions from:
!        M. Damian, Villanova University, USA
!        R. Sander, Max-Planck Institute for Chemistry, Mainz, Germany
! 
! File                 : saprc99_simplesom_mosaic_4bin_aq_Parameters.f90
! Time                 : Mon Aug 12 14:38:50 2024
! Working directory    : /public2/home/tsinghuazhangff/tsinghuazhangh/yicongh/exps/x.WRF-CHEM.SSM/x.WRF-CHEM.SSM.4BIN.HIGH-NOx.DIFFg/chem/KPP/mechanisms/saprc99_simplesom_mosaic_4bin_aq
! Equation file        : saprc99_simplesom_mosaic_4bin_aq.kpp
! Output root filename : saprc99_simplesom_mosaic_4bin_aq
! 
! ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~



MODULE saprc99_simplesom_mosaic_4bin_aq_Parameters

  USE saprc99_simplesom_mosaic_4bin_aq_Precision
  PUBLIC
  SAVE


! NSPEC - Number of chemical species
  INTEGER, PARAMETER :: NSPEC = 172 
! NVAR - Number of Variable species
  INTEGER, PARAMETER :: NVAR = 170 
! NVARACT - Number of Active species
  INTEGER, PARAMETER :: NVARACT = 156 
! NFIX - Number of Fixed species
  INTEGER, PARAMETER :: NFIX = 2 
! NREACT - Number of reactions
  INTEGER, PARAMETER :: NREACT = 318 
! NVARST - Starting of variables in conc. vect.
  INTEGER, PARAMETER :: NVARST = 1 
! NFIXST - Starting of fixed in conc. vect.
  INTEGER, PARAMETER :: NFIXST = 171 
! NONZERO - Number of nonzero entries in Jacobian
  INTEGER, PARAMETER :: NONZERO = 1727 
! LU_NONZERO - Number of nonzero entries in LU factoriz. of Jacobian
  INTEGER, PARAMETER :: LU_NONZERO = 1820 
! CNVAR - (NVAR+1) Number of elements in compressed row format
  INTEGER, PARAMETER :: CNVAR = 171 
! NLOOKAT - Number of species to look at
  INTEGER, PARAMETER :: NLOOKAT = 0 
! NMONITOR - Number of species to monitor
  INTEGER, PARAMETER :: NMONITOR = 0 
! NMASS - Number of atoms to check mass balance
  INTEGER, PARAMETER :: NMASS = 1 
! PI - Value of pi
  REAL(kind=dp), PARAMETER :: PI = 3.14159265358979 

! Index declaration for variable species in C and VAR
!   VAR(ind_spc) = C(ind_spc)

  INTEGER, PARAMETER :: ind_IVO1 = 1 
  INTEGER, PARAMETER :: ind_H2SO4 = 2 
  INTEGER, PARAMETER :: ind_HCOOH = 3 
  INTEGER, PARAMETER :: ind_CCO_OH = 4 
  INTEGER, PARAMETER :: ind_RCO_OH = 5 
  INTEGER, PARAMETER :: ind_CO2 = 6 
  INTEGER, PARAMETER :: ind_CCO_OOH = 7 
  INTEGER, PARAMETER :: ind_RCO_OOH = 8 
  INTEGER, PARAMETER :: ind_XN = 9 
  INTEGER, PARAMETER :: ind_XC = 10 
  INTEGER, PARAMETER :: ind_NUME = 11 
  INTEGER, PARAMETER :: ind_DEN = 12 
  INTEGER, PARAMETER :: ind_ANT2_o = 13 
  INTEGER, PARAMETER :: ind_ANT3_o = 14 
  INTEGER, PARAMETER :: ind_PSD1 = 15 
  INTEGER, PARAMETER :: ind_ISOP2O2 = 16 
  INTEGER, PARAMETER :: ind_IEPOX = 17 
  INTEGER, PARAMETER :: ind_TETROL = 18 
  INTEGER, PARAMETER :: ind_O1D = 19 
  INTEGER, PARAMETER :: ind_CH4 = 20 
  INTEGER, PARAMETER :: ind_ISOPOOH = 21 
  INTEGER, PARAMETER :: ind_ISOPOO = 22 
  INTEGER, PARAMETER :: ind_C2H6 = 23 
  INTEGER, PARAMETER :: ind_PAN = 24 
  INTEGER, PARAMETER :: ind_PAN2 = 25 
  INTEGER, PARAMETER :: ind_PBZN = 26 
  INTEGER, PARAMETER :: ind_MA_PAN = 27 
  INTEGER, PARAMETER :: ind_H2O2 = 28 
  INTEGER, PARAMETER :: ind_BACL = 29 
  INTEGER, PARAMETER :: ind_C3H8 = 30 
  INTEGER, PARAMETER :: ind_ETOH = 31 
  INTEGER, PARAMETER :: ind_N2O5 = 32 
  INTEGER, PARAMETER :: ind_SO2 = 33 
  INTEGER, PARAMETER :: ind_HONO = 34 
  INTEGER, PARAMETER :: ind_DMS = 35 
  INTEGER, PARAMETER :: ind_ALK3 = 36 
  INTEGER, PARAMETER :: ind_TBU_O = 37 
  INTEGER, PARAMETER :: ind_ALK5 = 38 
  INTEGER, PARAMETER :: ind_MEOH = 39 
  INTEGER, PARAMETER :: ind_COOH = 40 
  INTEGER, PARAMETER :: ind_HOCOO = 41 
  INTEGER, PARAMETER :: ind_BZNO2_O = 42 
  INTEGER, PARAMETER :: ind_HNO4 = 43 
  INTEGER, PARAMETER :: ind_ALK4 = 44 
  INTEGER, PARAMETER :: ind_C2H2 = 45 
  INTEGER, PARAMETER :: ind_NPHE = 46 
  INTEGER, PARAMETER :: ind_ROOH = 47 
  INTEGER, PARAMETER :: ind_ARO1_CN3_g = 48 
  INTEGER, PARAMETER :: ind_ARO2_CN3_g = 49 
  INTEGER, PARAMETER :: ind_IVO1_CN3_g = 50 
  INTEGER, PARAMETER :: ind_TERP_CN3_g = 51 
  INTEGER, PARAMETER :: ind_ARO1_CN2_g = 52 
  INTEGER, PARAMETER :: ind_ARO2_CN2_g = 53 
  INTEGER, PARAMETER :: ind_ARO2_CN1_g = 54 
  INTEGER, PARAMETER :: ind_ISPR_CN3_g = 55 
  INTEGER, PARAMETER :: ind_ISPR_CN2_g = 56 
  INTEGER, PARAMETER :: ind_ISPR_CN1_g = 57 
  INTEGER, PARAMETER :: ind_IVO1_CN2_g = 58 
  INTEGER, PARAMETER :: ind_IVO1_CN1_g = 59 
  INTEGER, PARAMETER :: ind_IVO1_C00_g = 60 
  INTEGER, PARAMETER :: ind_IVO1_C01_g = 61 
  INTEGER, PARAMETER :: ind_IVO1_C02_g = 62 
  INTEGER, PARAMETER :: ind_IVO1_C03_g = 63 
  INTEGER, PARAMETER :: ind_IVO1_C04_g = 64 
  INTEGER, PARAMETER :: ind_IVO1_C05_g = 65 
  INTEGER, PARAMETER :: ind_IVO1_C06_g = 66 
  INTEGER, PARAMETER :: ind_IVO1_C07_g = 67 
  INTEGER, PARAMETER :: ind_IVO1_C08_g = 68 
  INTEGER, PARAMETER :: ind_IVO1_C09_g = 69 
  INTEGER, PARAMETER :: ind_TERP_CN2_g = 70 
  INTEGER, PARAMETER :: ind_TERP_CN1_g = 71 
  INTEGER, PARAMETER :: ind_TERP_C00_g = 72 
  INTEGER, PARAMETER :: ind_TERP_C01_g = 73 
  INTEGER, PARAMETER :: ind_TERP_C02_g = 74 
  INTEGER, PARAMETER :: ind_TERP_C03_g = 75 
  INTEGER, PARAMETER :: ind_TERP_C04_g = 76 
  INTEGER, PARAMETER :: ind_TERP_C05_g = 77 
  INTEGER, PARAMETER :: ind_TERP_C06_g = 78 
  INTEGER, PARAMETER :: ind_TERP_C07_g = 79 
  INTEGER, PARAMETER :: ind_TERP_C08_g = 80 
  INTEGER, PARAMETER :: ind_TERP_C09_g = 81 
  INTEGER, PARAMETER :: ind_ARO1_CN1_g = 82 
  INTEGER, PARAMETER :: ind_ARO1_C00_g = 83 
  INTEGER, PARAMETER :: ind_ARO1_C01_g = 84 
  INTEGER, PARAMETER :: ind_ARO1_C02_g = 85 
  INTEGER, PARAMETER :: ind_ARO1_C03_g = 86 
  INTEGER, PARAMETER :: ind_ARO1_C04_g = 87 
  INTEGER, PARAMETER :: ind_ARO1_C05_g = 88 
  INTEGER, PARAMETER :: ind_ARO1_C06_g = 89 
  INTEGER, PARAMETER :: ind_ARO1_C07_g = 90 
  INTEGER, PARAMETER :: ind_ARO1_C08_g = 91 
  INTEGER, PARAMETER :: ind_ARO1_C09_g = 92 
  INTEGER, PARAMETER :: ind_ARO1 = 93 
  INTEGER, PARAMETER :: ind_CRES = 94 
  INTEGER, PARAMETER :: ind_DCB3 = 95 
  INTEGER, PARAMETER :: ind_DCB2 = 96 
  INTEGER, PARAMETER :: ind_ARO2_C00_g = 97 
  INTEGER, PARAMETER :: ind_ARO2_C01_g = 98 
  INTEGER, PARAMETER :: ind_ARO2_C02_g = 99 
  INTEGER, PARAMETER :: ind_ARO2_C03_g = 100 
  INTEGER, PARAMETER :: ind_ARO2_C04_g = 101 
  INTEGER, PARAMETER :: ind_ARO2_C05_g = 102 
  INTEGER, PARAMETER :: ind_ARO2_C06_g = 103 
  INTEGER, PARAMETER :: ind_ARO2_C07_g = 104 
  INTEGER, PARAMETER :: ind_ARO2_C08_g = 105 
  INTEGER, PARAMETER :: ind_ARO2_C09_g = 106 
  INTEGER, PARAMETER :: ind_ARO2 = 107 
  INTEGER, PARAMETER :: ind_DCB1 = 108 
  INTEGER, PARAMETER :: ind_BALD = 109 
  INTEGER, PARAMETER :: ind_ISPR_C00_g = 110 
  INTEGER, PARAMETER :: ind_ISPR_C01_g = 111 
  INTEGER, PARAMETER :: ind_ISPR_C02_g = 112 
  INTEGER, PARAMETER :: ind_ISPR_C03_g = 113 
  INTEGER, PARAMETER :: ind_ISPR_C04_g = 114 
  INTEGER, PARAMETER :: ind_ISPR_C05_g = 115 
  INTEGER, PARAMETER :: ind_ISPR_C06_g = 116 
  INTEGER, PARAMETER :: ind_ISPR_C07_g = 117 
  INTEGER, PARAMETER :: ind_ISPR_C08_g = 118 
  INTEGER, PARAMETER :: ind_ISPR_C09_g = 119 
  INTEGER, PARAMETER :: ind_SESQ_CN3_g = 120 
  INTEGER, PARAMETER :: ind_SESQ_CN2_g = 121 
  INTEGER, PARAMETER :: ind_SESQ_CN1_g = 122 
  INTEGER, PARAMETER :: ind_SESQ_C00_g = 123 
  INTEGER, PARAMETER :: ind_SESQ_C01_g = 124 
  INTEGER, PARAMETER :: ind_SESQ_C02_g = 125 
  INTEGER, PARAMETER :: ind_SESQ_C03_g = 126 
  INTEGER, PARAMETER :: ind_SESQ_C04_g = 127 
  INTEGER, PARAMETER :: ind_SESQ_C05_g = 128 
  INTEGER, PARAMETER :: ind_SESQ_C09_g = 129 
  INTEGER, PARAMETER :: ind_SESQ_C08_g = 130 
  INTEGER, PARAMETER :: ind_SESQ_C06_g = 131 
  INTEGER, PARAMETER :: ind_SESQ_C07_g = 132 
  INTEGER, PARAMETER :: ind_PHEN = 133 
  INTEGER, PARAMETER :: ind_MGLY = 134 
  INTEGER, PARAMETER :: ind_CO = 135 
  INTEGER, PARAMETER :: ind_HNO3 = 136 
  INTEGER, PARAMETER :: ind_ETHENE = 137 
  INTEGER, PARAMETER :: ind_ACET = 138 
  INTEGER, PARAMETER :: ind_C3H6 = 139 
  INTEGER, PARAMETER :: ind_BZ_O = 140 
  INTEGER, PARAMETER :: ind_OLE1 = 141 
  INTEGER, PARAMETER :: ind_ISPR = 142 
  INTEGER, PARAMETER :: ind_R2O2 = 143 
  INTEGER, PARAMETER :: ind_METHACRO = 144 
  INTEGER, PARAMETER :: ind_SESQ = 145 
  INTEGER, PARAMETER :: ind_TERP = 146 
  INTEGER, PARAMETER :: ind_GLY = 147 
  INTEGER, PARAMETER :: ind_ISOPROD = 148 
  INTEGER, PARAMETER :: ind_OLE2 = 149 
  INTEGER, PARAMETER :: ind_MVK = 150 
  INTEGER, PARAMETER :: ind_CCHO = 151 
  INTEGER, PARAMETER :: ind_HCHO = 152 
  INTEGER, PARAMETER :: ind_RNO3 = 153 
  INTEGER, PARAMETER :: ind_O3P = 154 
  INTEGER, PARAMETER :: ind_RCHO = 155 
  INTEGER, PARAMETER :: ind_MEK = 156 
  INTEGER, PARAMETER :: ind_PROD2 = 157 
  INTEGER, PARAMETER :: ind_O3 = 158 
  INTEGER, PARAMETER :: ind_NO2 = 159 
  INTEGER, PARAMETER :: ind_NO3 = 160 
  INTEGER, PARAMETER :: ind_OH = 161 
  INTEGER, PARAMETER :: ind_CCO_O2 = 162 
  INTEGER, PARAMETER :: ind_RCO_O2 = 163 
  INTEGER, PARAMETER :: ind_C_O2 = 164 
  INTEGER, PARAMETER :: ind_RO2_N = 165 
  INTEGER, PARAMETER :: ind_HO2 = 166 
  INTEGER, PARAMETER :: ind_RO2_R = 167 
  INTEGER, PARAMETER :: ind_BZCO_O2 = 168 
  INTEGER, PARAMETER :: ind_MA_RCO3 = 169 
  INTEGER, PARAMETER :: ind_NO = 170 

! Index declaration for fixed species in C
!   C(ind_spc)

  INTEGER, PARAMETER :: ind_H2O = 171 
  INTEGER, PARAMETER :: ind_M = 172 

! Index declaration for fixed species in FIX
!    FIX(indf_spc) = C(ind_spc) = C(NVAR+indf_spc)

  INTEGER, PARAMETER :: indf_H2O = 1 
  INTEGER, PARAMETER :: indf_M = 2 

END MODULE saprc99_simplesom_mosaic_4bin_aq_Parameters

