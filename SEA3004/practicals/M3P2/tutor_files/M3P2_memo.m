% %% Copyright (C) 2019 Marcello Vichi
% %% 
% %% This program is free software; you can redistribute it and/or modify it
% %% under the terms of the GNU General Public License as published by
% %% the Free Software Foundation; either version 3 of the License, or
% %% (at your option) any later version.
% %% 
% %% This program is distributed in the hope that it will be useful,
% %% but WITHOUT ANY WARRANTY; without even the implied warranty of
% %% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% %% GNU General Public License for more details.
% %% 
% %% You should have received a copy of the GNU General Public License
% %% along with this program.  If not, see <http://www.gnu.org/licenses/>.
% 
%  TOTAL IS 80 points
% 
% %% Author: Marcello Vichi <vichi@dell-desktop>
% %% Created: 2019-03-08


%% TUTORIAL 1 [10]
load NCEP_wind_1981-2010.mat
figure
pcolor(lon,lat,land)
axis tight
colorbar
% compute wind speed
wndsp=sqrt(uwnd.^2+vwnd.^2);
% mask with land data
wndsp(land==1)=NaN;
figure
subplot(2,1,1)
pcolor(lon,lat,wndsp)
axis tight
colorbar
title('NCEP Wind Speed annual mean (m/s)')
xlabel('Longitude')
ylabel('Latitude')
subplot(2,1,2)
pcolor(Xkm,Ykm,wndsp)
axis tight
colorbar
title('NCEP Wind Speed annual mean (m/s)')
xlabel('Distance (km)')
ylabel('Distance (km)')


%% TUTORIAL 2 [10]
x=-2:.25:2;
y=-2:.25:2;
[X,Y]=meshgrid(x,y);

figure
Fx=sin(X+2*Y);
Fy=cos(X-2*Y);
quiver(X,Y,Fx,Fy,'k')
title('Velocity field')
axis equal
axis tight

figure
C = curl(X,Y,Fx,Fy);
pcolor(X,Y,C)
axis equal
axis tight
hold
quiver(X,Y,Fx,Fy,'k')
title('Velocity field and curl')
colorposneg
colorbar




%% EXERCISE 2 divergence [20]
% the first part is the analytical solution on paper
% the divergence is a constant negative field of value -4 
% 1.
% a perfect solution shows (using d instead of partial)  dF1/dx + dF2/dy = -4
% give 5 if the solution is shown without the calculation steps
% 2. If the code looks like this, then it's 20. Labels are not needed; 
% markdown -2 for any mistake
x=-10:10;
y=-10:10;
[X,Y]=meshgrid(x,y);
figure
Fx=-2*X;
Fy=-2*Y;
D = divergence(X,Y,Fx,Fy);
figure
pcolor(X,Y,D)
hold on
quiver(X,Y,Fx,Fy)
title('Velocity field and divergence')
colorbar
%print -dpng filename.png 

%% EXERCISE 3 [40]
% this code will give the maximum score.
% it is likely that the students will forget to convert to m when computing the
% curl 
%    Many things can go wrong in this exercise and the markdown must be
%    heavy
% 
% %% fields are not masked: -5 each
% 
% %% fields are wrong (wrong components, not wind stress, etc.): -8 to -15
% 
% %% the curl is done in km and not in m: -7 
% 
% %% units are missing or wrong: -7
%  
% %% The description should be something along these lines: 
% the regions of higher curl correspond (broadly) to 
% the eastern boundary upwelling regions
%  no explanation about the regions: -10

clear all
load NCEP_wind_matlab.mat
% compute wind stress
CD = 1.5e-3; % drag coefficient [-]
rho_air = 1.; % density [kg/m3]
wndsp=sqrt(uwnd.^2+vwnd.^2);
wndsp(land==1)=NaN;
utau=rho_air*CD*uwnd.*abs(wndsp); % it must be computed this way! -8 if not
vtau=rho_air*CD*vwnd.*abs(wndsp);
tau=rho_air*CD*wndsp.^2;
Ctau = curl(Xkm*1.e3,Ykm*1.e3,utau,vtau);
Ctau(land==1)=NaN;

figure
pcolor(lon,lat,tau)
axis tight
colorbar
title('NCEP Wind stress annual mean (N/m2)')
xlabel('Longitude')
ylabel('Latitude')
%print -dpng F3a_memo.png

figure
pcolor(lon,lat,Ctau)
axis tight
clim(1.e-6*[-0.5 0.5])
shading flat
% colorposneg % not requested but OK if done (it actually makes the land less visible)
colorbar
title('NCEP Wind stress curl (N/m3)')
xlabel('Longitude')
ylabel('Latitude')
%print -dpng F3b_memo.png
