function[]=circle3(x1,y1,x2,y2,x3,y3)
points=100;
a = 0;
b = 120;
c = 0;
d = 60;
sensor_list=py.list({});
for i=1:points
    visited(i)=0;
    s(i) = (b-a).*rand(1,1) + a;
    t(i) = (d-c).*rand(1,1) + c;
    sensor_list=sensor_list+py.list({py.tuple({s(i),t(i)})});
end
plot(s,t,'*k')
hold on
grid on
set(gca,'XLim',[0 120],'YLim',[0 60]);
r=0.4;
area_swept=0;
total_area=(b-a)*(d-c);
area_remaining=total_area-area_swept;
tol=15;
th = 0:pi/100:2*pi;
identified_sensors=py.list({});
while area_remaining>tol
    x1unit = r * cos(th) + x1;
    y1unit = r * sin(th) + y1;
    x2unit = r * cos(th) + x2;
    y2unit = r * sin(th) + y2;
    x3unit = r * cos(th) + x3;
    y3unit = r * sin(th) + y3;
    for i=1:200
        plot(x1unit(i),y1unit(i),'.b')
        %pause(0.0001)
        hold on
    end
    area_remaining=area_remaining-(pi*r^2-pi*(r-0.8)^2-0.3*(pi*r^2-pi*(r-0.8)^2));
    if area_remaining>tol
        for i=1:200
            plot(x2unit(i),y2unit(i),'.r')
            %pause(0.0001)
            hold on
        end
    end
    area_remaining=area_remaining-(pi*r^2-pi*(r-0.8)^2-0.3*(pi*r^2-pi*(r-0.8)^2));
    if area_remaining>tol
        for i=1:200
            plot(x3unit(i),y3unit(i),'.g')
            %pause(0.0001)
            hold on
        end
    end
    area_remaining=area_remaining-(pi*r^2-pi*(r-0.8)^2-0.3*(pi*r^2-pi*(r-0.8)^2));
    for j=1:points
        for k=1:200
            if visited(j)==0
                dist1=((s(j)-x1unit(k))^2+(t(j)-y1unit(k))^2)^(1/2);
                dist2=((s(j)-x2unit(k))^2+(t(j)-y2unit(k))^2)^(1/2);
                dist3=((s(j)-x3unit(k))^2+(t(j)-y3unit(k))^2)^(1/2);
                if dist1<=0.4 || dist2<=0.4 || dist3<=0.4
                    identified_sensors=identified_sensors+py.list({py.tuple({s(j),t(j)})});
                    plot(s(j),t(j),'*g')
                    visited(j)=1;
                end
            end
         end
    end
    r=r+0.8;
end
identified_sensors