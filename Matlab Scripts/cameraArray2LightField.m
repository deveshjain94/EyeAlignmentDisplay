%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code loads a series of images saves them along with additional data 
% in the form a .Mat file.
%
% Mode = 0 : It will generate the 4D Light Field data 
% and save that data along with some additional info in LightField4D.mat
% Mode = 1 This is the default mode. This additionally generates a 2D Light Field image apart from the 
% 4D Light Field and saves in the same directory as the source directory .
% 
% cameraArraySize is the camera array dimension used to generate the
% Light Field
%
% Make sure your file structure is like this:
% The Master_Dir should have two folders such as:
% {Master_Dir}\Images\{outpath}\{outpath-(image_index).png}
% {Master_Dir}\scripts\(.m files such as this one)
% 
% Ex. D:\Devesh\Images\redbox\redbox-01.png
%     D:\Devesh\Scripts\cameraArray2LightField.m
%     
% This code has sections borrowed and inspired from scripts written by 
% Gordon Wetzstein [gordonw@media.mit.edu]
% 
% Devesh Jain [deveshjain94@gmail.com]
% 
% Srujana - Innovation Center | LVPEI,Hyderabad | 2015
% BITS Pilani Hyderabad Campus | Hyderabad | 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function cameraArray2LightField(mode,cameraArraySize)

% clearing the workspace
clc
clear all
close all

%default cameraArraySize of 5x5
if nargin == 0
    cameraArraySize = [5 5];
    mode            = 1;
end

if nargin < 1
    mode            = 1;
end

numOfImages = cameraArraySize(1)*cameraArraySize(2);

% defining file structure for input and output files
outpath = 'AlignDepth';
datapath = ['../Images/' outpath '/'];
filename = [datapath outpath '-'];
filetype = '.png';

% basename for files with count >10 and <100
if numOfImages > 10
    filename = [filename '0'];
end

% reading a ref image to obtain data such as image dimensions, colour
% channels, etc.
currentFilename = [filename '1' filetype];
referenceFile = imread(currentFilename);
height=size(referenceFile,1);                  % Multiview Image Height
width=size(referenceFile,2);                   % Multiview Image Width
colourChannels=size(referenceFile,3);          % Colour Channel Information

% creating the lightField object
lightFieldResolution = [cameraArraySize(1) cameraArraySize(2) height width colourChannels]
lightField = zeros(lightFieldResolution);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Generation of 4D Light Field Data (5th Dimension contains the colour channel information)

count = 1;
nn=1;
for ky=1:lightFieldResolution(1)
    for kx=1:lightFieldResolution(2)
        kx
        ky
        % filename of current image
        currentFilename = [filename num2str(count) filetype];
        if count > 9
            currentFilename = [filename(1:end-1) num2str(count) filetype];
        end
        
        % load image
        I = im2double(imread(currentFilename));
        nn=nn+1
        % convert to grayscale if desired
        if lightFieldResolution(5) == 1
            I = rgb2gray(I);
        end
        
        % sort into light field datastructure
        lightField(ky,kx,:,:,:) = reshape(I, [1 1 lightFieldResolution(3) lightFieldResolution(4) lightFieldResolution(5)]);
        
        % draw current image
        imshow(I); drawnow;
        
        % increment counter
        count = count + 1
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Additional Information borrowed directly from 'generateLightField4D' by Gordon Wetzstein [gordonw@media.mit.edu]
% field of view in degrees [y x]
fov                     = [20 20];

% size of the light field [y x] [mm]
lightFieldSize          = [296.1 473.76];
lightFieldViewerDist    = 2370;

% max angle in both ways in v = tan(theta)
lightFieldAnglesX = -tan(pi*fov(2)/360):2*tan(pi*fov(2)/360)/(lightFieldResolution(1)-1):tan(pi*fov(2)/360);
lightFieldAnglesY = -tan(pi*fov(1)/360):2*tan(pi*fov(1)/360)/(lightFieldResolution(2)-1):tan(pi*fov(1)/360);

% origin of light field in world space [y x z], x & y are defined in
% the center of the images
lightFieldOrigin        = [0 0 0];

% save MAT file containing information about the LightField
save([datapath 'LightField4D.mat'], 'lightField', 'lightFieldAnglesY', 'lightFieldAnglesX', 'lightFieldSize', 'lightFieldResolution', 'lightFieldOrigin', 'lightFieldViewerDist');
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Flattening the 4D Light Field into 2D Light Field Array
% mode == 1, generates a 2D light field image with different views
% shown side by side separately.

if (mode == 1)
    LightField2D        = zeros(height*cameraArraySize(1),width*cameraArraySize(2),3);
    
    for ky=1:lightFieldResolution(1)
        for kx=1:lightFieldResolution(2)
            
            % extract the current view (image) from the 4D Light Field
            currentView = reshape(lightField(ky,kx,:,:,:), [lightFieldResolution(3) lightFieldResolution(4) lightFieldResolution(5)]);
            for pixVert=1:height
                for pixHorz=1:width
                    
                    % appending each view side by side to the previous
                    % one creating a 2D array of different views
                    LightField2D((ky-1)*height+pixVert,(kx-1)*width+pixHorz,:) = currentView(pixVert,pixHorz,:);
                end
            end
        end
    end
    
    figure, imshow(LightField2D);
    
    % save the 2D Light Field Image separately
    outputFilename      = [datapath outpath '2DLFI' filetype];
    imwrite(LightField2D,outputFilename);
end
end
