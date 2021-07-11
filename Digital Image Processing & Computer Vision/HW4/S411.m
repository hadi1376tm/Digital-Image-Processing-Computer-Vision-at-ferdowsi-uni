img = imread('Images\4\Lena.bmp');
img = rgb2gray(img);

%change comment for diffret filter
%filter = [1 2 1;2 4 2;1 2 1]/16;  
%filter = [-1 -1 -1;-1 8 -1;-1 -1 -1];
filter = [0 -1 0;-1 5 -1;0 -1 0];

[M,N] = size(img);
f = dft_img(filter,M,N);
filtred_img = freq_filtering(img,filter);
filtred_img = uint8(filtred_img);

figure
imshow(f);
figure
imshow(filtred_img)

imwrite(filtred_img,'out.png');

function new_img = dft_img(img,M,N)

    img = double(img);
    img = fft2(img,M,N);
    img = fftshift(img);
    img = abs(img);
    img = log10(img+1);
    Max = max(max(img));
    
    img = img *(255/Max);
    new_img = uint8(img);
end
    function new_img = freq_filtering (image,filter)
        [M,N] = size(image); 
        P = 2*M;
        Q = 2*N;

        padded_img = zeros(P,Q,'uint8');
        padded_img(1:M,1:N)=image;
        fourier_img = fft2(padded_img,P,Q);
        fourier_filter = fft2(filter,P,Q);
        fourier_img = fourier_img.*fourier_filter;
        inverse_img = ifft2(fourier_img);
        new_img = abs(inverse_img); 
        new_img = new_img(1:M,1:N);


    end