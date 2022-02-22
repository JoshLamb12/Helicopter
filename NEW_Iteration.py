import pandas as pd
import time
from datetime import timedelta
import datetime as dt
import cv2 as cv
import os

font = cv.FONT_HERSHEY_COMPLEX

start_time = time.time()

path = r'E:\Coding\9_2_2021\9_2_Categorized.csv'
data = pd.read_csv(path)
data['System Time'] = pd.to_timedelta(data['System Time'])

data['Time(s)'] = data['System Time'].astype('timedelta64[s]')

print(data)


# x.to_csv("ELAPSED TIME.csv")


# video = r'E:\Coding\Video\CoPilot FW 2021-09-02_09_25_20_717.asf'
# vidcap = cv.VideoCapture(video)

# impath = r'E:\Coding\9_2_Images'
# print("CAP COMPLETE")
# ind = 0

# vidcap.set(cv.CAP_PROP_POS_MSEC,10000)
# success,imgcap = vidcap.read()
# cv.imshow('image',imgcap)
# cv.waitKey(0)

# for i in x['Real Elapsed Time'].values:
    
#     #vidcap.set(cv.CAP_PROP_POS_MSEC,1000)      # just cue to 20 sec. position
#     f = (i*1000)
#     print(f)
#     vidcap.set(cv.CAP_PROP_POS_MSEC,f)      # just cue to 20 sec. position
#     print("DONE")
#     success,imgcap = vidcap.read()

#     if success:
#         string = 'Category: ' + str(x.iloc[ind,8]) + "    Time:" + str(x.iloc[ind,4]) + "    Visibility: " + str(x.iloc[ind,5]) + "    Upper Cloud Base: " + str(x.iloc[ind,6])
#         cv.putText(imgcap,string,(600,25),font,0.75,(0,255,255),2,cv.LINE_4)
#         cv.imshow('image',imgcap)
#         cv.waitKey(30)
#         cv.imwrite(impath + r"\" + str(x.iloc[ind,8]) + "frame%d.jpg" % i, imgcap)     # save frame as JPEG file
#         #print(str(i) + "/25038")
#         ind = ind+1
#     else:
#         print("FAIL")
#         break
    



# for i in Filtered_Time:
#     vidcap.set(cv.CAP_PROP_POS_MSEC,i)      # just cue to 20 sec. position
#     success,image = vidcap.read()
#     if success:
#         cv.imwrite("frame20sec.jpg", image)     # save frame as JPEG file
#         cv.imshow("20sec",image)
#         cv.waitKey()   

#     string = "IFP" 
#     annotated_image = cv.putText(image,string,(600,25),font,1,(0,255,255),2,cv.LINE_4)
#     cv.imshow('Annotation',annotated_image)
#     cv.waitKey(0)







print("--- %s seconds ---" % (time.time() - start_time))