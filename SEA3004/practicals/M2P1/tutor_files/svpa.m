function es = svpa(tempK)
% SVPA Saturation Vapour Pressure (Approximated solution)
%   es = svpa(temp)
%   temp: temperature array in degrees K
%   es: pressure in Pa

% constants
A=6.11e2;    % Pa 
beta=0.067;  % 1/degC
% convert from K to degC
tempC=tempK-273.15;
es = A.*exp(beta.*tempC);