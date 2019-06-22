function[]=points(N)
set(gca,'XLim',[0 100],'YLim',[0 50]);
a = 0;
b = 100;
c = 0;
d = 50;
for i=1:N
    s(i) = (b-a).*rand(1,1) + a;
    t(i) = (d-c).*rand(1,1) + c;
end
plot(s,t,'*')
hold on
grid on
hold on
end  