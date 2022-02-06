import pandas as pd
import glob
import numpy as np
import time
start_time = time.time()

from os.path import exists

path = "E:\Coding\9_2_2021" #Defines the Path the code reads for Excel Files
#allfilenames = glob.glob(path + "/*.csv") #Determines the Folder our program will read excel documents
#numFiles=len(allfilenames) #Determines the number of Files located in the designated folder

path_to_file = r"E:\Coding\appended.csv"
file_exists = exists(path_to_file)
print(file_exists)

if file_exists == False:
    appended_data = []
    for infile in glob.glob(path + "/*.csv"):
        data = pd.read_csv(infile,usecols=['Elapsed Time','Date','Actual Visibility'],skiprows=[1,2])
        data.dropna(inplace = True)
        # store DataFrame in list
        appended_data.append(data)
    
    # see pd.concat documentation for more info
    appended_data = pd.concat(appended_data)
    appended_data["Base MSL"] = ""
    appended_data["Top MSL"] = ""
    
    # write DataFrame to an excel sheet 
    appended_data.to_csv('appended.csv')
else:
    appended_data = pd.read_csv(path_to_file)
    appended_data.loc[appended_data['Actual Visibility'] >=30, 'Category'] = 'IFVR'
    appended_data.to_csv('appended.csv')



print("--- %s seconds ---" % (time.time() - start_time))



