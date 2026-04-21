clear; clc; close all;
%% Given Control Matrix

A = [-0.068 -0.011 0 -9.81; 0.023 -2.1 375 0; 0.011 -0.16 -2.2 0; 0 0 1 0 ];

[eigVec, eigVal] = eig(A)

%% For loop to find requested values in part a

for i = 1:length(eigVal)
    
    timeConstant(i,:) = -1./ (real(eigVal(i,i)));
    naturalFrequency(i,:) = sqrt((real(eigVal(i,i))).^2 + (imag(eigVal(i,i))).^2);
    dampeningRatio(i,:) = -(real(eigVal(i,i)))./ naturalFrequency(i);


end

%% Part c i

tspani = [0 180];
initStatei = 2.*(eigVec(:,3) + eigVec(:,4));
[ti, xLongi] = ode45(@(t,xLong)longDynamics(t,xLong,A),tspani,initStatei);

figure();

subplot(4,1,1)
plot(ti,xLongi(:,1))
title('u')
ylabel('m/s')

subplot(4,1,2)
plot(ti,xLongi(:,2))
title('w')
ylabel('m/s')

subplot(4,1,3)
plot(ti,xLongi(:,3))
title('q')
ylabel('rad/s')

subplot(4,1,4)
plot(ti,xLongi(:,4))
title('Theta')

ylabel('rad')
xlabel('Time (s)')
sgtitle('i Initial Conditions');

%% Part c ii

tspanii = [0 3];
initStateii = 5.*(eigVec(:,1) + eigVec(:,2));
[tii, xLongii] = ode45(@(t,xLong)longDynamics(t,xLong,A),tspanii,initStateii);

figure();

subplot(4,1,1)
plot(tii,xLongii(:,1))
title('u')
ylabel('m/s')

subplot(4,1,2)
plot(tii,xLongii(:,2))
title('w')
ylabel('m/s')

subplot(4,1,3)
plot(tii,xLongii(:,3))
title('q')
ylabel('rad/s')

subplot(4,1,4)
plot(tii,xLongii(:,4))
title('Theta')

ylabel('rad')
xlabel('Time (s)')
sgtitle('ii Initial Conditions');

%% Part c iii
tspaniii = [0 140];
initStateiii = 2.*(eigVec(:,1) + eigVec(:,2)) +  0.05.*(eigVec(:,3) + eigVec(:,4));
[tiii, xLongiii] = ode45(@(t,xLong)longDynamics(t,xLong,A),tspaniii,initStateiii);

figure();

subplot(4,1,1)
plot(tiii,xLongiii(:,1))
title('u')
ylabel('m/s')

subplot(4,1,2)
plot(tiii,xLongiii(:,2))
title('w')
ylabel('m/s')

subplot(4,1,3)
plot(tiii,xLongiii(:,3))
title('q')
ylabel('rad/s')

subplot(4,1,4)
plot(tiii,xLongiii(:,4))
title('Theta')

ylabel('rad')
xlabel('Time (s)')

sgtitle('iii Initial Conditions');

%% Part c iv
tspaniv = [0 180];
initStateiv = 0.75.*(eigVec(:,1) + eigVec(:,2)) +  4.*(eigVec(:,3) + eigVec(:,4));
[tiv, xLongiv] = ode45(@(t,xLong)longDynamics(t,xLong,A),tspaniv,initStateiv);

figure();

subplot(4,1,1)
plot(tiv,xLongiv(:,1))
title('u')
ylabel('m/s')

subplot(4,1,2)
plot(tiv,xLongiv(:,2))
title('w')
ylabel('m/s')

subplot(4,1,3)
plot(tiv,xLongiv(:,3))
title('q')
ylabel('rad/s')

subplot(4,1,4)
plot(tiv,xLongiv(:,4))
title('Theta')

ylabel('rad')
xlabel('Time (s)')
sgtitle('iv Initial Conditions');


%% ODE 45 function to simulate dynamics
function xLongdot = longDynamics(t, xLong, Along)
        
    xLongdot = Along*xLong;

end