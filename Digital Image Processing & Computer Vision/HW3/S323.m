image = imread('Images/3/Elaine.bmp');
imwrite(image,"orginal.png");
format shortg 
gaussian = imnoise(image,'gaussian',0.05);
noised_image = imnoise(gaussian,'salt & pepper',0.1);
imwrite(noised_image,"noised.png");

filters = [2;3;4;5;6;7];
filter_numbers = size(filters);
for i=1:filter_numbers
    median_filterd_img = median_filtering(noised_image,filters(i));
    imwrite(median_filterd_img,"median("+filters(i)+").png");
    median_immse_ans(i) = immse(image,median_filterd_img);
end
median_immse_ans % shows MSE result


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
