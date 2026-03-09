% Copyright (C) 2019 Marcello Vichi
% 
% This program is free software; you can redistribute it and/or modify it
% under the terms of the GNU General Public License as published by
% the Free Software Foundation; either version 3 of the License, or
% (at your option) any later version.
% 
% This program is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU General Public License for more details.
% 
% You should have received a copy of the GNU General Public License
% along with this program.  If not, see <http://www.gnu.org/licenses/>.



% Author: Marcello Vichi <vichi@dell-desktop>
% Created: 2019-03-08


%% TUTORIAL 2
load NCEP_slp_matlab_DXY  % load the data into your workspace
whos	   % check the content of your workspace

% quick inspection (as done in last tutorial)
figure
pcolor(lon,lat,slp201412)
xlabel('Longitude')
ylabel('Latitude')
colorbar
axis tight
title('Mean sea level pressure 2014/12 (hPa)')

lon(1,1)   % check the value of lon and lat for the first element
lat(1,1)
DY=lat(1,1)-lat(2,1)  % check the delta of latitude 
DX=lon(1,2)-lon(1,1)  % check the delta of longitude 
DELTA = DX

% distance on a sphere
a= 6378; % earth radius in km
y=36:-1:-36;
x=-72:71;
[X,Y]=meshgrid(x,y);
Xkm=2.5*2*pi*a*cosd(lat).*X/360;
Ykm=2.5*2*pi*a*Y/360;

figure
lims = [-20e3, 20e3]; 
subplot(2,1,1)
pcolor(lon,lat,Xkm)
axis tight
colorposneg
caxis(lims)
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('X coordinate')
subplot(2,1,2)
pcolor(lon,lat,Ykm)
axis tight
colorposneg
caxis(lims)
colorbar
xlabel('Longitude')
ylabel('Latitude')
title('Y coordinate')

%% COMPUTE THE GRADIENT using the function "gradient"
[gslpx,gslpy]=gradient(slp201412,DELTA);
gslpy=-gslpy; % see the note below!
figure
subplot(2,1,1)
contourf(lon,lat,gslpx,-4:4)
axis tight
xlabel('Longitude')
ylabel('Latitude')
colorposneg
colorbar
title('Zonal pressure gradient (hPa/deg)')
subplot(2,1,2)
contourf(lon,lat,gslpy,-4:4)
axis tight
xlabel('Longitude')
ylabel('Latitude')
colorposneg
colorbar
title('Meridional pressure gradient (hPa/deg)')

%% Exercise 1 [20]
% this example is in the lecture notes
% as usual, mostly problems with annotations are expected. Markdown -2 for
% each one

% 5 points 
x=-10:10;
y=-10:10;
[X,Y]=meshgrid(x,y);

% 5 points
T=283+(X.^2+Y.^2)/15;
figure
pcolor(X,Y,T)
colorbar
clim([283,298]) % I want a nice range! -2 if not done
title('Air Temperature (K)')

% 10 points
F1=2*X;
F2=2*Y;
figure
quiver(X,Y,F1,F2)
title('Wind Velocity (m/s)')


% Bonus figure [10 points]
% all together now (this is difficult, since they need to use clim)
% 
figure
pcolor(X,Y,T)
clim([283,298])
colorbar
hold on
quiver(X,Y,F1,F2,'w')



%% EXERCISE 2 [30 points] 
% The main difficulty is that now the sign should not be changed because Ykm is used
% There is a numeric issue that leads to indefinite numbers in the zonal gradient. 
% This introduces the concept of masked values that I will make in the next lecture
load NCEP_slp_matlab_DXY
%% a code similar to the following is a perfect 30
[gslpx,gslpy]=gradient_octave(slp201412,Xkm,Ykm); 
figure
subplot(2,1,1)
pcolor(lon,lat,gslpx)
colorposneg
colorbar
clim([-0.04 0.04]);
axis tight %% -1 if axis tight is not used
xlabel('Latitude') %% -2 for every missing annotation
ylabel('Longitude')
title('MSLP zonal gradient (hPa/km)')
subplot(2,1,2)
pcolor(lon,lat,gslpy) %% -8 if the gradient is negative!
colorposneg
colorbar
clim([-0.04 0.04]); %% -5 if the range is not set or -3 if it is not appropriate
axis tight
xlabel('Latitude')
ylabel('Longitude')
title('MSLP meridional gradient (hPa/km)')