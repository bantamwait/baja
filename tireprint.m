%% Tireprint Shape (assign contact patch dims here first and run)

contactWidth = 3.125*(.0254); %m along y-axis of car
contactLength = 3.75*(.0254); %m along x-axis of car

a = contactLength/2;
b = contactWidth/2;

% radial == 3 (square patch); bias == 1 (ellipse); 
% Integers Only
n = 1; 

xPatch = linspace(-b,b,500);

yPatch =  a .* (1 - ((xPatch.^(2*n))./(b^(2*n)))).^(1/(2*n));


hold on
grid on
plot(real(xPatch),-yPatch,'b')
plot(real(xPatch),yPatch,'b')

title('Tire Contact Patch Shape')
ylabel('X (car reference coordinates)')
xlabel('Y (car reference coordinates)')

axis([-(a) a -(b+.01) b+.01])
axis equal


%% Max Static Normal Stress on Tireprint (sigma_max)
car_weight = (350/2.205) * 9.81; %N
weightDistrF = .4;
weightDistrR = 1 - weightDistrF;

area_fcn = @(x,y) (1 - ((x.^(2*n))./(a^(2*n))) - ((y.^(2*n))./(b^(2*n))));
Area_patch = integral2(area_fcn,-(a),a,-(b),b); % contact patch area

norm_stress_R = car_weight * weightDistrR/2; 
max_stress_R = norm_stress_R / Area_patch;

norm_stress_F = car_weight * weightDistrF/2;
max_stress_F = norm_stress_F / Area_patch;

xx = linspace(-(a+.01),a+.01,50);
yy = linspace(-(b+.01),b+.01,50);

[X,Y] = meshgrid(xx,yy);
stress_distr_Rtire = max_stress_R*(sqrt(1 - (X.^(2*n))./(a^(2*n)) - (Y.^(2*n))./(b^(2*n))));
stress_distr_Ftire = max_stress_F*(sqrt(1 - (X.^(2*n))./(a^(2*n)) - (Y.^(2*n))./(b^(2*n))));
ZR = real(stress_distr_Rtire);
ZF = real(stress_distr_Ftire);

grid on

% Show Front/Rear Surface Plot
f1 = figure(1);
f1.Name = 'Rear Contact Patch Stress Distribution: Static';
SR = mesh(X,Y,ZR);
c = colorbar;
c.Label.String = 'Pressure at location on tire';
ylabel('X (car reference coordinates)')
xlabel('Y (car reference coordinates)')

f2 = figure(2);
f2.Name = 'Front Contact Patch Stress Distribution: Static';
SF = mesh(X,Y,ZF);
c = colorbar;
c.Label.String = 'Pressure at location on tire';
ylabel('X (car reference coordinates)')
xlabel('Y (car reference coordinates)')



%% Straight-Rolling Normal Stress Distribution on Tireprint
car_weight = (350/2.205) * 9.81; %N
weightDistrF = .4;
weightDistrR = 1 - weightDistrF;

area_fcn = @(x,y) (1 - ((x.^(2*n))./(a^(2*n))) - ((y.^(2*n))./(b^(2*n))) + x./(4*a));
Area_patch = integral2(area_fcn,-(a),a,-(b),b); % contact patch area

norm_stress_R = car_weight * weightDistrR/2; 
avg_stress_R = norm_stress_R / Area_patch;

norm_stress_F = car_weight * weightDistrF/2;
avg_stress_F = norm_stress_F / Area_patch;

xx = linspace(-(a+.01),a+.01,50);
yy = linspace(-(b+.01),b+.01,50);

[X,Y] = meshgrid(xx,yy);
stress_distr_Rtire = avg_stress_R*sqrt(1 - (X.^(2*n))./(a^(2*n)) - (Y.^(2*n))./(b^(2*n)) + X./(4*a));
ZR = real(stress_distr_Rtire);
stress_distr_Ftire = avg_stress_F*sqrt(1 - (X.^(2*n))./(a^(2*n)) - (Y.^(2*n))./(b^(2*n)) + X./(4*a));
ZF = real(stress_distr_Ftire);

grid on

% Show Front/Rear Surface Plot
f1 = figure(1);
f1.Name = 'Rear Contact Patch Stress Distribution: Rolling';
f1.MenuBar = 'none';
f1.ToolBar = 'none';
rotate3d on
SR = mesh(X,Y,ZR);
c = colorbar;
c.Label.String = 'Pressure at location on tire';
ylabel('Y (car reference coordinates)')
xlabel('X (car reference coordinates)')

f2 = figure(2);
f2.Name = 'Front Contact Patch Stress Distribution: Rolling';
f2.MenuBar = 'none';
f2.ToolBar = 'none';
rotate3d on
SF = mesh(X,Y,ZF);
c = colorbar;
c.Label.String = 'Pressure at location on tire';
ylabel('Y (car reference coordinates)')
xlabel('X (car reference coordinates)')
