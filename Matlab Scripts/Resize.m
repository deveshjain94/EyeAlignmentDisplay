outpath = 'shrubbery';
datapath = ['../Images/' outpath '/'];
filename = [datapath outpath '-'];
filetype = '.png';

filename = [filename '0'];

for count=1:25
currentFilename = [filename num2str(count) filetype];
        if count > 9
            currentFilename = [filename(1:end-1) num2str(count) filetype];
        end
        
        a=imread(currentFilename);
        b=imresize(a,[130 198]);
        imwrite(b,currentFilename);
end