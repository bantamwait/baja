%% half-shaft angle calc

% in-board point is set as the origin to make understanding of the inputs
% and outputs easier
inboardPoint = [0 0 0];

% points, here, are 
x = (9.625+.5*1.887)-(9.25+.5*3.691);
y = 14.75;
z = (13 + 13/16) - 17.5;
deltaZmax = 8.75;

outBoardExt = [x y z];
u = outBoardExt;
uprime = [x 0 z];
lengthHS = norm(outBoardExt);

theta = asind((z+deltaZmax)/lengthHS);
y2 = (z+deltaZmax)/tand(theta);

outboardBump = [x y2 z+deltaZmax];
v = outboardBump;
vprime = [x 0 z+deltaZmax];
lengthHS = norm(outboardBump);

deltaAngle = acosd(u*v'/(norm(u)*norm(v)))
angleExt = acosd(u*uprime'/(norm(u)*norm(uprime)))
angleBump = acosd(v*vprime'/(norm(v)*norm(vprime)))
