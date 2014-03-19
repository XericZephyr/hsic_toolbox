Matlab Hyperspectral Image Classification Toolbox
============

This toolbox included a novel object-oriented data model of hyperspectral image for classification purpose. 
Moreover, some state-of-art classification methods will be implemented in future updates. 

Basic Data Model
============

Class Name: hsic_data

Methods: 

Return data object structure:

3 fields: 
data     : N * nbs Matrix 
label    : N * 1   Vector
position : N * 2   Matrix

data is a N * nbs matrix where N is the number of all pixels in the hyperspectral image (hereafter HSI) and nbs is the number of spectral bands.
label is the corresponding predefined label of the pixel, 0 stands for unclassified, while non-zero values stand for specific class.
position saves the original data position in the HSI data cube. Every line is a 2-dimensional vector in the format of [line, column]. 

Function Interfaces
============

Coming soon... 

Update Logs
============

Coming soon... 