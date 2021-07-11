image = imread('Images/3/Elaine.bmp');
imwrite(image,'ORGINAL.png');
filter_size = [3;7;11;18]; %change this for difrent mask size

for i=1:size(filter_size)
    box_filter  = ones(filter_size(i),filter_size(i)); %creates X*X box_filter 
    box_filter = uint8(box_filter);
    output = box_filtering(image,box_filter,filter_size(i));
    imwrite(output,"FILTER SIZE("+filter_size(i)+").png");
end 


function output=box_filtering(img,filter,filter_size)
    [R,C] = size(img);
    x= floor(filter_size/2-1);
    img = padarray(img,[x,x]);
    output = zeros(R,C,'uint8');
    for i=1:R
        for j=1:C
            if(i-filter_size>=0 && j-filter_size>=0 && i+filter_size<=R && j+filter_size<=C)
            part = img(i:(i+filter_size-1),j:(j+filter_size-1));
            mult = part.*filter;
            out = sum(mult,'all')/(filter_size^2);
            output(i,j) = out;
            end
        end
    end
end