%from cameraToMultiview
clc
clear all
n = 5; %Number of super pixels
output = zeros(n*144,n*256,3,'uint8');
imshow(output)

b=0;
c=0;

for i = 1:25
    if (i<10)
        filename = sprintf('redb0%d.png',i);
    else
        filename = sprintf('redb%d.png',i);
    end
    input = imread(filename);
    
    a = size(input);
    
    if (mod(i,5)~=0)
    b = mod(i,5);
    else
    b = 5;
    end
    
   
%    if (i>5 && i<=10)
%         c = 1;
%     elseif (i>10 && i<=15)
%         c=2;
%     elseif (i>15 && i<=20)
%         c=3;
%     elseif (i>20 && i<=25)
%         c=4;
%     
%     end

c = floor((i-1)/5);

        
        for j=1:a(2)
        for k=1:a(1)
            
            output(5*k-4+c,5*j-4+b-1,:) = input(k,j,:);
            
        end
    end
    
end
figure;
imshow(output);
imwrite(output,'output.bmp');
    
    