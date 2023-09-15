# -*- coding: utf-8 -*-
"""
Created on Tue Oct  4 11:41:45 2022
G:\2.Final_Inpainting\All_In_Focus

%  Author: Saqib, nazir, Bucharest Polytechnic University
%  E-mail: saqib.nazir@upb.ro
"""

import cv2
import os
import numpy as np

def main():
   
    imgpath="G:\\1. Final_Datasets\\1.Final_Without_Inpainting\\Resized\\All_In_Focus\\"
    resizedpath="G:\\1. Final_Datasets\\1.Final_Without_Inpainting\\Normalized\\All_In_Focus\\"
    for filename in os.listdir(imgpath):
        img = cv2.imread(imgpath + filename, cv2.IMREAD_UNCHANGED)
        # output=cv2.resize(img, (640,480), interpolation = cv2.INTER_AREA)
        # cv2.imwrite(resizedpath + filename,output)
        norm_img = np.zeros((800,800))
        final_img = cv2.normalize(img,  norm_img, 0, 255, cv2.NORM_MINMAX)
        cv2.imwrite(resizedpath + filename,final_img)
        
        
        # cv2.imshow('Normalized Image', final_img)
        # cv.imwrite('city_normalized.jpg', final_img)
        # cv.waitKey(0)
        # cv.destroyAllWindows()    
   
   
if __name__ == "__main__":
    main()
    
    
    
    
