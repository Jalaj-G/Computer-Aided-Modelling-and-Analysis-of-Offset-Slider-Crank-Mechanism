r = 0.14;
l= 0.31;
theta = 0;
R12x= r*cosd(theta)/2;
R12y= r*sind(theta)/2;
R32x= r*cosd(theta)/2;
R32y= r*sind(theta)/2;
R23x= l*cosd(11.1599368)/2;
R23y= l*sind(11.1599368)/2;
R43x= R23x
R43y= R23y
Fpx = 50;

m2 = 0.7637;
m3 = 1.559464;
m4 = 1.95025;

IG2 = 80.6 *10^(-06);
IG3 = 166.8085 *10^(-06);

alpha2 = 76.663;
alpha3 = 35.29055;

aG2x= 0;
aG2y= 5.3665;
aG3x= 1.05855;
aG3y= 5.3665;
aG4x= 0;

syms F12x F12y F32x F32y F43x F43y F14y T12

A = [1 0 1 0 0 0 0 0;
     0 1 0 1 0 0 0 0;
 -R12y R12x -R32y -R32x 0 0 0 1;
     0 0 -1 0 1 0 0 0;
     0 0 0 -1 0 1 0 0;
     0 0 R23y -R23x -R43y R43x 0 0;
     0 0 0 0 -1 0 0 0;
     0 0 0 0 0 -1 1 0];

x = [F12x F12y F32x F32y F43x F43y F14y T12]';

B= [m2*aG2x m2*aG2y IG2*alpha2 m3*aG3x m3*aG3y IG3*alpha3 m4*aG4x-Fpx 0]';

x = inv(A)*B