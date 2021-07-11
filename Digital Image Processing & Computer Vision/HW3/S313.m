image = imread('Images/3/Elaine.bmp');
imwrite(image,'ORGINAL.png');

filter_size =3;
box_filter  = ones(filter_size,filter_size); %creates 3*3 box_filter
box_filter = uint8(box_filter);

output = box_filtering(image,box_filter,filter_size);
step = 5;
max_range=50;
for i=1:max_range
    if(mod(i,step)==0)
    imwrite(output,"FILTER("+i+").png");
    end
    output = box_filtering(output,box_filter,filter_size);
end


function output=box_filtering(img,filter,filter_size)
    [R,C] = size(img);
    img = padarray(img,[1,1]);
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