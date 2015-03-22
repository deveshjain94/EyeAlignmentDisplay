%% This code has sections borrowed and inspired from scripts written by Gordon Wetzstein [gordonw@media.mit.edu] %%

These codes allow interchange between Camera Array to 4D Light Field Array/2D Light field Image to Multiview Image and vice versa. The codes has individual descriptions at the top.

Make sure your file structure is such :
The Master_Dir should have two folders such as:
{Master_Dir}\Images\{outpath}\{outpath-(image_index).png}
{Master_Dir}\Images\LightFieldtoCamera\
{Master_Dir}\scripts\(.m files)

Ex: D:\Devesh\Images\redbox\redbox-01.png
    D:\Devesh\LightField2camera\
    D:Devesh\scripts\LightField2cameraArray.m

Description of each file is given below:

#######################################################################################################################
cameraArray2LightField.m #
##########################
This code loads a series of images saves them along with additional data in the form a .Mat file. Takes two input arguments - Mode and cameraArraySize

Mode = 0 : It will generate the 4D Light Field data and save that data along with some additional info in LightField4D.mat
Mode = 1 This is the default mode. It additionally generates a 2D Light Field image apart from the 4D Light Field and saves in the same directory as the source directory .

CameraArraySize is the camera array dimension used to generate the Light Field

########################################################################################################################
LightField2cameraArray.m #
##########################

This code uses the lightField array from the workspace to give back the camera array which was used to generate it. Takes one input argument - lightField array

You must load the LightField4D.mat file into the workspace before running this code

########################################################################################################################
LightField2multiView.m #
########################

This code uses the lightField array from the workspace or a 2D Light Field Image to generate its MultiView image. Takes three arguments - Mode,lightField aray and CameraArraySize

Mode = 0 : Generates the Multiview Image using a 2D Light Field Image located in datapath as described below
Mode = 1 : Generates the Multiview Image using the 4D Light Field Data from the workspace variable 'lightField'. You must load the LightField4D.mat file into the workspace before running this code

CameraArraySize is the camera array dimension used to generate the Multiview Image

########################################################################################################################
multiView2LightField.m #
########################

This code uses the Multiview Image to generate a 4D Light Field array and saves it along with some additional info in a .MAT format. Takes two input arguments - Mode and cameraArraySize

Mode = 0 : This is the default mode. This generates the 4D Light Field Array from the given Multiview Image.
Mode = 1 : This additionally generates a 2D Light Field image apart from the 4D Light field using the given Multiview Image.

CameraArraySize is the camera array dimension used to generate the Multiview Image

%% Devesh Jain | Srujana - Innovation Center  | LVPEI, Hyderabad | 2015 %%
%%		 BITS Pilani Hyderabad Campus | Hyderabad	 | 2015 %%