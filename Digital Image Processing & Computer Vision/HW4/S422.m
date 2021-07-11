img = imread('Images\4\Barbara.bmp');

img = rgb2gray(img);
figure
imshow(img);
title("orginal");
img = double(img);
T=[1/4 ; 1/8];

for i=1:size(T)
x = uint8(freq_filtering(img,0,T(i)));
figure
imshow(x);
title("filter a , T="+T(i));
x = uint8(freq_filtering(img,1,T(i)));
figure
imshow(x);
title("filter b(i) , T="+T(i));

x = uint8(freq_filtering(img,2,T(i)));
figure
imshow(x);
title("filter b(ii) , T="+T(i));
x = uint8(freq_filtering(img,3,T(i)));
figure
imshow(x);
title("filter b(iii) , T="+T(i));
x = uint8(freq_filtering(img,4,T(i)));
figure
imshow(x);
title("filter b(iv) , T="+T(i));
end
function new_img = freq_filtering (image,x,T)
    [M,N] = size(image);
    
    fourier_img = fft2(image,M,N);

    for k = 1:M
        for l=1:N
            
            switch x
                case 0
                    if((T*N<k && k<(1-T)*N) &&(T*N<l &&l<(1-T)*N))
                         fourier_img(k,l) = 0;
                    end
                case 1
                    if((0<k && k<T*N) && (0<l && l<T*N))
                        if(k~=0 || l~=0)
                            fourier_img(k,l) = 0;
                        end
                    end
                case 2
                    if((0<=k && k<=T*N)&&((1-T)*N<= l))
                        fourier_img(k,l) = 0;
                    end
                 case 3
                    if((0<=l && l<=T*N)&&((1-T)*N<= k))
                        fourier_img(k,l) = 0;
                    end
                 case 4
                    if((1-T)*N<=k && (1-T)*N<=l)
                        fourier_img(k,l) = 0;
                    end
            end
        end
    end
    
    x = dft_im(fourier_img);
    inverse_img = ifft2(fourier_img);
    y = abs(inverse_img);
    new_img = zeros(M,N);
    new_img(1:M,1:N) =x;
    new_img(1:M,N+1:2*N)=y;
   
end

function img = dft_im(fourier_img)
    img = abs(fourier_img);
    img = log10(img+1);
    Max = max(max(img));
    img = img *(255/Max);
    img = uint8(img);
    
end