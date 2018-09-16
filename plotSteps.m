function plotSteps(t, magNoGZ, pks, locs)

hold on;
plot(t,magNoGZ);
xlabel('Time (sec)');
ylabel('Acc (m/s^2)');
legend('Z component');
title('Graph of Accelerometer in Testing X');
%minPeakHeight = 1.8 * std(magNoGZ);   % Change 1.78(threshold) to adjust to accuracy
%[pks,locs] = findpeaks(magNoGZ, 'MINPEAKHEIGHT', minPeakHeight);
plot(t(locs), pks, 'r', 'Marker', 'o', 'LineStyle', 'none', 'DisplayName', 'Steps');
hold off;