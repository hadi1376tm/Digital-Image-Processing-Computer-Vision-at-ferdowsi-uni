image = imread("Images/1/Elaine.bmp");

%uncomment for diffrent degree *******
D=670*pi/180;   
%D=45*pi/180;   
%D=100*pi/180;   
%*********

rotate = [cos(D) sin(D) 0; -sin(D) cos(D) 0;0 0 1];
Size = size(image);

base = zeros(Size(1)*1.5,Size(2)*1.5,'uint8');
for i=1:Size(1)
    for j=1:Size(2)
        base(Size(1)/4+i,Size(2)/4+j)=image(i,j);
    end
end
Size = size(base);
image_temp = base;

for i = 1:Size(1)
   for j = 1:Size(1)
       [v,w] = nearest_neighbor_inter(i,j,base,rotate);
       image_temp(i,j)= base(v,w);
   end
end
imshow(image_temp)

function [x,y] = nearest_neighbor_inter(i,j,image,transform_matrix)

    shape = size(image);
    X = transform_matrix\[i-shape(1)/2;j-shape(2)/2;1];
    x = X(1)+shape(1)/2;
    y = X(2)+shape(2)/2;
    floor_x = floor(x);
    floor_y = floor(y);
    ceil_x = ceil(x);
    ceil_y = ceil(y);
    
    if(abs(floor_x-x) < abs(ceil_x-x))
        x = floor(x);
    else
        x = ceil(x);
    end
    if(abs(floor_y-y) < abs(ceil_y-y))
        y = floor(y);
    else
        y = ceil(y);
    end
    
    if(x<=0)
        x=1;
    end
    if(x>shape(1))
        x= shape(1);
    end
    
    if(y>shape(2))
        y= shape(2);
    end
    if(y<=0)
        y=1;
    end
end