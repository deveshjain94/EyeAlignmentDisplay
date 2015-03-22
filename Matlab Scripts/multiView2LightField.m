%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code uses the Multiview Image to generate a 4D Light Field array and
% saves it along with some additional info in a .MAT format
%
% Mode = 0 : This is the default mode. This generates the 4D Light Field
% Array from the given Multiview Image.
% Mode = 1 : This additionally generates a 2D Light Field image apart from
% the 4D Light field using the given Multiview Image.
%
% CameraArraySize is the camera array dimension used to generate the
% Multiview Image
%
% Make sure your file structure is like this:
% The Master_Dir should have two folders such as:
% {Master_Dir}\Images\redbox\redboxmultiView.png
% {Master_Dir}\scripts\multiView2LightField.m
% 
% Ex:
% D:\Devesh\Images\redbox\redboxmultiView.png
% D:\Devesh\scripts\multiView2LightField.m
%
% This code has sections borrowed and inspired from scripts written by
% Gordon Wetzstein [gordonw@media.mit.edu]
%
% Devesh Jain [deveshjain94@gmail.com]
%
% Srujana - Innovation Center  | LVPEI,Hyderabad | 2015
% BITS Pilani Hyderabad Campus | Hyderabad       | 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function multiView2LightField (mode,cameraArraySize)

% Mode 0 is default
if nargin == 0
    mode = 0;
    cameraArraySize = [5 5];
end

if nargin < 2
    cameraArraySize = [5 5];
end

% change outpath depending on which multiview to be converted
outpath = 'redbox';

% defining file structure of input and outpute files
datapath = ['../Images/' outpath '/'];
filetype = '.png';

% reading the mutliview image
MultiviewImageFilename = [datapath outpath 'multiView' filetype];
MultiviewImage = im2double(imread(MultiviewImageFilename));

% obtaining metadata of the input multiview image
height=size(MultiviewImage,1);                  % Multiview Image Height
width=size(MultiviewImage,2);                   % Multiview Image Width
colourChannels=size(MultiviewImage,3);          % Colour Channel Information

% metadata of individual image view
individualViewDimension=[height/cameraArraySize(1),width/cameraArraySize(2)];

% creating the lightField object
lightFieldResolution = [cameraArraySize(1) cameraArraySize(1) individualViewDimension(1) individualViewDimension(2) colourChannels];
lightField = zeros(lightFieldResolution);

for ky=1:lightFieldResolution(1)
    for kx=1:lightFieldResolution(2)
        
        % variable for storing each view from the Multiview Image
        currentView = zeros(individualViewDimension(1),individualViewDimension(2),colourChannels);
        
        for pixVert=1:lightFieldResolution(3)
            for pixHorz=1:lightFieldResolution(4)
                
                % ycoordinate of the incoming pixel from multiview img
                ycor=ky+(pixVert-1)*lightFieldResolution(1);
                
                % xcoordinate of the incoming pixel from multiview img
                xcor=kx+(pixHorz-1)*lightFieldResolution(2);
                
                % Each pixel from the particular (ycor,xcor)pixel of the
                % Multiview image goes to a particular view of the 4D light
                % field data
                currentView(pixVert,pixHorz,:) = MultiviewImage(ycor,xcor,:);
            end
        end
        
        % creating the 4D light field data from the different views
        lightField(ky,kx,:,:,:) = reshape(currentView, [1 1 lightFieldResolution(3) lightFieldResolution(4) lightFieldResolution(5)]);
    end
end

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

%% Mode = 1 : Generates a 2DlightField Image apart from the 4D Light Field Data

if mode == 1
    % Variable for storing the 2D Light Image Data
    LightField2D = zeros(height,width,3);
    
    for pixVert=1:height
        for pixHorz=1:width
            
            % Each pixel from the Multiview Image
            ycor=mod((pixVert-1),5)*individualViewDimension(1)+floor((pixVert-1)/5)+1;
            xcor=mod((pixHorz-1),5)*individualViewDimension(2)+floor((pixHorz-1)/5)+1;
            LightField2D(ycor,xcor,:) = MultiviewImage(pixVert,pixHorz,:);
        end
    end
    
    % filename for the output 2D Light Field Image
    imshow(LightField2D);
    LightField2Dfilename = [datapath outpath '2DLFI' filetype];
    imwrite(LightField2D,LightField2Dfilename);
end
end