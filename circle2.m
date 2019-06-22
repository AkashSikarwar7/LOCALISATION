function[] = circle2(x1,y1,r,N)
%x = starting point x coordinate
%y = starting point y coordinate
%r = radius of circle
%N = no. of points
%a & b = x-axis starting and end point
%c & d = y-axis starting and end point
a = 0;
b = 100;
c = 0;
d = 50;
set(gca,'XLim',[a b],'YLim',[c d]);
hold on
space=pi/10;
for i=0:N
    for j=0:space:2*pi
        hold on
        pause(0.0000001)
        xunit_first_loc = (r+i)* cos(j) + x1;
        yunit_first_loc = (r+i)* sin(j) + y1 ;     
        plot(xunit_first_loc, yunit_first_loc,'o');
        hold on
    end
    hold on
end
end