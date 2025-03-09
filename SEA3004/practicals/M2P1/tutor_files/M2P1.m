

%% Exercise 2
T=-2:40;
figure
plot(T,svpa(T+273.15),'b')     % plot svpa in Pa and 
ylabel('Saturation Vapour Pressure [Pa]')
xlabel('Temperature [degC]')
print -deps2c fig1.eps

%% Exercise 3

z=0:500:20000;      % define height at discrete steps [m]
temp=tstdatm(z);    % obtain temperature for the standard atmosphere [K]
svpa20=svpa(temp);  % compute appx svp [Pa]
svp20=svp(temp);    % compute svp [Pa]

figure
plot(svpa20/100,z/1000,'b')     % plot svpa in hPa and km
hold on
plot(svp20/100,z/1000,'r')      % plot svp in hPa and km
legend('Approximated','Goff & Gratch (1946)')
xlabel('Saturation Vapour Pressure [hPa]')
ylabel('Height [km]')
print -deps2c fig1.eps
