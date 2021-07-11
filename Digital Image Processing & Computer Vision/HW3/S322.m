image = imread('Images/3/Elaine.bmp');
imwrite(image,"orginal.png");
format shortg 

%change commet for difrent input
%noised_img = imnoise(image,'gaussian',0.01);
noised_img = imnoise(image,'gaussian',0.05);   
%noised_img = imnoise(image,'gaussian',0.1);

imwrite(noised_img,"noised.png");
filters = [3;5;7;9;11];
filter_numbers = size(filters);
    for i=1:filter_numbers
        box_filter  = ones(filters(i),filters(i)); %creates X*X box_filter 
        box_filter = uint8(box_filter);
        avg_filterd_img = box_filtering(noised_img,box_filter,filters(i));
        imwrite(avg_filterd_img,"avg_filter"+i+".png");
        avg_immse_ans(i) = immse(image,avg_filterd_img);
    end
disp('avg filter')
avg_immse_ans


    for j=1:filter_numbers
       
        median_filterd_img = median_filtering(noised_img,filters(j));
        imwrite(median_filterd_img,"median_filter"+j+".png");
        median_immse_ans(j) = immse(image,median_filterd_img);

    end
disp('median filter')
median_immse_ans

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
function output=median_filtering(image,window_size)
    [R,C] = size(image);
    image = padarray(image,[floor(window_size/2),floor(window_size/2)]);
    output = zeros(R,C,'uint8');
    for i=1:R
        for j=1:C
            part = image(i:i+window_size-1,j:j+window_size-1);
            out = median(part,'all');
            output(i,j) = out;
        end
    end
end