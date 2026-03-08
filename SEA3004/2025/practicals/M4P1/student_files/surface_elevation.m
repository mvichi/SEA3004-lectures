function [eta,x,t]=surface_elevation(amplitude,period,depth)

% This function returns the surface elevation eta(x,t) according to linear
% wave theory for a given input amplitude, period and depth. Also output 
% is the distance array x, defined as an array from 0 to 3*wavelengths, in 
% 1 m increments, and the time array t, defined as an array from 0 to 
% 3*periods, in 1 s increments 

lamda=wavelength(period,depth); % wavelength in m

% generate an array in the x dimension from zero to 3*wavelengths
x=0:3*lamda;

% generate a time array from zero to 3 periods
t=0:3*period;

% initialise an empty array for eta which we will populate
eta=zeros(length(t),length(x));

for i=1:length(t)
    for j=1:length(x)
        eta(i,j)=amplitude.*cos(2*pi/lamda*x(j) - 2*pi/period*t(i));
    end
end
