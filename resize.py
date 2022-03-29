from PIL import Image
from datetime import timedelta
import time
import glob

start_time = time.time()

path = r"C:\Users\joshl\Documents\GitHub\Helicopter-Local\Presized\VFR"

i = 0

box = (0, 35, 1920, 1080)


for file in glob.glob(path + "/*.jpg"):   #where its being read

    image = Image.open(file)
    cropped_image = image.crop(box)
    new_image = cropped_image.resize((224, 224))
    new_image.save(r"C:\Users\joshl\Documents\GitHub\Helicopter-Local\Postsized\postsizedVFR" + r"\VFR%d.jpg" % i)
    i = i + 1







print("--- %s seconds ---" % (time.time() - start_time))