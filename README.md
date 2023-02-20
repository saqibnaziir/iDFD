# iDFD
We have published the iDFD: dataset, which includes RGB images (all-in-focus, out-of-focus) and depth maps. 
An overview of the dataset are shown as follows:

| Sensors                     | Scenes   | Range    | Data       | Total no. Images | Depth Maps   |
|-----------------------------|----------|----------|------------|------------------|--------------|
| DLSR-Nikon, MS-KINECT       | Indoor   | $0-10m$  | RGB/Depth  | 764              | Raw/In-painted |


Sample from our iDFD dataset are provided below. Each sample contains the All-in-Focus, Defocus, Raw Depth and Depth after in-painting.
![DS_example1](https://user-images.githubusercontent.com/17612102/220080337-59c408f5-38c1-4ccd-a042-c7c30e65e5eb.png)

## Dataset Layout
iDFD data is organized for training. Detailed structure is shown as follows:
![Datalayout](https://user-images.githubusercontent.com/17612102/220078961-de7156fc-fc97-4808-b0a8-3264d9324b12.png)

**Description**: A "scene" in iDFD dataset usually corresponds to a specific location, e.g. a lab, a bedroom, a museum, etc. A "scan" corresponds to a single data capture by the scanner, resulting in a series of sections all captured from the same position. Multiple scans within the same scene may or may not overlap in the physical points captured; scans in different scenes usually do not.

## File Naming and Formats
The dataset consists of RGB images (all-in-focus, out-of-focus) and depth maps. Their formats are as follows:

_RGB images (\*.jpg): RGB images with a resolution of 1050 × 1050 in raw and 640 x 480 in case of processed which is used to train 2HDED:NET.
_Depth maps (\*.png): Depth ground truth with the same resolution as the images.

## Dataset Feature
-	**Sensor Performance**:
  See the paper for more information about parameters of both sensors (DSLR Nikon and MS-Kinect camera) used to capture iDFD dataset. 
- **Diversity**:
  - **Time**: dataset was captured at both daytime and night, several months (mostky in summer).
  - **Location**: data collection in two cities (Vigo, Spain and Bucharest, Romania), various indoor scenes.
  - **Dataset Curation**: manually selected image crops with different objects. Cropping datasets was a difficult issue. We have to manually select the part with content from the processed depth maps and ignore the area without content. This is the reason why we can see the difference between the in-painted depth maps and the depth maps without in-painting.  

## License
The iDFD dataset and the code is released using the UPB license.

<a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/"><img alt="Creative Commons Licence" style="border-width:0" src="https://i.creativecommons.org/l/by-nc-sa/4.0/88x31.png" /></a><br />This work is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-nc-sa/4.0/">Creative Commons Attribution-NonCommercial-ShareAlike 4.0 International License</a>.


## Citation  
If you use the iDFD dataset please cite:
