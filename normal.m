function[] = normal(x1,y1,r,N)
a = 0;
b = 100;
c = 0;
d = 50;
set(gca,'XLim',[a b],'YLim',[c d]);
hold on
space=pi/50;
for i=0:b
    for j=0:space:d
        hold on
        pause(0.00000001)
        plot(i,j,'o');
        hold on
    end
    hold on
end
end