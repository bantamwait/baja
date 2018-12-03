%% Shock Graphs

% values below represent the setup of the car to be tested.
d = 19.25;
r = 14.75;
R = 23;
phi = 18; % angle between firewall and vertical, measured CW pos. 
k = 90;
shockLenMax = 17.5;
stroke = 5.75;
shockLenMin = shockLenMax - stroke;
% n = granularity of motion ratio graph
n = 100;

% max vertical wheel travel defined by stroke and geometry of suspension
% betaMax: max angle between trailing arm and firewall
% alphaMax: psi + betaMax
% maxVertTravel: max travel WRT z-axis of car
betaMax = acosd((shockLenMax^2 - r^2 - d^2)/(-2*r*d));
betaMin = acosd((shockLenMin^2 - r^2 - d^2)/(-2*r*d));
alphaMax = phi + betaMax;
alphaMin = phi + betaMin;
%thetaMax = betaMax - acosd(((shockLenMax-stroke)^2 - r^2 - d^2)/(-2*r*d));
maxVertTravel = R*(cosd(alphaMin) - cosd(alphaMax));

% z is the vert. position in travel of the rear suspension. Define this as
% a scalar to output results at one point and travel use
% "linspace(R*cosd(betaMax),R*cosd(betaMin),n);" to output values as a function of position
z = 0;%linspace(R*cosd(alphaMax),R*cosd(alphaMin),n);

[InstallationRate,ShockLength,ForceAlongShock] = shockValues(d,r,R,phi,z,k,shockLenMax);

%% Plot Values

hold on
plot(z,InstallationRate,'b')
[hAx,hLine1,hLine2] = plotyy(z,ShockLength,z,ForceAlongShock);
xlabel('wheel position (0 @ horizontal)')

ylabel(hAx(1),'Shock length/Installation Rate') % left y-axis
ylabel(hAx(2),'force in shock')
legend('installation rate','shock length','force in shock')
hAx(1).YTick = 0:5:60;
grid on
hold off