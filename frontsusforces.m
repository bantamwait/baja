%% front sus forces, steering
% This code assumes that the maximum force (Fexternal) is applied at 90deg
% from the kingpin axis
% max  x-accel = 1.33G
% max y-accel = 1.46G
% max z-accel = 3.24G

% variables
maxg = 1.33;
Fexternal = (320+130)*maxg;
wheelDiam = 23;
rimDiameter = 10;
theta = 10;
tieRodTubeOD = .55;
tieRodTubeID = tieRodTubeOD-.06;
% below: unsupported tube length (used for buckling). AKA maxium length of
% the tie rod tubing with nothing supporting the internal diameter.
Length_tieRod = 10.5; 

rackTubeOD = .75;
rackTubeID = 0;%rackTubeOD-.14;

LeverArm_of_Fexternal = wheelDiam/2;
leverArm_of_uprightTieRodConnection = 1.98;
tieRodLength = 14.23;
rackTubeLength = 6;

F_reactionAtTieRod = Fexternal*(LeverArm_of_Fexternal/leverArm_of_uprightTieRodConnection);
F_reactionAtHub = -Fexternal*((LeverArm_of_Fexternal-leverArm_of_uprightTieRodConnection)/leverArm_of_uprightTieRodConnection);

Ix_tieRod = (pi/64)*(tieRodTubeOD^2 - tieRodTubeID^2);
Ix_rack = (pi/64)*(rackTubeOD^2 - rackTubeID^2);

K = 1; % theoretical. needs safety factor
E_tieRod = 29.7e6; % psi 4130 steel
yeildStress = 63.1e3; % psi 4130 steel

F_alongTieRod = F_reactionAtTieRod*cosd(theta);
F_ax = F_alongTieRod*sind(theta);

RackBendingMoment = F_ax*rackTubeLength;
rackBendStress = .5*tieRodTubeOD*RackBendingMoment/Ix_rack;

MaxRackBendStress = .5*tieRodTubeOD*yeildStress/Ix_rack;
SF_RackBending = MaxRackBendStress/rackBendStress;

tieRodBucklingForce = ((pi*pi*E_tieRod*Ix_tieRod)/(K*Length_tieRod));
SF_tieRodBuckling = tieRodBucklingForce/F_alongTieRod;