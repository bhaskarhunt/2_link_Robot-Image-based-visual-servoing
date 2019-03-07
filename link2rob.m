%print arm
clc
clear
hight_of_base = 1;
l1 = 1;
l2 = 1;
camera_ofset = 0;
endfactor = [1,1,0];
lembda = 0.5;
%-------------------------
%-------robot inetialisation ends--------
%object inetialisation
p0 = [1,0,1];
%initial and required camera co-ordinate
oc0 = [1,1,0];
oc1 = [1,0,0];
%that's all mate
theta0 = current_angle(endfactor,l1,l2);
R02 = rotation(theta0(1,1),theta0(1,2));            %Rotational matrix at initial condition
pc0 = (p0 - oc0);
thetad = current_angle(oc1,l1,l2);
R02 = rotation(thetad(1,1),thetad(1,2));
pcd =inv(R02)*(p0 - oc1)';
s0 = globaltoimage(pc0(1),pc0(2),pc0(3));
sd = globaltoimage(pcd(1),pcd(2),pcd(3));
theta = zeros(1,2);
sum = 0;

for i = 1:1:10000
   z = 1;
    if i == 1
        jc = [l1*sin(theta0(1,2)),0;l1*cos(theta0(1,2))+l2,l2;1,1]
        er = sd - s0;
        l = [-lembda/z,0,s0(2);0,-lembda/z,-s0(1)];
        lm = l*jc;
        omega = -inv(lm)*er;
        theta1d(i) = omega(1,1);
        theta2d(i) = omega(2,1);
        th1(i) = theta0(1,1);
        th2(i) = theta0(1,2);
        theta = theta0 + 0.001*omega';
        pp0 = posit12(theta0(1),theta0(2),l1,l2)
        aax1(i) = l1*cos(theta0(1,1));
        aay1(i) = l1*sin(theta0(1,1));
        aax2(i) = pp0(1,1);
        aay2(i) = pp0(1,2);
    else
        R02 = rotation(theta(1,1),theta(1,2));
        jc = [l1*sin(theta(1,2)),0;l1*cos(theta(1,2))+l2,l2;1,1];
        pos = posit12(theta(1,1),theta(1,2),l1,l2);
        pc = inv(R02)*(p0 - pos)';
        s = globaltoimage(pc(1),pc(2),1);
        l = [-lembda/z,0,s(2);0,-lembda/z,-s(1)];
        lm = l*jc;
        er = sd - s;
        erx(i) = er(1,1);
        ery(i) = er(2,1);
        
        if er(1,1) < 0.0001 && er(2,1)<0.0001
            sum = i;
         
         % terminate the loop using break statement 
           break;
        end
        omega = inv(lm)*er;
        theta1d(i) = omega(1,1);
        theta2d(i) = omega(2,1);
        th1(i) = theta(1,1);
        th2(i) = theta(1,2);
        theta = theta + omega'*0.001;
        
        pp = posit12(theta(1),theta(2),l1,l2);
        aax1(i) = l1*cos(theta(1,1));
        aay1(i) = l1*sin(theta(1,1));
        aax2(i) = pp(1,1);
        aay2(i) = pp(1,2);
%         plot(O2AX,O2AY,'b-',ABX,ABY,'b-',BO4X,BO4Y,'b-',APX,APY,'g-',BPX,BPY,'g-', px(1:i),py(1:i),'k-')
%         axis equal
    end

    

end
ppd = pp
% 
for i=1:length(aax1)/10
    plot(0:aax1(i*10)*.01:aax1(i*10),0:aay1(i*10)*0.01:aay1(i*10),'rs',aax1(i*10):(aax2(i*10)-aax1(i*10))*0.01:aax2(i*10),aay1(i*10):(aay2(i*10)-aay1(i*10))*0.01:aay2(i*10),'gs')%,'b-',BO4X,BO4Y,'b-',APX,APY,'g-',BPX,BPY,'g-', px(1:i),py(1:i),'k-')
    axis equal
    xmin=-2; xmax=2; ymin=-2; ymax=2;
    axis([xmin xmax ymin ymax])
    drawnow
end








figure(2)

subplot(3,3,1)
plot(aax1)
title('X1 vs time')
xlabel('time')
ylabel('X1')

subplot(3,3,2)
plot(aay1)
title('Y1 vs time')
xlabel('time')
ylabel('Y1')

subplot(3,3,3)
plot(aax2)
title('X2 vs time')
xlabel('time')
ylabel('X2')

subplot(3,3,4)
plot(aay2)
title('Y2 vs time')
xlabel('time')
ylabel('Y2')


subplot(3,3,5)
plot(erx)
title('Error X vs time')
xlabel('time')
ylabel('Error_in_U')

subplot(3,3,6)
plot(ery)
title('Error Y vs time')
xlabel('time')
ylabel('Error_in_V')

subplot(3,3,7)
plot(theta1d)
title('omega1 X vs time')
xlabel('time')
ylabel('omega1')

subplot(3,3,8)
plot(theta2d)
title('omega2 X vs time')
xlabel('time')
ylabel('omega2')


