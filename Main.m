%NOTE: Need Static Data alongside for most recent Bias

Acc = csvread('Ex_4.5m_8Steps/Accelerometer.csv');
Gyr = csvread('Ex_4.5m_8Steps/Gyroscope.csv');
MaF = csvread('Ex_4.5m_8Steps/MagneticField.csv');
[biasAcc, biasGyro] = getSensorsBias();     %Must be new Static Data as Bias changes everyday
t = Acc(:,1); t = (t - t(1)) .* 10^-9;
localAcc = [Acc(:, 2) - biasAcc(1), Acc(:, 3) - biasAcc(2), Acc(:, 4) - biasAcc(3)];
localGyr = [Gyr(:, 2) - biasGyro(1), Gyr(:, 3) - biasGyro(2), Gyr(:, 4) - biasGyro(3)];
localMaF = MaF(:, 2:4);
minSize = min(min(size(localAcc, 1), size(localGyr, 1)), size(localMaF, 1));

g = 9.8062; % Gravity at Champaign
rotMatrix = zeros(3, 3, minSize);
globalAcc = zeros(minSize, 3);

rotMatrix(:, :, 1) = getRotationMatrixFromGravityMagnet(mean(localAcc(1:20, :)), mean(localMaF(1:20, :)));
for i = 2 : minSize
    rotMatrix(:, :, i) = rotMatrix(:, :, i - 1) * getDeltaRotMatrixFromGyro(localGyr(i, :), t(i) - t(i - 1));
    globalAcc(i,:) = (rotMatrix(:,:,i) * localAcc(i,:)')';
end

% For small distance
magNoGZ = globalAcc(:,3) - mean(globalAcc(:,3));
magNoG = globalAcc(:,3) - mean(globalAcc(:,3));

[locs, pks] = countSteps(magNoGZ);
numSteps = (numel(pks) - 1) * 2;
plotSteps(t(1: minSize), magNoG, pks, locs);
% dist = getDistanceFromGlobalAcc(t(1: minSize), globalAcc);
% if(dist > 6) %Starts to diverge beyond 6m distance approx

minPeakHeight = 1.80 * std(magNoG);
[pks,locs] = findpeaks(magNoG, 'MINPEAKHEIGHT', minPeakHeight);
numSteps = (numel(pks) - 1) * 2;


%Reset orientation at every step
locs = cat(1, 1, locs);
for i = 1 : size(locs, 1)
  if i + 1 <= size(locs, 1) % So matrix doesnt exceed dimensions
     for j = locs(i)+1 : locs(i+1)-1 % Integrate gyro in between two locs
        rotMatrix(:, :, j) = rotMatrix(:, :, j - 1) * getDeltaRotMatrixFromGyro(localGyr(j, :), t(j) - t(j - 1));
        newglobalAcc(j,:) = (rotMatrix(:,:,j) * localAcc(j,:)')';
     end
  end
   %Get from acc and mag for every locs
   rotMatrix(:, :, locs(i)) = getRotationMatrixFromGravityMagnet(mean(localAcc(1:20, :)), mean(localMaF(1:20, :))); 
end

WalkDistance = getDistanceFromGlobalAcc(t(1: size(newglobalAcc, 1)), newglobalAcc);
    
%end 
