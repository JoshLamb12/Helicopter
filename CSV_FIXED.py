from datetime import timedelta
import pandas as pd
import glob
import numpy as np
import time
from os.path import exists

start_time = time.time()

path = "E:\Coding\9_2_2021" #FOLDER PATH

path_to_file = path + "\Categorized.csv" #FILE PATH
file_exists = exists(path_to_file)
print(file_exists)

if file_exists == False:
    appended_data = []
    for infile in glob.glob(path + "/*.csv"):
        data = pd.read_csv(infile,usecols=['Elapsed Time','System UTC Time','Date','Actual Visibility'],skiprows=[1,2])
        data.dropna(inplace = True) 
        data['System UTC Time'] = pd.to_timedelta(data['System UTC Time'],)
        data.insert(3,'System Time','')
        data['System Time'] = ((data['System UTC Time']) - (timedelta(hours=4)))
        
        appended_data.append(data)
       
    appended_data = pd.concat(appended_data)
    appended_data["Base MSL"] = ""
    appended_data["Top MSL"] = ""
    
    # write DataFrame to an excel sheet 
    appended_data.to_csv(path_to_file)
else:
    appended_data = pd.read_csv(path_to_file)

    conditions = [(appended_data['Actual Visibility'] >= 5) & (appended_data["Base MSL"] >= 3000),
    ((appended_data['Actual Visibility'] < 5) & (appended_data['Actual Visibility'] >3)) | ((appended_data["Base MSL"] < 3000) & (appended_data["Base MSL"] > 1000)),
    ((appended_data['Actual Visibility'] <= 3) & (appended_data['Actual Visibility'] >1)) | ((appended_data["Base MSL"] <= 1000) & (appended_data["Base MSL"] > 500)),
    (appended_data['Actual Visibility'] <= 1) | (appended_data["Base MSL"] <= 500)]

    choices = ['VFR','MVFR','IFR','LIFR']

    appended_data['Category'] = np.select(conditions,choices,default = 'NA')

    appended_data.to_csv(path_to_file,index = False)



print("--- %s seconds ---" % (time.time() - start_time))



