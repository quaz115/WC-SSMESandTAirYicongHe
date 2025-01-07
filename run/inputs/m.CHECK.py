
import numpy  as np
import pandas as pd
import matplotlib.pyplot as plt

import netCDF4 as ncdf

# READ DATA:
# ==================================================================
ds1 = ncdf.Dataset('./in.EMISS/wrfchemi_d02_2014-03-10_00:00:00')

f1 = open('./log','w')

for i,name in enumerate(list(ds1.variables.keys())):
    print(i,name)

    xxx = ds1[name][:]

    if i == 0: continue

    for i in range(np.shape(xxx)[0]):
        for j in range(np.shape(xxx)[1]):
            for k in range(np.shape(xxx)[2]):
                for m in range(np.shape(xxx)[3]):
                    if xxx[i,j,k,m] < 0:
                        f1.write(' %.3e\n'%xxx[i,j,k,m])

    #f1.write('%i %s'%(i,name))

    #f1.write(xxx)

    #print(np.isnan(np.copy(xxx)))


f1.close()

print('HERE')


'''
# READ DATA:
# ==================================================================
LAT = np.load('../data/db.LATnLON/d.DOMAIN-LAT.npy')[0][:,0]
LON = np.load('../data/db.LATnLON/d.DOMAIN-LON.npy')[0][0,:]

# EXTRACT AND SAVE DATA:
# ==================================================================
# PREFIXs:
PREFIX = ['TERP','ARO1','ARO2','ISPR','SESQ','IVO1','pcg1_f_c']

# OA AND DIMER ARRAYs:
OA = np.zeros((len(PREFIX),len(LAT),len(LON)))
DI = np.zeros((len(PREFIX),len(LAT),len(LON)))

# LOOP OVER COMPONENTs:
for i,ppp in enumerate(PREFIX):

    MONO = np.zeros((len(LAT),len(LON)))
    DIME = np.zeros((len(LAT),len(LON)))

    for j,name in enumerate(list(ds2.variables.keys())):
        if '%s_'%ppp in name:
            
            # AVERAGE OVER TIME WINDOW:
            xxx = np.mean(ds2[name][2:5],axis=0)
    
            # SELECT ALTITUDE:
            xxx = np.copy(xxx[9,:,:])
            #xxx = np.mean(np.copy(xxx[0:9,:,:]),axis=0)

            # APPEND OR ADD TO ARRAYs:
            if '_a' in name: MONO = MONO + xxx
            if '_d' in name: DIME = DIME + xxx


    OA[i,:,:] = np.copy(MONO) + np.copy(DIME)
    DI[i,:,:] = np.copy(DIME)

# SAVE DATA:
# ==================================================================
np.save('./outputs/out.SS-MOSAIC.OA.%s.%s.npy'%(ffix,dddd),OA)
np.save('./outputs/out.SS-MOSAIC.DI.%s.%s.npy'%(ffix,dddd),DI)

# MAKE PLOT:
# ==================================================================
plt.figure()
ax = plt.gca()

obj = ax.contourf(np.sum(OA,axis=0))

cbar = plt.colorbar(obj)

plt.show()
'''
