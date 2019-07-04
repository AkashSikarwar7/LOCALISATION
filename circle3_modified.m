function[]=circle3_modified(x1,y1,x2,y2,x3,y3)
points=100;
a = 0;
b = 120;
c = 0;
d = 60;
range=0.8;
for i=1:points
    visited(i)=0;
    s(i) = (b-a).*rand(1,1) + a;
    t(i) = (d-c).*rand(1,1) + c;
    fprintf("SENSER %d=(%f,%f)\n",i,s(i),t(i));
end
plot(s,t,'*k')
hold on
grid on
set(gca,'XLim',[0 120],'YLim',[0 60]);
r=0.4;
area_swept=0;
total_area=(b-a)*(d-c);
area_remaining=total_area-area_swept;
tol=10;
th = 0:pi/142:2*pi;
while area_remaining>tol
    x1unit = r * cos(th) + x1;
    y1unit = r * sin(th) + y1;
    x2unit = r * cos(th) + x2;
    y2unit = r * sin(th) + y2;
    x3unit = r * cos(th) + x3;
    y3unit = r * sin(th) + y3;
    for i=1:300
        plot(x1unit(i),y1unit(i),'.b')
        %pause(0.00000001)
        hold on
    end
    area_remaining=area_remaining-(pi*r^2-pi*(r-0.8)^2-0.3*(pi*r^2-pi*(r-0.8)^2));
    if area_remaining>tol
        for i=1:300
            plot(x2unit(i),y2unit(i),'.r')
            %pause(0.00000001)
            hold on
        end
    end
    area_remaining=area_remaining-(pi*r^2-pi*(r-0.8)^2-0.3*(pi*r^2-pi*(r-0.8)^2));
    if area_remaining>tol
        for i=1:300
            plot(x3unit(i),y3unit(i),'.g')
            %pause(0.00000001)
            hold on
        end
    end
    area_remaining=area_remaining-(pi*r^2-pi*(r-0.8)^2-0.3*(pi*r^2-pi*(r-0.8)^2));
    for j=1:points
        for k=1:300
            if visited(j)==0
                dist1=((s(j)-x1unit(k))^2+(t(j)-y1unit(k))^2)^(1/2);
                dist2=((s(j)-x2unit(k))^2+(t(j)-y2unit(k))^2)^(1/2);
                dist3=((s(j)-x3unit(k))^2+(t(j)-y3unit(k))^2)^(1/2);
                if dist1<=0.4 || dist2<=0.4 || dist3<=0.4
                    plot(s(j),t(j),'*g')
                    visited(j)=1;
                end
            end
         end
    end
    r=r+0.8;
end
fprintf("\nThe visited sensers are \n");
count=0;
for i=1:points
    if visited(i)==1
        count=count+1;
        fprintf("Senser %d\n",i);
    end
end
fprintf("Total visited sensers out of %d are = %d\n",points,count);
end