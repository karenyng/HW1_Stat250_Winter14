#!/usr/bin/env python

import pandas as pd
import numpy as np

data_path = "../HW1_Stat250_W14/data/"
# First read in the data from 1987 to 2007
year = [ str(i) for i in range(1987,2008) ]
delay1 = pd.DataFrame()

for yr in year:
    # read in csv file from pandas
    file = yr +'.csv'
    temp = pd.read_csv(data_path + file, usecols=["ArrDelay"])
    delay1 = delay1.append(temp)
    print 'appending '+ file + ' - total lines = ' + \
            '{0}'.format(delay1.shape[0])

delay2 = pd.DataFrame()
year = [ str(i) for i in range(2008, 2013) ]
month = ['January','February', 'March', 'April', 'May', 'June', 'July',
         'August','September', 'October', 'November', 'December']
for yr in year:
    for mth in month:
        file = yr + '_' + mth + '.csv'
        temp = pd.read_csv(data_path + file, usecols=["ARR_DELAY"])
        delay2 = delay2.append(temp)
        print 'appending ' + file + ' - total lines = ' + \
            '{0}'.format(delay2.shape[0] + delay1.shape[0])

# hackish way to remove the column name of the dataframe
delay1 = np.array(delay1)
delay2 = np.array(delay2)
delay = np.append(delay1, delay2)
delay = pd.DataFrame(delay)
print 'total number of valid lines = {0}'.format(delay.dropna().shape[0])

# note that pandas ignores nans automatically while computing stats
print 'mean = {0}'.format(delay[0].mean())
print 'median = {0}'.format(delay[0].median())
print 'std. dev. = {0}'.format(delay[0].std())
print 'saving to results2.txt'
f = open('results2.txt', 'w')
f.write('mean = {0}\n'.format(delay[0].mean()))
f.write('median = {0}\n'.format(delay[0].median()))
f.write('std = {0}\n'.format(delay[0].std()))
f.close()
