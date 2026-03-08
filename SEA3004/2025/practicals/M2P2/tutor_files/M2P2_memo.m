% from the TEOS10 demo data
gsw_demo_data.SP([1,22,29:4:45],1)
SP = gsw_demo_data.SP([1,22,29:4:45],1);
t = gsw_demo_data.t([1,22,29:4:45],1);
p = gsw_demo_data.p([1,22,29:4:45],1);
t
gsw_demo_data.long
gsw_demo_data.long(1)
long =gsw_demo_data.long(1);
lat =gsw_demo_data.lat(1);


% for the students
load TEOS10_demo
help gsw_SA_from_SP
help gsw_CT_from_t

SA = gsw_SA_from_SP(SP,p,long,lat)
CT = gsw_CT_from_t(SA,t,p)


figure
scatter(t,CT)
hold on
plot([0 20],[0,20])
xlabel('In situ temperature (deg C)')
ylabel('Conservative temperature (deg C)')
set(gcf,'paperposition',[0 0 6 6])
print -dpng t_vs_CT.png


z = gsw_z_from_p(p,lat)
rho = gsw_rho(SA,CT,p)
figure
plot(rho,z,'o-')
xlabel('Seawater density (kg/m3)')
ylabel('Height (m)')
pbaspect([1 1.5 1])
set(gcf,'paperposition',[0 0 4 6])
print -dpng density.png


p_ref = 2000;
pot_rho_2 = gsw_rho(SA,CT,p_ref)
sigma_2 = pot_rho_2 - 1000;
pot_rho_0 = gsw_rho(SA,CT,0)


sigma_0 = gsw_sigma0(SA,CT)
sigma_2 = gsw_sigma2(SA,CT)
CT_freezing = gsw_CT_freezing_poly(SA,p)

figure
subplot(1,2,1)
plot(sigma_0,z,'o-')
xlabel('Density anomaly \sigma_0 (kg/m3)')
ylabel('Height (m)')
pbaspect([1 1.5 1])
subplot(1,2,2)
plot(sigma_2,z,'o-')
xlabel('Density anomaly \sigma_0 (kg/m3)')
ylabel('Height (m)')
pbaspect([1 1.5 1])

%set(gcf,'paperposition',[0 0 4 6])
print -dpng density.png

p_i = [min(p):max(p)]
SA_i = spline(p,SA,p_i);
figure
plot(SA,p,'o')
hold on
plot(SA_i,p_i,'r-')

CT_i = spline(p,CT,p_i);

sigma_2
figure
gsw_SA_CT_plot(SA,CT,p_ref,[32.5:0.5:38],'\itS\rm_A - \Theta  diagram');
hold on
plot(SA_i,CT_i,'b-')

sigma_0
figure
gsw_SA_CT_plot(SA,CT,0,[24:0.5:28],'\itS\rm_A - \Theta  diagram');
hold on
plot(SA_i,CT_i,'b-')

%% Assignement [60 points]

% 1. [15] (the variable names can be different)
CTD3 = importdata('test.cnv');
size(CTD3)
% -5 if the conversion is wrong
latCTD3 = -54+39.034/60;
lonCTD3 = 0;
% -3-5 if one column is wrong (they will have a wrong plot later)
tCTD3 = CTD3(:,5);
SPCTD3 = CTD3(:,7);
pCTD3 = CTD3(:,2);
% -2 if depth is wrong
zCTD3 = gsw_z_from_p(pCTD3,latCTD3);

% 2. [5] -2 for every wrong annotation
figure
plot(tCTD3,zCTD3)
ylim([-1000,0])
xlabel('In situ temperature (deg C)')
ylabel('Height (m)')

% 3. [5] There should be no mistakes here
SACTD3 = gsw_SA_from_SP(SPCTD3,pCTD3,lonCTD3,latCTD3);
CTCTD3 = gsw_CT_from_t(SACTD3,tCTD3,pCTD3);
sigma_0CTD3 = gsw_sigma0(SACTD3,CTCTD3);
sigma_1CTD3 = gsw_sigma1(SACTD3,CTCTD3);

% 4.  freezing point [5]
% -3 if using the wrong function
% -2 for annotations
CT_freezing = gsw_CT_freezing_poly(SACTD3,pCTD3);
figure
plot(CT_freezing,zCTD3)
ylim([-1000,0])
xlabel('Freezing CT (deg C)')
ylabel('Height (m)')
hold on
plot(CTCTD3,zCTD3,'r')

% 5. [10]
% -2 for every annotation issue or if subplots are wrong
figure
subplot(1,2,1)
plot(sigma_0CTD3,zCTD3,'k')
ylim([-1000,10])
xlabel('Density anomaly \sigma_0 (kg/m3)')
ylabel('Height (m)')
grid on
subplot(1,2,2)
plot(sigma_1CTD3,zCTD3,'k')
ylim([-1000,10])
xlabel('Density anomaly \sigma_1 (kg/m3)')
ylabel('Height (m)')
grid on

% 6. [10]
% -2 if the ranges are not correct (for each one)
figure
gsw_SA_CT_plot(SACTD3,CTCTD3,0,[27:0.1:28],'\itS\rm_A - \Theta  diagram');
figure
gsw_SA_CT_plot(SACTD3,CTCTD3,1000,[31:0.2:33],'\itS\rm_A - \Theta  diagram');

