function L_out=wavelength(T,D)
% use linear wave theory to calculate the wavelength based on the period (T)
% and and depth (D)

g=9.81;

% make the initial guess the deep water wave length
L_in=(g*T^2)/(2*pi);

% loop until diff falls below a user-defined threshold
threshold=0.01; % in m
diff=999; % arbitrary large number
while diff>threshold
    L_out=(g*T^2)/(2*pi)*tanh((2*pi)*(D/L_in));
    diff=abs(L_out-L_in);
    L_in=L_out;
end

