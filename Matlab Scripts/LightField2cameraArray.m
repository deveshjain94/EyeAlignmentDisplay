%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% This code uses the lightField array from the workspace to give back the 
% camera array which was used to generate it.
% 
% You must load the LightField4D.mat file into the workspace before running
% this code
% 
% Make sure your file structure is like this:
% The Master_Dir should have two folders such as:
% {Master_Dir}\LightField2camera\
% {Master_Dir}\scripts\(.m files such as this one)
%
% Ex : 
% D:\Devesh\LightField2camera\
% D:Devesh\scripts\LightField2cameraArray.m
%
% This code has sections borrowed and inspired from scripts written by
% Gordon Wetzstein [gordonw@media.mit.edu]
% 
% Devesh Jain [deveshjain94@gmail.com]
% 
% Srujana - Innovation Center | LVPEI,Hyderabad | 2015
% BITS Pilani Hyderabad Campus | Hyderabad | 2015
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function LightField2cameraArray(lightField)

% defining file structure for input and output files
outpath = 'LightField2camera';
datapath = ['../Images/' outpath '/'];
filename = [datapath outpath '-'];
filetype = '.png';

% dimension matrix of lightField array
lightFieldResolution = size(lightField);

count = 1;
for ky=1:lightFieldResolution(1)
    for kx=1:lightFieldResolution(2)
        
        % extract current view from the 4D light field
        currentFilename = [filename num2str(count) filetype];
        if count > 9
            currentFilename = [filename(1:end-1) num2str(count) filetype];
        end
        
        % extract the current view (image) from the 4D Light Field
        currentView = reshape(lightField(ky,kx,:,:,:), [lightFieldResolution(3) lightFieldResolution(4) lightFieldResolution(5)]);
        
        % write the current view to an image file
        imwrite(currentView,currentFilename);
        
        count = count + 1;
    end
end

end