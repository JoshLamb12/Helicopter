# Importing all necessary libraries
import cv2
import os
import csv  
# # # Read the video from specified path
# # cam = cv2.VideoCapture("E:\Coding\Video\CoPilot FW 2021-09-02_09_25_20_717.asf")

# print('h')






# #takes frames from video
# vidcap = cv2.VideoCapture('CPLT WINDSHIELD 2021-09-02_09_25_20_717.asf')
# #15 fps
# success,image = vidcap.read()
# count = 0
# fps = 299     #number is fps (15) times nubmer of seconds (20) - 1 
# while success:
#     if fps == 299:
#         cv2.imwrite("frame%d.jpg" % count, image)     # save frame as JPEG file      
#         success,image = vidcap.read()                 # goes to next frame
#         print('Read a new frame: ', success)          # prints to show success
#         fps = 0
#         count += 1
#     elif fps != 299:
#         success,vidcap.read()
#         fps += 1
#         count += 1
# print(vidcap.get(cv2.CAP_PROP_FPS))




vidcap = cv2.VideoCapture('CPLT WINDSHIELD 2021-09-02_09_25_20_717.asf')
#15 fps
path = r"C:\Users\joshl\Documents\GitHub\Helicopter-Local" #FOLDER PATH
print(path)
file = path + "\9_2_2021_Categorized.csv" #FILE PATH
success,image = vidcap.read()
count = 0
fps = 299     #number is fps (15) times nubmer of seconds (20) - 1 
font = cv2.FONT_HERSHEY_COMPLEX
while success:
    if fps == 299:
        cv2.putText(image, 'Text On Video', (50,50), font, 1, (0, 255, 255), 2, cv2.LINE_4)
        # with open(file, 'r') as f:
        #     mycsv = csv.reader(f)
         #   text = row[1]
            # for row in mycsv:
            #     text = row[1]
            #     print(text
        cv2.imwrite("frame%d.jpg" % count, image)     # save frame as JPEG file      
        success,image = vidcap.read()                 # goes to next frame
        print('Read a new frame: ', success)          # prints to show success
        fps = 0
        count += 1
    elif fps != 299:
        success = 0




# image_path = r'C:\Users\joshl\Documents\GitHub\Helicopter-Local'
# for i in range (1,10000,1000):
#     cap = cv2.VideoCapture('2021-01-15 17-03-12_Trim.mp4')
#     cap.set(cv2.CAP_PROP_POS_MSEC,i)      # Go to the 1 sec. position
#     ret,frame = cap.read()                   # Retrieves the frame at the specified second
#     img = cv2.imread(image_path)
#     cv2.imwrite("image%.jpg" % i, img)          # Saves the frame as an image
#     cv2.imshow("Frame Name",frame)           # Displays the frame on screen
#     cv2.waitKey()    