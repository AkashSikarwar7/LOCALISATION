% for better result, take x1=30, y1=30 , x2=90 and y2=30
function[]=circle3_1_anchors_with_trilateration(x1,y1)

points=100;                       % no.of dump nodes (dump sensors)
a = 0;                            % starting point of x-axis
b = 100;                          % end point of x-axis
c = 0;                            % starting point of y-axis
d = 100;                           % end point of y-axis
infinite=101010;
r=0;                            % range is taken in terms of radius                          % diameter
range=3;
dia=2*range;
arc=0.07;% arc (lower is better)

error=0.02*range;

area_swept=0;                     % area covered in every path cycle
total_area=(b-a)*(d-c);           % total area of the field
area_remaining=total_area-area_swept;
tol=0;                            % tolerance (area tolerable to leave for efficiency)

for i=1:points
    % d1,d2 and d3 are the distances from 3 positions to a dump node
    d1(i)=infinite;
    d2(i)=infinite;
    d3(i)=infinite;

    % (lx1,ly1), (lx2,ly2) and (lx3,ly3) are the co-ordinates of the
    % distance from the dump nodes and initially taken as infinite
    lx1(i)=infinite;
    ly1(i)=infinite;
    lx2(i)=infinite;
    ly2(i)=infinite;
    lx3(i)=infinite;
    ly3(i)=infinite;
    
    visited(i)=0;                 % to count how many times a dump node comes 
                                  % in the range (max value is taken as 3 for trilateration)
    
    s(i) = (b-a).*rand(1,1) + a;  % creates random value (for x coordinate)
    t(i) = (d-c).*rand(1,1) + c;  % creates random value (for y coordinate)
    %fprintf("SENSER %d=(%f,%f)\n",i,s(i),t(i));
end
plot(s,t,'Ok')
hold on
grid on

set(gca,'XLim',[a b],'YLim',[c d]);
tic                               % clock start

while area_remaining>tol
    space=arc/r;
    pt_in_a_path=0;
    for j=0:space:2*pi
        % pt_in_a_path is used to count number of points(coordinates)
        % generated in one circular path which increases for every
        % increment in radius
        pt_in_a_path=pt_in_a_path+1;
        
        % (x1unit,y1unit) and (x2unit,y2unit) are the coordinates on which
        % the anchor have to move (the path for the anchor)
        x1unit(pt_in_a_path) = r * cos(j) + x1;
        y1unit(pt_in_a_path) = r * sin(j) + y1;
    end
    area_remaining=area_remaining-(pi*r^2-pi*(r-dia)^2-0.3*(pi*r^2-pi*(r-dia)^2));
    
    if area_remaining>tol
        for i=1:pt_in_a_path
            plot(x1unit(i),y1unit(i),'.b')
            pause(0.00000000000000001)
            hold on
        end
    end
    area_remaining=area_remaining-(pi*r^2-pi*(r-dia)^2-0.3*(pi*r^2-pi*(r-dia)^2));
    
    for j=1:points
        for k=1:pt_in_a_path 
            if visited(j)<3
                dist1=((s(j)-x1unit(k))^2+(t(j)-y1unit(k))^2)^(1/2);
               if dist1<=range
                    visited(j)=visited(j)+1;
                    if visited(j)==1 && d1(j)==infinite
                            d1(j)=dist1;
                            lx1(j)=x1unit(k);
                            ly1(j)=y1unit(k);
                    elseif visited(j)==2 && d2(j)==infinite
                            d2(j)=dist1;
                            lx2(j)=x1unit(k);
                            ly2(j)=y1unit(k);
                    elseif visited(j)==3 && d3(j)==infinite
                            d3(j)=dist1;
                            lx3(j)=x1unit(k);
                            ly3(j)=y1unit(k);
                        hold on
                    end
                end
            end
        end
    end
    r=r+dia;                      % incrementing the radius for next path
end    
toc                               % clock stop

fprintf('\nThe visited sensers are \n');
count=0;                          % to count no. of sensors found

for i=1:points
    d1(i)=d1(i)+error;
    d2(i)=d2(i)+error;
    d3(i)=d3(i)+error;
end

for i=1:points
    fprintf('SENSER %d=(%f,%f)\n',i,s(i),t(i));
    fprintf('Visited times = %d\n',visited(i));
    fprintf('loc1(%f,%f) d1=%f\n',lx1(i),ly1(i),d1(i));
    fprintf('loc2(%f,%f) d2=%f\n',lx2(i),ly2(i),d2(i));
    fprintf('loc3(%f,%f) d3=%f\n',lx3(i),ly3(i),d3(i));
    if visited(i)==3
        count=count+1;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
        va(i)=((d2(i)^2 - d3(i)^2)-(lx2(i)^2-lx3(i)^2)-(ly2(i)^2 - ly3(i)^2))/2;
        vb(i)=((d2(i)^2 - d1(i)^2)-(lx2(i)^2-lx1(i)^2)-(ly2(i)^2 - ly1(i)^2))/2;
        py(i)=(vb(i)*(lx3(i)-lx2(i)) - va(i)*(lx1(i)-lx2(i)))/...
            ((ly1(i)-ly2(i))*(lx3(i)-lx2(i)) - (ly3(i)-ly2(i))*(lx1(i)-lx2(i)));
        px(i)=(va(i)-py(i)*(ly3(i)-ly2(i)))/(lx3(i)-lx2(i));
        hold on
        fprintf('Predicted Location (%f,%f)\n',px(i),py(i));
        plot(px(i),py(i),'+');
        hold on
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
    end
    fprintf("\n");
end

fprintf('Total visited sensers out of %d are = %d\n',points,count);
end