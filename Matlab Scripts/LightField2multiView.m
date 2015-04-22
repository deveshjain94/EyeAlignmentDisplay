%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code uses the lightField array from the workspace or a 2D Light 
% Field Image to generate its MultiView image.
%
% Mode = 0 : Generates the Multiview Image using a 2D Light Field Image 
% located in datapath as described below
% Mode = 1 : Generates the Multiview Image using the 4D Light Field Data 
% from the workspace variable 'lightField'. You must load the 
% LightField4D.mat file into the workspace before running this code
% 
% CameraArraySize is the camera array dimension used to generate the
% Multiview Image
%
% Make sure your file structure is like this:
% The Master_Dir should have two folders such as:
% {Master_Dir}\Images\redbox\redbox2DLFI
% {Master_Dir}\scripts\LightField2multiView.m
% 
% Ex: 
% D:\Devesh\Images\redbox\redbox2DLFI
% D:\Devesh\scripts\LightField2multiView.m
% 
% This code has sections borrowed and inspired from scripts written by
% Gordon Wetzstein [gordonw@media.mit.edu]
% 
% Devesh Jain [deveshjain94@gmail.com]
% 
% Srujana - Innovation Center | LVPEI,Hyderabad | 2015
% BITS Pilani Hyderabad Campus | Hyderabad | 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function LightField2multiView(mode,lightField,cameraArraySize)

% Mode 0 is default
if nargin == 0
    mode = 0;
    cameraArraySize = [5 5];
end

% defining file structure for input and output files
outpath = 'AlignDepth';
datapath = ['../Images/' outpath '/'];
filetype = '.png';

%% Mode = 0 : Using a previously generated 2D Light Field Image

if mode == 0
    
    % default cameraArraySize of 5x5
    if nargin < 3
        cameraArraySize = [5 5];
    end
        % reading the 2D Light Field Image
    LightField2Dfilename = [datapath outpath '2DLFI' filetype];
    LightField2D = im2double(imread(LightField2Dfilename));
    
    % obtaining metadata from image
    height=size(LightField2D,1);
    width=size(LightField2D,2); 
    individualViewDimension=[height/cameraArraySize(1),width/cameraArraySize(2)];
    
    % creating the output multiview image variable
    MultiviewImage = zeros(height,width,3);
    
    % generating multiview image from the 2D Light Field Image
    for pixVert=1:height
        for pixHorz=1:width
            
            % ycoordinate of the incoming pixel in multiview img
            ycor=mod((pixVert-1),5)*individualViewDimension(1)+floor((pixVert-1)/5)+1;
            
            % xcoordinate of the incoming pixel in multiview img
            xcor=mod((pixHorz-1),5)*individualViewDimension(2)+floor((pixHorz-1)/5)+1;
            
            % Each pixel in the multiview image is taken from the
            % (ycor,xcor) pixel from the 2D lightField Image
            MultiviewImage(pixVert,pixHorz,:) = LightField2D(ycor,xcor,:);
        end
    end
    
end

%% Mode = 1 : Using the 4D lightField data

if mode == 1
    
    % dimension matrix of lightField array
    lightFieldResolution = size(lightField);
    
    % defining the mutliview output variable
    MultiviewImage = zeros(lightFieldResolution(3),lightFieldResolution(4),3);
    
    for ky=1:lightFieldResolution(1)
        for kx=1:lightFieldResolution(2)
            
            % extracting each view from the lightField
            currentView = reshape(lightField(ky,kx,:,:,:), [lightFieldResolution(3) lightFieldResolution(4) lightFieldResolution(5)]);
            
            % generating multiview from each view extracted from the
            % 4D lightField data
            for pixVert=1:lightFieldResolution(3)
                for pixHorz=1:lightFieldResolution(4)
                    
                    % ycoordinate of the incoming pixel in multiview img
                    ycor=ky+(pixVert-1)*lightFieldResolution(1);
                    
                    % xcoordinate of the incoming pixel in multiview img
                    xcor=kx+(pixHorz-1)*lightFieldResolution(2);
                    
                    % Each pixel from a particular view from the 4D
                    % LightField data goes to (ycor,xcor)pixel of the
                    % Multiview image
                    MultiviewImage(ycor,xcor,:) = currentView(pixVert,pixHorz,:);
                end
            end
            
            
        end
    end
    
    
end

imshow(MultiviewImage);

% Writing Multiview image to the filestructure
multiViewFilename = [datapath outpath 'multiView' filetype];
imwrite(MultiviewImage,multiViewFilename);
end