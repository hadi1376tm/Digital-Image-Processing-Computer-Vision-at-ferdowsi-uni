%my
car1_image = imread("Images/1/car1.jpg");
car2_image = imread("Images/1/car2.jpg");
width = 1400;
lenth = 750;
output = zeros(lenth,width,3,'uint8');
overlap_start_im1 = 436;

for i=1:lenth
    for j=1:overlap_start_im1
        output(i,j,:) =  car1_image(i,j,:);
    end
end


[x1,y1] = deal(436,388);
[x2,y2] = deal(436,514);
[x3,y3] = deal(834,514);
[x4,y4] = deal(834,388);

[v1,w1] = deal(0,404);
[v2,w2] = deal(0,546);
[v3,w3] = deal(414,546);
[v4,w4] = deal(414,404);

syms c1 c2 c3 c4 c5 c6 c7 c8

eq1 = x1 == c1*v1 + c2*w1 + c3*v1*w1 + c4;
eq2 = x2 == c1*v2 + c2*w2 + c3*v2*w2 + c4;
eq3 = x3 == c1*v3 + c2*w3 + c3*v3*w3 + c4;
eq4 = x4 == c1*v4 + c2*w4 + c3*v4*w4 + c4;

eq5 = y1 == c5*v1 + c6*w1 + c7*v1*w1 + c8;
eq6 = y2 == c5*v2 + c6*w2 + c7*v2*w2 + c8;
eq7 = y3 == c5*v3 + c6*w3 + c7*v3*w3 + c8;
eq8 = y4 == c5*v4 + c6*w4 + c7*v4*w4 + c8;

sol = solve([eq1, eq2, eq3,eq4, eq5, eq6,eq7, eq8], [c1,c2,c3,c4,c5,c6,c7,c8]);
c1 = double(sol.c1);
c2 = double(sol.c2);
c3 = double(sol.c3);
c4 = double(sol.c4);
c5 = double(sol.c5);
c6 = double(sol.c6);
c7 = double(sol.c7);
c8 = double(sol.c8);

for i=1:lenth
    for j=overlap_start_im1:width
        v = i;
        w = j-overlap_start_im1+1;
        z = v*w;
        x = [c1 c2 c3 c4]*[v; w; z;0.1];
        y = [c5 c6 c7 c8]*[v; w; z;1];
        
        [t,s] = nearest_neighbor(x,y,car2_image);
        output(i,j,:) = car2_image(t,s,:);

    end
end

imshow(output);
function [x,y] = nearest_neighbor(s,t,image)
    x = s;
    y =t;
    shape = size(image);
    floor_x = floor(x);
    ceil_x = ceil(x);
    floor_y = floor(y);
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
    if(x>shape(1))
        x= shape(1);
    end
    if(x<=0)
        x=1;
    end
    if(y>shape(2))
        y= shape(2);
    end
    if(y<=0)
        y=1;
    end
end