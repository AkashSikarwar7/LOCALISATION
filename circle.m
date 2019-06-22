function[] = circle(x1,y1,x2,y2,x3,y3,r,N)
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
th = 0:0.001:2*pi;
for i=0:N
    xunit_first_loc = (r+i)* cos(th) + x1;
    yunit_first_loc = (r+i)* sin(th) + y1;
    xunit_sec_loc = (r+i)* cos(th) + x2;
    yunit_sec_loc = (r+i)* sin(th) + y2;
    xunit_third_loc = (r+i)* cos(th) + x3;
    yunit_third_loc = (r+i)* sin(th) + y3;
    plot(xunit_first_loc, yunit_first_loc,'r');
    plot(xunit_sec_loc, yunit_sec_loc,'b');
    plot(xunit_third_loc, yunit_third_loc,'g');
    comet(xunit_first_loc, yunit_first_loc)
    comet(xunit_sec_loc, yunit_sec_loc)
    comet(xunit_third_loc, yunit_third_loc)
    hold on
end
end