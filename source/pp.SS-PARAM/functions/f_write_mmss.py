'''=====================================================================
         THIS FUNCTION WRITES THE MECHANISM AND SPECIES FILES
====================================================================='''

import math
import numpy  as np
import pandas as pd

def write_mmss(mFRAG,dLVP,fLOSS,pHOM,pO1,pO2,pO3,pO4, \
               VOC=None,CSAT=None,kOH=None,kRXN=None,MW=None,OFFSET=None,FILE=None):

    # DIAGNOSTICS:
    # ==================================================================
    if kRXN != None: print('REPORT: FOR %s kRXN = %.2e'%(VOC,kRXN))

    # NORMALIZE PARAMETERS:
    # ==================================================================
    pNORM = [i/sum([pO1,pO2,pO3,pO4])*(1.0 - pHOM) for i in [pO1,pO2,pO3,pO4]]

    pO1 = pNORM[0]
    pO2 = pNORM[1]
    pO3 = pNORM[2]
    pO4 = pNORM[3]
    
    # VOLATILITY DIST. OF ADDING 1, 2, 3 or 4 OXYGENS:
    # ==================================================================
    SIGMAX = 1.

    DIST_pO1 = np.array([np.exp(-(1.*dLVP-(i+1))**2./SIGMAX) for i in range(2)])
    DIST_pO2 = np.array([np.exp(-(2.*dLVP-(i+2))**2./SIGMAX) for i in range(3)])
    DIST_pO3 = np.array([np.exp(-(3.*dLVP-(i+3))**2./SIGMAX) for i in range(4)])
    DIST_pO4 = np.array([np.exp(-(4.*dLVP-(i+4))**2./SIGMAX) for i in range(5)])
    
    DIST_pO1 = DIST_pO1/np.sum(DIST_pO1)
    DIST_pO2 = DIST_pO2/np.sum(DIST_pO2)
    DIST_pO3 = DIST_pO3/np.sum(DIST_pO3)
    DIST_pO4 = DIST_pO4/np.sum(DIST_pO4)
    
    # GENERIC FUNCTIONALIZATION DISTRIBUTION:
    # ==================================================================
    nFRAG = 2
    nFUNC = 8

    CHEMDIST_SOM = np.zeros(nFUNC+1+nFRAG)

    CHEMDIST_SOM[nFRAG]   = 0.
    CHEMDIST_SOM[nFRAG+1] = pO1*DIST_pO1[0]
    CHEMDIST_SOM[nFRAG+2] = pO1*DIST_pO1[1] + pO2*DIST_pO2[0]
    CHEMDIST_SOM[nFRAG+3] = pO2*DIST_pO2[1] + pO3*DIST_pO3[0]
    CHEMDIST_SOM[nFRAG+4] = pO2*DIST_pO2[2] + pO3*DIST_pO3[1] + pO4*DIST_pO4[0]
    CHEMDIST_SOM[nFRAG+5] = pO3*DIST_pO3[2] + pO4*DIST_pO4[1]
    CHEMDIST_SOM[nFRAG+6] = pO3*DIST_pO3[3] + pO4*DIST_pO4[2]
    CHEMDIST_SOM[nFRAG+7] = pO4*DIST_pO4[3]
    CHEMDIST_SOM[nFRAG+8] = pO4*DIST_pO4[4]
    
    # FRAGMENTATION PROBABILITY:
    # ==================================================================
    maxCSAT = 9
    minCSAT = -3
    nCOMP   = maxCSAT - minCSAT + 1
    
    # SATURATION CONC.:
    j_CSATLOG = np.arange(maxCSAT,minCSAT-1,-1)

    # FRAG. PROB.:
    j_PFRAG = 1. - np.exp(mFRAG*(j_CSATLOG - maxCSAT)/maxCSAT)
    
    # SPLIT THE PRECURSOR:
    # ==================================================================
    # INDEXEs:
    DEX_H = maxCSAT - round(CSAT)
    DEX_L = DEX_H + 1

    # FRACTIONs:
    FRAC_H = 1. - math.ceil(CSAT) + CSAT
    FRAC_L = 1. - FRAC_H

    # MOLECULAR WEIGHT OF SIMPLESOM SPECIES:
    # NOTE: INCREASE BY 14 [g mol-1] PER DECADE DROP IN C*.
    # ==================================================================
    #j_MW = MW - 14*(j_CSATLOG - j_CSATLOG[0])
    
    # PROB. DISTRIBUTION FOR ALL SPECIES:
    # ==================================================================
    CHEMDIST_SOM_MATRIX = np.zeros((nFUNC+1+nFRAG,nCOMP))
    
    for j in range(nCOMP):
        
        for jj in range(nFRAG+1,nFUNC+1+nFRAG):
            CHEMDIST_SOM_MATRIX[jj,j] = CHEMDIST_SOM[jj]*(1. - j_PFRAG[j])
            
        for jj in range(nFRAG):
            CHEMDIST_SOM_MATRIX[jj,j] = j_PFRAG[j]/float(nFRAG)*(1. - fLOSS)
    
    # GAS-PHASE CHEMISTRY KERNEL:
    # ==================================================================
    jj_CHEMKERNEL_SOM = np.zeros((nCOMP,nCOMP))

    for j in range(nCOMP):

        SLICE_SOM = CHEMDIST_SOM_MATRIX[:,j]

        for k in range(nFRAG):
            if ((j-k-1)<0):
                pass
            else:
                jj_CHEMKERNEL_SOM[j-k-1,j] = SLICE_SOM[nFRAG-k-1]

        for k in range(nFUNC):
            if ((j+k+1)<nCOMP-1):
                jj_CHEMKERNEL_SOM[j+k+1,j] = SLICE_SOM[nFRAG+k+1]
            else:
                jj_CHEMKERNEL_SOM[nCOMP-1,j] += SLICE_SOM[nFRAG+k+1]

    # ADD HOM FORMATION:
    jj_CHEMKERNEL_SOM[nCOMP-1,:] += pHOM * (1 - j_PFRAG)
    
    # OH-OXIDATION REACTION RATES:
    # ==================================================================
    kxA =  1.56341E-13
    kxB = -7.12119E-13
    kxC = -8.22305E-12
    kxD = -5.62410E-13
    kxE = -5.69473E-13
    kxF =  6.62928E-11

    j_kRXN = (kxA*dLVP + kxD)*(j_CSATLOG**2) + (kxB*dLVP + kxE)*j_CSATLOG + (kxC*dLVP + kxF)
        
    if kRXN != None: j_kRXN = np.ones(nCOMP)*kRXN

    # WRITE THE EQUATIONs FOR THE VBS SPECIEs:
    # ==================================================================
    # >> WRITE BLANK LINES:
    FILE.write('\n'*2)

    # >> SUFFIXs:
    SUFFs = ['C%02i'%i if i >= 0 else 'CN%01i'%(-i) \
             for i in reversed(range(minCSAT,maxCSAT+1))]
    
    # >> SIMPLE-SOM SPECIES NAMES:
    NAMEs = ['%s_%s_g'%(VOC,i) for i in SUFFs]
    
    # >> WRITE THE VBS SPECIEs:
    for i in range(nCOMP):

        # >>> REACTIONS:
        PP1 = '{%i} %s + OH = OH + '%(OFFSET+i,NAMEs[i])

        # >>> COEFFICIENTS:
        # ... NOTE: THE COEFFICIENTS ARE SCALED.
        COEFFs = ['%.3f'%j for j in jj_CHEMKERNEL_SOM[:,i]]
        
        # >>> COMBINE TO WRITE PRODUCTS:
        PP2 = ' + '.join([ee+nn for j,(ee,nn) in enumerate(zip(COEFFs,NAMEs))])
        
        # >>> RATE COEFFICIENTS:
        PP3 = (' : %.2e ;\n\n'%j_kRXN[i]).replace('e-','D-')
        
        # >>> WRITE TO FILE:
        FILE.write(PP1 + PP2 + PP3)
                
    # WRITE THE EQUATIONS FOR THE PRECURSOR:
    # ==================================================================
    # >> REACTIONS:    
    PP1 = '{%i} %s + OH = OH + %s + '%(OFFSET+nCOMP,VOC,VOC)    
    
    # >> HOM ARRAY:
    HOMs = np.zeros(nCOMP); HOMs[-1] = pHOM

    # >> COEFFICIENTS:
    COEFFs = ['%.3f'%j for j in \
              (jj_CHEMKERNEL_SOM[:,DEX_H]*(1-pHOM) + HOMs)*FRAC_H + \
              (jj_CHEMKERNEL_SOM[:,DEX_L]*(1-pHOM) + HOMs)*FRAC_L]
    
    # >> COMBINE TO WRITE PRODUCTS:
    PP2 = ' + '.join([ee+nn for j,(ee,nn) in enumerate(zip(COEFFs,NAMEs))])

    # >> RATE COEFFICIENTS:
    PP3 = (' : %.2e ;\n\n'%kOH).replace('e-','D-')

    # >> WRITE TO FILE:
    FILE.write(PP1 + PP2 + PP3)


