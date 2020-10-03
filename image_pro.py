#!/usr/bin/python3
from PIL import Image
import requests
from timeit import default_timer as timer
from io import BytesIO
import cv2

url = ["https://images.unsplash.com/photo-1546540749-1642fed507fc?ixlib=rb-1.2.1&auto=format&fit=crop&w=400&q=60",
    "https://images.unsplash.com/photo-1586023492125-27b2c045efd7?ixlib=rb-1.2.1&auto=format&fit=crop&w=567&q=80",
    "https://images.unsplash.com/photo-1593067607070-95193763e3ab?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1562597887-46dbd18521a6?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1584467331242-9628400008cc?ixlib=rb-1.2.1&auto=format&fit=crop&w=500&q=60",
    "https://images.unsplash.com/photo-1505773278895-5efa7b11679a?ixlib=rb-1.2.1&dpr=1&auto=format&fit=crop&w=525&q=60",
    "https://images.unsplash.com/photo-1594761049307-baec901dcbe5?ixlib=rb-1.2.1&dpr=1&auto=format&fit=crop&w=225&q=60",
    "https://images.unsplash.com/photo-1586044336930-3bfafdce711b?ixlib=rb-1.2.1&dpr=1&auto=format&fit=crop&w=225&q=60",
    "https://images.unsplash.com/photo-1538026139293-9a46ee2a0101?ixlib=rb-1.2.1&dpr=1&auto=format&fit=crop&w=525&q=60",
    "https://images.unsplash.com/photo-1552664467-e8727a018a93?ixlib=rb-1.2.1&dpr=1&auto=format&fit=crop&w=225&q=60",
    "https://images.unsplash.com/photo-1567016432779-094069958ea5?ixlib=rb-1.2.1&dpr=1&auto=format&fit=crop&w=225&q=60",
    "https://i.imgur.com/5BQL7KK.jpg",
    "https://img.freepik.com/free-photo/blurred-living-room_1203-32.jpg?size=626&ext=jpg",
    "https://st2.depositphotos.com/1875497/11455/i/950/depositphotos_114558892-stock-photo-abstract-blur-living-room.jpg",
    "https://media.istockphoto.com/photos/blur-background-interior-design-bright-minimalist-living-room-with-picture-id697225474?k=6&m=697225474&s=170667a&w=0&h=MFyn5njWdgFlUJ4vS90sfNGnxjk6pDbfsxR_EM8OAgM=",
    "https://i.pinimg.com/originals/c6/1a/cf/c61acfa766eb3229b223addb9e6ba415.jpg"
]


thresh = 130
limit_ilum = 70
limit_foc = 200
ilum = []
foc = []

def ilumination(img):
  #rez = img.resize((1, 1))
  fn = lambda x : 255 if x > thresh else 0
  color = img.convert('L').point(fn, '1')
  pixs = color.getdata()
  pixs = [sets for sets in pixs]
  ilum.append(sum(pixs)/len(pixs) > limit_ilum)
  #print(sum(pixs)/len(pixs) > limit)
  #input()
  #print(int(str(color).split()[5][:-1], 16))

def focus():
  image = cv2.imread('./img.jpg')
  gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)
  focus = cv2.Laplacian(gray, cv2.CV_64F).var()
  foc.append(focus > limit_foc)
  #input()

for link in url:
    with open('img.jpg', 'wb') as f:
        f.write(requests.get(link).content)
    with Image.open('./img.jpg') as img:
        ilumination(img)
        #img.show()
        focus()
print("ilumination:", ilum)
print("focus", foc)

