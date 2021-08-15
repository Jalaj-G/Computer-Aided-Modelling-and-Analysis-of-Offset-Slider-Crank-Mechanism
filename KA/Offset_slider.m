%% Script to compute position, velocity and acceleration of an offset slider crank %%
clear all;
close all;
clc;

%% Input Parameters %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
R1 = 30;     % Offset
R2 = 140;     % Crank length
R3 = 310;     % Link 3 length
omeg2 = 31.416;  % Angular velocity of crank (rad/sLine 10 omeg2 = 10;  % Angular velocity of crank (rad/s)

size = 200;  % Resolution of plots

%% Allocating memory %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
th2=nan(1,size);
th3=nan(1,size);
R4=nan(1,size);
omeg3=nan(1,size);
R4dot=nan(1,size);
alph3=nan(1,size);
R4dotdot=nan(1,size);

i=1; % index counter
for x=linspace(0,2*pi,size)

    %Position Solution
    th30=180*pi/180;  % Initial guesses
    R40=40;

    %Position functions
    f1=R2*cos(x)-R3*cos(th30)-R40;
    f2=R1+R2*sin(x)-R3*sin(th30);

    while norm([f1;f2])> 1E-6

        % Set up the Jacobian matrix
        J=[R3*sin(th30) -1;-R3*cos(th30)  0];

        % compute the update
        upd=J\[-f1;-f2];
        th30=th30+upd(1);
        R40=R40+upd(2);

        % Re-evaluate the function to check for convergence
        f1=R2*cos(x)-R3*cos(th30)-R40;
        f2=R1+R2*sin(x)-R3*sin(th30);
    end

    % Storing position solutions
    th3(i)=th30;
    R4(i)=R40;

    % Velocity Solution
    omeg3(i) = (R2*cos(x)*omeg2) / (R3*cos(th3(i)));
    R4dot(i) = R3*sin(th3(i))*omeg3(i) - R2*sin(x)*omeg2;

    % Acceleration Solution
    alph3(i) = ((R3*sin(th3(i))*omeg3(i)^2)-(R2*sin(x)*omeg2^2)) / (R3*cos(th3(i)));
    R4dotdot(i) = R3*cos(th3(i))*omeg3(i)^2 + R3*sin(th3(i))*alph3(i) - R2*cos(x)*omeg2^2;

    th2(i)=x; % Stores Theta 2 values
    i=i+1;
end

%% Plotting the position, velocity and acceleration solution vs th2 values%%
subplot(3,2,1)
plot(th2,th3)
title('Theta 3 vs. Theta 2')
xlim([0 2*pi])
%grid on

subplot(3,2,2)
plot(th2,R4)
title('R4 vs. Theta 2')
xlim([0 2*pi])
%grid on

subplot(3,2,3)
plot(th2,omeg3)
title('Omega 3 vs. Theta 2')
xlim([0 2*pi])
%grid on

subplot(3,2,4)
plot(th2,R4dot)
title('R4 dot vs. Theta 2')
xlim([0 2*pi])
%grid on

subplot(3,2,5)
plot(th2,alph3)
title('Alpha 3 vs. Theta 2')
xlim([0 2*pi])
%grid on

subplot(3,2,6)
plot(th2,R4dotdot)
title('R4 dotdot vs. Theta 2')
xlim([0 2*pi])
%grid on