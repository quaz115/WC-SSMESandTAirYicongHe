
import os
import numpy  as np
import pandas as pd

from functions.f_write_mmss import write_mmss

# OPEN AND PRINT PARAMETERS:
# =============================================================================
# >> MAKE COPY:
os.system('cd ./data/; cp d.FITS.xlsx d.FITS.COPY.xlsx')

# >> READ:
df = pd.read_excel('./data/d.FITS.xlsx')

# >> MODIFY:
# && NOTE: FOR ISOPRENE LOW-NOx.
#df.at[6,'pLOSS'] = np.exp(-0.1)

print(df)

# OPEN FILES:
# =============================================================================
# >> REFRESH:
f1 = open('eqn.TOTAL.LOW-NOx','w').close()
f2 = open('eqn.TOTAL.HIGH-NOx','w').close()

# >> OPEN:
f1 = open('eqn.TOTAL.LOW-NOx','a')
f2 = open('eqn.TOTAL.HIGH-NOx','a')

# EQNS FOR ALPHA-PINENE:
# =============================================================================
# >> LOW-NOx:
row = tuple(df.values[0,2:])
# &&
write_mmss(*row, VOC='TERP', CSAT=7.4, kOH=8.26e-11, kRXN=None, MW=136.2, OFFSET=289, FILE=f1)

# >> HIGH-NOx:
row = tuple(df.values[1,2:])
# &&
write_mmss(*row, VOC='TERP', CSAT=7.4, kOH=8.26e-11, kRXN=None, MW=136.2, OFFSET=289, FILE=f2)

# EQNS FOR TOLUENE:
# NOTE: THE kOH VALUE IS FOR LUMPED MONOTERPENE SPECIES.
# =============================================================================
# >> LOW-NOx:
row = tuple(df.values[2,2:])
# &&
write_mmss(*row, VOC='ARO1', CSAT=8.1, kOH=5.63e-12, kRXN=None, MW=92.1, OFFSET=289, FILE=f1)

# >> HIGH-NOx:
row = tuple(df.values[3,2:])
# &&
write_mmss(*row, VOC='ARO1', CSAT=8.1, kOH=5.63e-12, kRXN=None, MW=92.1, OFFSET=289, FILE=f2)

# EQNS FOR M-XYLENE:
# =============================================================================
# >> LOW-NOx:
row = tuple(df.values[4,2:])
# &&
write_mmss(*row, VOC='ARO2', CSAT=7.6, kOH=2.31e-11, kRXN=None, MW=106.2, OFFSET=289, FILE=f1)

# >> HIGH-NOx:
row = tuple(df.values[5,2:])
# &&
write_mmss(*row, VOC='ARO2', CSAT=7.6, kOH=2.31e-11, kRXN=None, MW=106.2, OFFSET=289, FILE=f2)

# EQNS FOR ISOPRENE:
# =============================================================================
# >> LOW-NOx:
row = tuple(df.values[6,2:])
# &&
write_mmss(*row, VOC='ISPR', CSAT=9.3, kOH=1.00e-10, kRXN=None, MW=68.1, OFFSET=289, FILE=f1)

# >> HIGH-NOx:
row = tuple(df.values[7,2:])
# &&
write_mmss(*row, VOC='ISPR', CSAT=9.3, kOH=1.00e-10, kRXN=None, MW=68.1, OFFSET=289, FILE=f2)

# EQNS FOR BETA-CARYOPHELLENE:
# NOTE: THE kOH VALUE IS FOR LUMPED SESQUITERPENE SPECIES.
# =============================================================================
# >> LOW-NOx:
row = tuple(df.values[10,2:])
# &&
write_mmss(*row, VOC='SESQ', CSAT=5.1, kOH=6.80e-11, kRXN=None, MW=204.4, OFFSET=289, FILE=f1)

# >> HIGH-NOx:
row = tuple(df.values[11,2:])
# &&
write_mmss(*row, VOC='SESQ', CSAT=5.1, kOH=6.80e-11, kRXN=None, MW=204.4, OFFSET=289, FILE=f2)

# EQNS FOR N-PENTADECANE:
# =============================================================================
# >> LOW-NOx:
# NOTE: PENTADECANE; kOH FROM ATKINSON AND AREY, 2003.
# NOTE: CSAT FROM PUBCHEM.
row = tuple(df.values[8,2:])
# &&
write_mmss(*row, VOC='IVO1', CSAT=4.6, kOH=2.10e-11, kRXN=None, MW=212.4, OFFSET=289, FILE=f1)

# >> HIGH-NOx:
row = tuple(df.values[9,2:])
# &&
write_mmss(*row, VOC='IVO1', CSAT=4.6, kOH=2.10e-11, kRXN=None, MW=212.4, OFFSET=289, FILE=f2)

# CLOSE FILES:
# =============================================================================
f1.close()
f2.close()


