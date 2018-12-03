function [installationRate,displacementOfShock,forceShock] = shockValues(d,r1,r2,phi,z,k,shockLenMax)
    % function takes in d(length from forward trailing arm pivot to upper shock
    % mount), r1(length from forward trailing arm pivot to lower shock
    % pivot), r2(length from forward trailing arm pivot to axle), z(input
    % value for travel, bounded by maximum shock travel)
    
    
    displacementOfShock = shockLenMax - sqrt(d^2 + r1^2 - 2.*d.*r1.*cosd(acosd(z./r2)-phi));
    forceShock = k.*displacementOfShock;
    installationRate = (d*k*r1*sind(phi - acos(z./r2)))./(r2*(1 - z.^2./r2^2).^(1/2).*(d^2 - 2*cosd(phi - acosd(z./r2))*d*r1 + r1^2).^(1/2));
    %k*((-d*r1*sind(Db))./(r2.*sqrt(1 - (z.^2)/(r2^2)).*sqrt(-2*d*r1*cosd(Db)+d+r1)));

end