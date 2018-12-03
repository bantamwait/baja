%% Shock Graphs
% This code may be easier to understand with a little background in linear
% algebra. Nothing too wacky, just resetting the origin mostly, and then a
% little geometry in 3-space. Resetting the origin is a transform that
% leaves the y-dimensions alone and reorients the x-z axes to be
% along/normal (respectively) to the rotation axis of the LCA. The form of
% the transform is Ax = B: where x transforms the original coordinates (A)
% into the front-suspension reference coordinates (B)

% basic suspension dimensions
k = 80;
shockLenMax = 17.5;
stroke = 5.75;
comprLength = shockLenMax - stroke;%linspace(shockLenMax - stroke,shockLenMax,100);

%% Import Front Suspension 3Space Points (Cartesian x,y,z points)
% values below represent the setup of the car to be tested. These
% coordinates can be obtained from Lotus or Solidworks. 
% 
LCAframeFront = [6.5 7.1875 1.625];
LCAframeRear = [16.5 7.1875 0.125];
LCAout = [9.5 22.5 -3.5];
shockLower = [10.375 16.75 -1.375];
shockUpper = [12.381 9.25 12];

%% Set Cartesian Origin to the midpoint of LCA pivot
% LCA_mid is not a point from Lotus or SW, but rather is the origin about
% which we evaluate the rest of the front suspension. To set LCA_mid as the
% origin, subtract it from itself and each other vector.
LCA_mid = (LCAframeFront + LCAframeRear)/2;

LCAf = LCAframeFront - LCA_mid;
LCAr =  LCAframeRear - LCA_mid;
LCAo = LCAout - LCA_mid;
SL = shockLower - LCA_mid;
SU = shockUpper - LCA_mid;
r = norm(SL);
d = norm(SU);

%% Rotate the Reference Frame so that x/z is along/normal-to axis of LCA pivot
% need the angle of the LCA pivot in order to rotate-transform the coordinates into
% the suspension reference frame. Where Ax=b ==> x=inv(A)*b ==> A=b*inv(x)
phi = asind(LCAf(3)/norm(LCAf)); %canted angle of LCA pivot
x = [cosd(-phi) 0 -sind(-phi);0 1 0;sind(-phi) 0 cosd(-phi)]; % rotation transform

bLCAf = LCAf*x;
bLCAr = LCAr*x;
bLCAo = LCAo*x;
bSL = SL*x;
bSU = SU*x;

unsprungShockLength = norm(shockUpper - shockLower);

% beta is the angle between the lines of action of the origin-to-shockupper and the origin-to-shockLower. 
% theta is the angle between the plane of LCA and the plane of LCApivot-shockUpperMount
% dBeta is the compressed angle of the plane of LCA and the plane of LCApivot-shockUpperMount
beta = acosd((bSU*bSL')/(norm(bSL)*norm(bSU)));
theta = acosd(([0 bSU(2) bSU(3)]*[0 bSL(2) bSL(3)]')/(norm([0 bSL(2) bSL(3)])*norm([0 bSU(2) bSU(3)])));

dr = norm([0 bSL(2) bSL(3)]);
dd = norm([0 bSU(2) bSU(3)]);

dBeta = acosd((comprLength^2 - dd^2 - dr^2)/(-2*dd*dr));
SLcompressed = [0 comprLength*sind(dBeta) comprLength*cosd(dBeta)];

% travel


%% Plot Values
% 
% hold on
% plot(z,InstallationRate,'b')
% [hAx,hLine1,hLine2] = plotyy(z,ShockLength,z,ForceAlongShock);
% xlabel('wheel position (0 @ horizontal)')
% 
% ylabel(hAx(1),'Shock length/Installation Rate') % left y-axis
% ylabel(hAx(2),'force in shock')
% legend('installation rate','shock length','force in shock')
% hAx(1).YTick = 0:5:60;
% grid on
% hold off