function dist = getDistanceFromGlobalAcc(time, globalAcc)

velX = cumtrapz(time, globalAcc(:, 1));
velY = cumtrapz(time, globalAcc(:, 2));
distX = trapz(time, velX);
distY = trapz(time, velY);
dist = sqrt(distX^2 + distY^2);