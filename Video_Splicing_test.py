# Importing all necessary libraries
import cv2
import os
  
# # # Read the video from specified path
# # cam = cv2.VideoCapture("E:\Coding\Video\CoPilot FW 2021-09-02_09_25_20_717.asf")

# # print('h')
# import cv2
# vidcap = cv2.VideoCapture('2021-01-15 17-03-12_Trim.mp4')
# #
# #SampleVideo_1280x720_1mb.mp4
# success,image = vidcap.read()
# count = 0
# fps = 19
# while success:
#     if fps == 19:
#         cv2.imwrite("frame%d.jpg" % count, image)     # save frame as JPEG file      
#         success,image = vidcap.read()                 # goes to next frame
#         print('Read a new frame: ', success)          # prints to show success
#         fps = 19
#         count += 1
#     elif fps != 19:
#         success,vidcap.read()
#         fps += 1
#         count += 1
# print(vidcap.get(cv2.CAP_PROP_FPS))


for i in range (1,10000,1000):
    cap = cv2.VideoCapture('2021-01-15 17-03-12_Trim.mp4')
    cap.set(cv2.CAP_PROP_POS_MSEC,i)      # Go to the 1 sec. position
    ret,frame = cap.read()                   # Retrieves the frame at the specified second
    cv2.imwrite("image%.jpg" % i)          # Saves the frame as an image
    cv2.imshow("Frame Name",frame)           # Displays the frame on screen
    cv2.waitKey()    