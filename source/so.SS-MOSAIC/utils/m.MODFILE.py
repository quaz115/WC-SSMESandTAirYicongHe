
import re

f1 = open('./sub.map_inout.f90','r')

TEXT0 = f1.read()

f1.close()




TEXT1 = re.sub('REAL\((moGAS\(\d+\))\)\/(CONV1\(\d+\))', 'REAL(\g<1>/\g<2>)', TEXT0)

TEXT2 = re.sub('REAL\(((?:moAERO|moOLIG)\(\d+\,\d+\))\)\/(CONV2)', 'REAL(\g<1>/\g<2>)', TEXT1)

TEXT3 = re.sub('REAL\((NUM\(\d+\))\)\/(CONV3)', 'REAL(\g<1>/\g<2>)', TEXT2)


f1 = open('./sub.map_inout.NEW.f90','w')

f1.write(TEXT3)

f1.close()


#print(TEXT)
