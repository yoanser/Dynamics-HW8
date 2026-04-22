clear; clc; close all;
%% Problem2 Givens

boeing.W = 2.83176e6; %N
boeing.c = 8.324; %m
boeing.Ix = 0.247e8; %kg*m^2
boeing.Iz = 0.673e8; %kg*m^2
boeing.u0 = 235.9; %m/s
boeing.CL0 = 0.654;
boeing.S = 511; %m^2
boeing.b = 59.64; %m
boeing.Iy = 0.449e8; %kg*m^2
boeing.Izx = -0.212e7; %kg*m^2
boeing.CD0 = 0;
boeing.theta0 = 0;

boeing.Cybeta = -0.8771;
boeing.Cyphat = 0;
boeing.Cyrhat = 0;
boeing.Clbeta = -0.2797;
boeing.Clphat = -0.3295;
boeing.Clrhat = 0.304;
boeing.Cnbeta = 0.1946;
boeing.Cnphat = -0.04073;
boeing.Cnrhat = -0.2737;
g=9.81; %m/s^2


rho = 0.3045; %kg/m^3



%% Part a, find stability derivatives

%Just coding matrix directly, top columns Y,L,N, rows are v,p,r

dpLin = rho*boeing.u0*boeing.S; %Placeholder for matrix calculations (linear dynamic pressure)

dDerivatives = [0.5*dpLin*boeing.Cybeta 0.5*dpLin*boeing.b*boeing.Clbeta 0.5*dpLin*boeing.b*boeing.Cnbeta; ...
                          0.25*dpLin*boeing.b*boeing.Cyphat 0.25*dpLin*(boeing.b)^2*boeing.Clphat 0.25*dpLin*(boeing.b)^2*boeing.Cnphat;... 
                          0.25*dpLin*boeing.b*boeing.Cyrhat 0.25*dpLin*(boeing.b)^2*boeing.Clrhat 0.25*dpLin*(boeing.b)^2*boeing.Cnrhat;]


%% Part b code equation 4.9-19 to find Alat;

%rudiementary stuff
Ixprime = (boeing.Ix*boeing.Iz - boeing.Izx^2)/boeing.Iz;
Izprime = (boeing.Ix*boeing.Iz - boeing.Izx^2)/boeing.Ix;
Izxprime = boeing.Izx/(boeing.Ix*boeing.Iz - boeing.Izx^2);
boeing.m = boeing.W/g;

%Code the monster matrix Alat with eq 4.

Alat = [dDerivatives(1,1)/boeing.m dDerivatives(2,1)/boeing.m (dDerivatives(3,1)/boeing.m - boeing.u0) g*cos(boeing.theta0); ...
   (dDerivatives(1,2)/Ixprime + Izxprime*dDerivatives(1,3)) (dDerivatives(2,2)/Ixprime + Izxprime*dDerivatives(2,3)) (dDerivatives(3,2)/Ixprime + Izxprime*dDerivatives(3,3)) 0; ...
   (Izxprime*dDerivatives(1,2) + dDerivatives(1,3)/Izprime) (Izxprime*dDerivatives(2,2) + dDerivatives(2,3)/Izprime) (Izxprime*dDerivatives(3,2) + dDerivatives(3,3)/Izprime) 0; ...
     0 1 tan(boeing.theta0) 0]

%% Part c find eigen values and eigen vectors, and other parameters

[eigVec, eigVal] = eig(Alat)

for i = 1:length(eigVal)
    
    timeConstant(i,:) = -1./ (real(eigVal(i,i)))
    naturalFrequency(i,:) = sqrt((real(eigVal(i,i))).^2 + (imag(eigVal(i,i))).^2)
    dampeningRatio(i,:) = -(real(eigVal(i,i)))./ naturalFrequency(i)


end

%% Part d simulate and plot for various initial conditions

%part i 



%% ODE 45 function to simulate dynamics
function xLatdot = latDynamics(t, xLat, Alat)
        
    xLatdot = Alat*xLat;

end
