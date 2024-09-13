% Parameters
M=2400;                                 % Vehicle weight(kg)
C_d=0.35;                               % Vehicle Drag coefficient
A_f=2.4;                                % Vehicle frontal area(m^2)
rho=1.225;                              % Air density(kg/m^3)
C_r=0.013;                              % Rolling resistance co-efficients
A_f_t=5;                                % Trailer frontal area(m^2)
C_d_t=0.8;                              % Trailer drag coefficients
M_t=1250;                               % Tailer weight(kg)
g= 9.8;                                 % Gravity constant(m/s^2)
r_d=0.36449;                            % in m
                                        % Diameter=29.6 inches
                                        % radius=diameter/2
                                        % 1m = 39.37 inches
                                        % Rolling radius= 97% of calculated radius

% Given Condition: - 
% Flat ground, no headwind, no trailer
% As per given condition theta =0, V_w=0, M_t=0

data=xlsread("HWFET.xlsx");
t= data(:,1);
speed= data(:,2);
v= speed*(5/18);                                                 % Converting in m/s
for i= 1:(length(v)-1)
    If(i)= M*(v(i+1)-v(i));                                      % Inertial force(KW) 
    Ip(i)= M*(v(i+1)-v(i))*v(i);                                 % Inertial Power(KW)
    Af(i)= 0.5*rho*A_f*C_d*(v(i))^2;                             % Aerodynamic force(KW)
    Ap(i)= 0.5*rho*A_f*C_d*(v(i))^2*v(i);                        % Aerodynamic Power(KW)
    Rf(i)= C_r*M*g;                                              % Rolling force(KW)
    Rp(i)= C_r*M*g*v(i);                                         % Rolling power(KW)
    F(i) = M*(v(i+1)-v(i))+0.5*rho*A_f*C_d*(v(i))^2+ C_r*M*g;    % Total Force(N)
    P(i) = F(i).*v(i);                                           % Total Power(KW)
end
PP=P(P>0);                              % Positive Power(KW)
NP=P(P<0);                              % Negative Power(KW)
APo= mean(PP);                          % Average Power(KW)
mPP= max(PP);                           % Maximum Power(KW)
nPP= min(NP);                           % Minimum Power(KW)

ti = t(1:765);
e=P.*ti;                                % Energy(KJ)
pe=e(e>0);
ne=e(e<0);
er=sum(pe);                             % sum of positive energy(KJ)
eg=sum(ne);                             % sum of negative energy(KJ)
reg=er+eg;                              % 100% regeneration(KJ)

% Energy requirement with 80% regeneration with different power
e_10 = er-sum(10.*t)*0.8;

e_20 = er-sum(20.*t)*0.8;

e_30 = er-sum(30.*t)*0.8;

e_45 = er-sum(45.*t)*0.8;

e_60 = er-sum(60.*t)*0.8;
p1=[10 20 30 45 60];                    % defining given set of power to an array
ereg=[e_10 e_20 e_30 e_45 e_60];        % defining obtained energy for specific power to an array

% Graph Plot
hold on

figure(1)
plot(ti,Ip,"k");
grid on
title('INERTIAL POWER(HWFET)')
xlabel('Time[s]')
ylabel('Inertial Power[KW]')

figure(2)
plot(ti,Ap,"c");
grid on
title('AERODYNAMIC POWER(HWFET)')
xlabel('Time[s]')
ylabel('Aerodynamic Power[KW]')

figure(3)
plot(ti,Rp,"y","LineWidth",2);
grid on
title('ROLLING POWER(HWFET)')
xlabel('Time[s]')
ylabel('Rolling Power[KW]')

figure(4)
plot(ti,P,"g");
grid on
title('TOTAL POWER(HWFET)')
xlabel('Time[s]')
ylabel('Total Power[KW]')

figure(5)
plot(t,v,"m");
grid on
title('SPEED(HWFET)')
xlabel('Time[s]')
ylabel('Speed[m/s]')

figure(6)
plot(p1,ereg,"r");
grid on
title('POWER VS ENERGY(HWFET)')
xlabel('Power[KW]')
ylabel('Energy[KJ]')

figure(7)
plot(ti,F,"b");
grid on
title('FORCE(HWFET)')
xlabel('Time[s]')
ylabel('Force[N]')