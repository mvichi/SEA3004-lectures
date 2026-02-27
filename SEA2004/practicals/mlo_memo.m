% Copyright (C) 2021 marce
%## This program is free software: you can redistribute it and/or modify it
%## under the terms of the GNU General Public License as published by
%## the Free Software Foundation, either version 3 of the License, or
%## (at your option) any later version.
%## 
%## This program is distributed in the hope that it will be useful, but
%## WITHOUT ANY WARRANTY; without even the implied warranty of
%## MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
%## GNU General Public License for more details.
%## 
%## You should have received a copy of the GNU General Public License
%## along with this program.  If not, see
%## <https://www.gnu.org/licenses/>.

%## RUBRIC total marks 40
%#Section 1: Co2 trend [20]
%#Section 3: CO2 amplitude  [20]
%  Guidelines
%# No code or no figure: -5
%# No labels, title, legend entry: -1 for each
%# Legend: ok if not properly positioned, but markdown -1 if there is no ‘location’ keyword in the command
%# Weird title, axes labels and legend entries: between -1 to -3 depending on the level of nonsense

% Sec. 1
%# load the data
fname = 'co2_mm_mlo.csv';
CO2 = readtable(fname);
CO2.Properties % show the content

% plot the CO2 trend both methods are equivalent

% figure
% plot(CO2.decimalDate,CO2.average,'r','displayname','monthly')
% hold on
% plot(CO2.decimalDate,CO2.interpolated,'k','displayname','filtered')

figure
plot(CO2,'decimalDate','average','color','r','displayname','monthly')
hold on
plot(CO2,'decimalDate','interpolated','color','k','displayname','filtered')
xlim([1978,2022])
ylim([320,420])
xlabel('Year')
ylabel('parts per million (ppm)')
title('Atmospheric CO_2 at Mauna Loa observatory')
set(gca,'fontsize',15)
legend('location','northwest')

% plot the seasonal cycle
co2_season = CO2.average - CO2.interpolated;
figure
plot(CO2.decimalDate,co2_season,'b')
xlim([1978,2021])
xlabel('Year')
ylabel('parts per million (ppm)')
title('Seasonal CO_2 amplitude at Mauna Loa observatory')
set(gca,'fontsize',15)

