image = imread('Images/3/Elaine.bmp');
format shortg 
imwrite(image,"orginal.png");
% change comment for diffrent noise ****
%noised_img = imnoise(image,'salt & pepper',0.05);
%noised_img = imnoise(image,'salt & pepper',0.1);
%noised_img = imnoise(image,'salt & pepper',0.2);
%noised_img = imnoise(image,'salt & pepper',0.4);
noised_img = imnoise(image,'salt & pepper',0.5);

imwrite(noised_img,"noised.png");
filters = [3;5;7;9;11];
filter_numbers = size(filters);
%immses = zeros(4,1,'double');
%immses=[filter_numbers];
for i=1:filter_numbers
        filtered_img=median_filter(noised_img,filters(i));
        imwrite(filtered_img,"filter"+filters(i)+".png");
        %immse(image,x);
        %immses(i) = immse(image,x);
        immse_ans(i) = immse(image,filtered_img);
        
        
end
immse_ans %showing immse table



function output=median_filter(image,length)
    [R,C] = size(image);
    image = padarray(image,[floor(length/2),floor(length/2)]);
    output = zeros(R,C,'uint8');
    for i=1:R
        for j=1:C
            part = image(i:i+length-1,j:j+length-1);
            out = median(part,'all');
            output(i,j) = out;
        end
    end
end